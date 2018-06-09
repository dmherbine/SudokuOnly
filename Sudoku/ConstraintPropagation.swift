//
//  ConstraintPropagation.swift
//  Sudoku
//
//  Created by dave herbine on 3/20/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import Foundation

//
// solveByConstraintPropagation() essentially feeds assign() which performs constraint propagation.
//
class ConstraintPropagation: SolutionStrategy {

    var uniqueSolutions = [[String]]()    // array of arrays and has to be a class property
    
    var algorithm: String? = "One Rule"
    var eliminates = [String](repeating: "", count: 81)
    var allPairs: [Cell]? = nil
    var reducibleNakedPairs: [Cell]? = nil
    var reducibleHiddenPairs: [Cell]? = nil
    var cpAssigns = [Cell]()
    var algoEliminates: [AlgoEliminates]? = nil
    var algoAssigns: [AlgoAssigns]? = nil
    var pzzlSet = PzlSet()
    
    func  tryAlgo(_ pzl: PzlSet, _ dfGoal: DFGoal?, _ pairs: [Cell]?) -> PzlSet {
        pzzlSet = pzl
        
        // Check if the puzzle actually needs to be solved
        if pzzlSet.isPuzzleSolved() {
            pzzlSet.state = .solved
            uniqueSolutions.append(pzzlSet.playerAnswered)
            print("CP: tryAlgo: supplied puzzle is solved!")
            return pzzlSet
        }
        if pzzlSet.state == .invalid {
            return pzzlSet
        }
        
        pzzlSet = solveByConstraintPropagation(pzl)
        if pzzlSet.state == .solved {
            pzzlSet.solvingAlgorithm = .solvedByCP
            uniqueSolutions.append(pzzlSet.playerAnswered)
        }
        return pzzlSet
    }
    
    func solveByConstraintPropagation(_ puzzle: PzlSet) -> PzlSet {
        
        var cpPuzzle = puzzle
        
        // First, fill holes in playerAnswered with corresponding allCandidates value
        cpPuzzle.playerAnswered = puzzle.playerAnswered.enumerated().map() { $0.1 == "" ? puzzle.allCandidates[$0.0] : $0.1 }
        // It's possible I just solved the puzzle. If so, set cpAssigns and return
        if cpPuzzle.playerAnswered.filter({ $0.count != 1 }).count == 0 {
            //print("solveByConstraintPropagation: puzzle solved from allCandidates so simply returning!")
            cpPuzzle.state = .solved
            let cpAssignsOffsets = puzzle.allCandidates.enumerated().filter({ $0.1.count == 1 }).map({$0.offset})
            for idx in cpAssignsOffsets {
                // Exclude original puzzle playeredAnswered/givens from cpAssigns
                if pzzlSet.playerAnswered[idx] != puzzle.allCandidates[idx] {
                    populateCPAssigns(idx, puzzle.allCandidates[idx], nil, cpPuzzle)
                }
            }
            return cpPuzzle
        }
        // Safeguard against allCandidates not being set (see first step)
        cpPuzzle.playerAnswered = puzzle.playerAnswered.map { $0.count == 1 ? $0 : "123456789" }     // fill empties with all digits (1...9)
        //print("solveByConstraintPropagation: cpPuzzle.playerAnswered to be fed to assign() for each answered digit")
        //printPuzzle(cpPuzzle.playerAnswered)
        
        // now assign grid values in order of squareLabels
        let playerAnsweredCells = convertPlayerPuzzleToCells(puzzle.playerAnswered)
        for cell in playerAnsweredCells {
            //print("solveByConstraintPropagation: calling assign(key: \(s), digit: \(d))")
            _ = assign(&cpPuzzle, key: cell.square, digit: cell.value, nil)
            if cpPuzzle.state != .valid {  //return if solved or invalid
                //print("CP: solveByConstraintPropagation: returning to tryAlgo with puzzle.state of \(cpPuzzle.state)")
                return cpPuzzle
            }
        }
        
        //print("solveByConstraintPropagation: Here's your \(cpPuzzle.pState.description) parsed puzzle:")
        //printPuzzle(cpPuzzle.pPuzzle)
        
        return cpPuzzle
    }
    
    func convertPlayerPuzzleToCells(_ pzl: [String]) -> [Cell] {
        var returnCells = [Cell]()
        let answeredOnly = pzl.enumerated().map({Cell(i: $0.offset, e: $0.element)}).filter({ $0.value.count == 1 })
        returnCells = answeredOnly.sorted { (cell1, cell2) -> Bool in
            return cell1.compare(cell2) }
        if globalKPD != nil {
            let answeredOnlySortedKPD = returnCells.filter(){ $0.value == globalKPD }
            let answeredOnlySortedNotKPD = returnCells.filter(){ $0.value != globalKPD }
            returnCells = answeredOnlySortedKPD + answeredOnlySortedNotKPD
        }
        return returnCells
    }


    //
    // assign() eliminates all the values in key except for value.
    //
    func assign(_ assignPuzzle: inout PzlSet, key: Int, digit: String, _ squares: [Int]?) -> PzlSet {
        
        //print("assign: entered with key = \(key), digit = \(digit), squares = \(squares)")
        // exclude original puzzle playeredAnswered/givens
        if assignPuzzle.playerAnswered.filter({ $0 != "" }).count > 0 && squares != nil {
            if assignPuzzle.playerAnswered[key] != digit {
                //print("assign1: populate(aSquare: \(key), aDigit: \(digit), squares: \(squares))")
                populateCPAssigns(key, digit, squares, assignPuzzle)
            }
        }

        // assign the value
        var otherValues = assignPuzzle.playerAnswered[key]
        
        // otherValues = all other values except digit
        let existingIndex = otherValues.range(of: digit)
        if existingIndex != nil {
            otherValues.removeSubrange(existingIndex!)
        }
        if otherValues.isEmpty {
            if let keyPeerSquares = PuzzleLets.globalVar.peersDict[key] {
                //print("assign3: eliminateFromPeers(key: \(key), digit: \(digit), squares: \(keyPeerSquares))")
                eliminateDigitFromPeersOfKey(&assignPuzzle, key: key, digit: digit, keyPeerSquares)
            } else {
                //print("assign3: could not find key = \(key) in peersDict!")
            }
        } else {
            for digit in otherValues {
                //print("assign4: eliminate(key: \(key), digit: \(digit), squares: \(squares))")
                assignPuzzle = eliminate(&assignPuzzle, key: key, digit: String(digit), squares)
                if assignPuzzle.state != .valid {
                    //print("CP: assign: returning with puzzle state = \(assignPuzzle.state)")
                    return assignPuzzle
                }
            }
        }
        return assignPuzzle
    }


    //
    // eliminate() eliminates the values in key except for digit.
    //
    func eliminate(_ eliminatePuzzle: inout PzlSet, key: Int, digit: String, _ squares: [Int]?) -> PzlSet {
        var checkIsGridSolved = false
        
        // get all the values from the key, possibly including the digit
        var otherValues = eliminatePuzzle.playerAnswered[key]
        
        // check for contradiction or nothing to eliminate for special case of otherValues.characters.count == 1
        if otherValues.count <= 1 {
            if otherValues == digit {
                //print("eliminate: contradiction, returning invalid")
                eliminatePuzzle.state = .invalid
                return eliminatePuzzle
            } else {
                //print("eliminate: \"\(digit)\" not equal to \"\(otherValues)\", so returning")
                return eliminatePuzzle
            }
        }
        
        // otherwise, otherValues.characters.count >= 2, so check to see if it contains digit and eliminate it if found
        if let existingIndex = otherValues.range(of: digit) {
            otherValues.removeSubrange(existingIndex)
        } else {
            //print("eliminate: \"\(digit)\" not found in \"\(otherValues)\", so returning")
            return eliminatePuzzle
        }
        
        // update the puzzle with otherValues - digit is now eliminated!
//        eliminatePuzzle.playerAnswered[key] = otherValues
        
        // if otherValues has been reduced to a single digit, then remove it from all its peers
        if otherValues.count == 1 {
            if let keyPeerSquares = PuzzleLets.globalVar.peersDict[key] {
                let keyPeerSquaresPlus = keyPeerSquares + [key] // This is so highlighting the peers also includes the key

                //print("eliminate1: eliminateFromPeers(key: \(key), digit: \(otherValues), squares: \(keyPeerSquares))")
                populateCPAssigns(key, otherValues, keyPeerSquaresPlus, eliminatePuzzle)
                eliminatePuzzle.playerAnswered[key] = otherValues
                eliminateDigitFromPeersOfKey(&eliminatePuzzle, key: key, digit: otherValues, keyPeerSquares)
            } else {
                print("eliminate: could not find key = \(key) in peersDict!")
            }
        } else {
            eliminatePuzzle.playerAnswered[key] = otherValues
        }
        
        // if a unit is reduced to only one place for a value, then put it there
        if let threeIndexes = PuzzleLets.globalVar.indexesOfUnitsDict[key] {
            for oneIndex in threeIndexes {
                if eliminatePuzzle.solvedUnits.contains(oneIndex) {
                    //print("eliminate: skipping oneUnit!")
                    continue
                } else {
                    let oneUnit = PuzzleLets.globalVar.unitsArray[oneIndex]
                    var digitPlaces = [Int]()
                    for unitKey in oneUnit {
                        let UnitValues = eliminatePuzzle.playerAnswered[unitKey]
                        if UnitValues.range(of: digit) != nil {
                            digitPlaces.append(unitKey)
                            // performance improvement since only interested in count == 1
                            if digitPlaces.count > 1 { break }
                        }
                    }
                    if digitPlaces.isEmpty { // contradiction: no place for this value
                        eliminatePuzzle.state = .invalid
                        return eliminatePuzzle
                    }
                    if digitPlaces.count == 1 && eliminatePuzzle.playerAnswered[key] != digit {    // only one place for digit so put it there if not already
                        //print("eliminate2: assign(key: \(digitPlaces[0]), digit: \(digit), squares: \(oneUnit)")
                        eliminatePuzzle = assign(&eliminatePuzzle, key: digitPlaces[0], digit: digit, oneUnit)
                        if eliminatePuzzle.state != .valid {  //return if solved or invalid
                            return eliminatePuzzle
                        }
                        checkIsGridSolved = true
                    }
                }
            }
        } else {
            print("eliminate: key of \(key) not found in PuzzleLets.globalVar.indexesOfUnitsDict!")
            eliminatePuzzle.state = .invalid
            return eliminatePuzzle
        }
    
        // update the PuzzleStruct
        if checkIsGridSolved {
            eliminatePuzzle.state = checkPuzzle(&eliminatePuzzle)
        }
        
        //        print("eliminate: Here's your \(eliminatePuzzle.pState.description) parsed puzzle:")
        //        printPuzzle(eliminatePuzzle.puzzle)
        
        return eliminatePuzzle
    }
    
    func eliminateDigitFromPeersOfKey(_ ePuzzle: inout PzlSet, key: Int, digit: String, _ squares: [Int]?) {
        if squares == nil {
            print("eliminateDigitFromPeersOfKey: peers are nil, so returning!")
            return
        }
        for peer in squares! {
            ePuzzle = eliminate(&ePuzzle, key: peer, digit: digit, squares)
        }
        return
    }
    
    func populateCPAssigns(_ aSquare: Int, _ aDigit: String, _ squares: [Int]?, _ pzl: PzlSet) {
        //print("\n\n populateCPAssigns: entered with aSquare = \(aSquare), aDigit = \(aDigit), and ...")
        //print("populateCPAssigns: squares = \(squares)")
        var hSquares: [Int]? = squares
        
        // try to find something if squares is nil.
        if hSquares == nil {
            if let mutableSquares = getSolvedUnitContainingSquare(aSquare, aDigit, pzl) {
                //print("populateCPAssigns: solved square found from nil!")
                hSquares = mutableSquares
            } else {
                // need to ensure something, so it will be the peers of aSquare
                if let keyPeerSquares = PuzzleLets.globalVar.peersDict[aSquare] {
                    //print("populateCPAssigns: squares is peers!")
                    hSquares = keyPeerSquares + [aSquare]   // This is so highlighting the peers also includes aSquare
                } else {
                    print("populateCPAssigns: squares is nil!")
                    return
                }
            }
        } else if hSquares!.count > 19 {    // try to reduce to a unit if squares is all peers (there are 20 peers)
            //print("populateCPAssigns: about to check for solved square found from peers!")
            if let mutableSquares = getSolvedUnitContainingSquare(aSquare, aDigit, pzl) {
                //print("populateCPAssigns: solved square found from peers!")
                hSquares = mutableSquares
            }
        }
        //print("populateCPAssigns: hSquares = \(hSquares)\n\n")
        
        let aCell = Cell(i: aSquare, e: aDigit)
        if algoAssigns == nil {
            algoAssigns = [AlgoAssigns]()
        } else {
            // ensure no duplicates
            for anAssign in algoAssigns! {
                if anAssign.assignCell == aCell { return }
            }
        }

        // create array of highlight Help Cells
        var highlightHelpCells = [HelpCell]()
        for square in hSquares! {
            if square == aSquare {
                highlightHelpCells.append(HelpCell(sq: square, ans: aDigit, del: "", alg: ""))
            } else {
                highlightHelpCells.append(HelpCell(sq: square, ans: "", del: aDigit, alg: ""))
            }
        }

        let newElement = AlgoAssigns(aCell: aCell, hhCells: highlightHelpCells, aAlgo: algorithm!)
        //print("populateCPAssigns: newElement = \(newElement)")
        algoAssigns?.append(newElement)
        cpAssigns.append(aCell)
    }
    
    // find a unit to highlight for AlgoAssigns or pass in nil
    func getSolvedUnitContainingSquare(_ s: Int, _ d: String, _ pzl: PzlSet) -> [Int]? {
        if let threeIndexes = PuzzleLets.globalVar.indexesOfUnitsDict[s] {    // [r,c,b]
            //print("getSolvedUnitContainingSquare: threeIndexes of \(s) = \(threeIndexes)")
            var bestChoice: [Int]? = nil
            for oneIndex in threeIndexes {
                let oneUnit = PuzzleLets.globalVar.unitsArray[oneIndex]
                //print("getSolvedUnitContainingSquare: oneUnit = \(oneUnit)")
                //let playerAnswered = oneUnit.map() { pzl.playerAnswered[$0] }
                //print("getSolvedUnitContainingSquare: playerAnswered[oneUnit] = \(playerAnswered)")

                // skip oneUnit where d is already answered
//                let dAlreadyAnswered = oneUnit.filter() { pzl.playerAnswered[$0] == d }
//                if dAlreadyAnswered.count >= 1 { continue }

                // return oneUnit if it is only missing d to be solved - this is the best scenario so return immediately
                var oneUnitAnswered = oneUnit.filter() { pzl.playerAnswered[$0].count == 1 }
                if oneUnitAnswered.count == 8 {
                    //print("getSolvedUnitContainingSquare: only 1 unanswered square in \(oneUnitAnswered.map({pzl.playerAnswered[$0]})) for \(d)")
                    return oneUnit
                }

                // return oneUnit if it has only square for d - this is the second best scenario so save it for now
                oneUnitAnswered = oneUnit.filter() { pzl.allCandidates[$0].contains(d) }
                if oneUnitAnswered.count == 1 {
                    //print("getSolvedUnitContainingSquare: only one square in allCandidates \(oneUnitAnswered.map({pzl.playerAnswered[$0]})) contains \(d)")
                    //return oneUnit
                    bestChoice = oneUnit
                }

                // return oneUnit if it has a square containing a single candidate and that candidate is d - this is the least best scenario but save it for now
                for one in oneUnitAnswered {
                    let values = pzl.allCandidates[one]
                    if values.contains(d) && values.count == 1 {
                        //print("getSolvedUnitContainingSquare: only \(d) found in a square of allCandidates \(oneUnitAnswered.map({pzl.playerAnswered[$0]}))")
                        //return oneUnit
                        if bestChoice == nil { bestChoice = oneUnit }
                    }
                }
            }
            return bestChoice
        } else {
            print("getSolvedUnitContainingCell: PuzzleLets.globalVar.indexesOfUnitsDict[\(s)] not found!")
        }
        return nil
    }
    
}



