//
//  PuzzleSolver.swift
//  Sudoku
//
//  Created by dave herbine on 7/16/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

//// define the solve states for a puzzle
enum Found: CustomStringConvertible {
    case none
    case atLeastOne
    case atLeastTwo
    case all
    
    var description: String {
        get {
            switch self {
            case .none:
                return "none"
            case .atLeastOne:
                return "atLeastOne"
            case .atLeastTwo:
                return "atLeastTwo"
            case .all:
                return "all"
            }
        }
    }
}

extension Puzzle {
    
    //
    // solveByCP() essentially feeds assign() which performs constraint propagation.
    //
    func solveByCP(puzzle: PlayerPuzzleStruct) -> PlayerPuzzleStruct {
        
        var cpPuzzle = puzzle
        cpPuzzle.pPuzzle = puzzle.pPuzzle.map { $0.characters.count == 1 ? $0 : digits }     // fill empties with all digits (1...9)
        
        // now assign grid values in order of squareLabels
        for (s, d) in puzzle.pPuzzle.enumerate() {
            // check that d is a given: length of one and in digits (1...9) and assign it
            if d.characters.count == 1 {  //&& digits.rangeOfString(d) != nil {
                assign(&cpPuzzle, key: s, digit: d)
                if cpPuzzle.pState != .valid {  //return if solved or invalid
                    return cpPuzzle
                }
                //println("solveByCP: legal char: \(d) found at key: \(s) in pPuzzle.puzzle, so I'm continuing to solve the puzzle")
            }
        }
        
        //remove any naked or hidden tuples found in any of the units
        if cpPuzzle.pState == .valid {
            //println("solveByCP: Here's your valid parsed puzzle before eliminating naked or hidden tuples:")
            //printPuzzle(cpPuzzle.pPuzzle)
            let algo = Solution(strategy: Tuples())
            cpPuzzle = algo.strategy.tryAlgorithm(cpPuzzle, Found.all)
            //check4Tuples(&cpPuzzle)
        }
        
        //println("solveByCP: Here's your \(cpPuzzle.pState.description) parsed puzzle:")
        //printPuzzle(cpPuzzle.pPuzzle)
        
        return cpPuzzle
    }
    
    
    //
    // assign() eliminates all the values in key except for value.
    //
    func assign(inout assignPuzzle: PlayerPuzzleStruct, key: Int, digit: String) -> PlayerPuzzleStruct {
        
        // assign the value
        var otherValues = assignPuzzle.pPuzzle[key]
        
        // otherValues = all allowable values except value
        let existingIndex = otherValues.rangeOfString(digit)
        if existingIndex != nil {
            otherValues.removeRange(existingIndex!)
        }
        if otherValues.isEmpty {
            //            println("assign: otherValues is empty! key = \(key), digit = \(digit)")
            //            assignPuzzle.pState = .valid
            //            return assignPuzzle
            eliminateDigitFromPeersOfKey(&assignPuzzle, key: key, digit: digit)
        } else {
            for digit in otherValues.characters {
                assignPuzzle = eliminate(&assignPuzzle, key: key, digit: String(digit))
                if assignPuzzle.pState != .valid {
                    //println("assign: solved or invalid return from eliminate, so returning")
                    return assignPuzzle
                }
            }
        }
        
        return assignPuzzle
    }
    
    
    func eliminateDigitFromPeersOfKey(inout ePuzzle: PlayerPuzzleStruct, key: Int, digit: String) -> Bool {
        var wasEliminateCalled = false
        if let peersIndexes = PuzzleLets.globalVar.peersDict[key] {
            //            let unsolvedPeersIndexes = peersIndexes.filter { contains(ePuzzle.pSolvedUnits, $0) == false }
            //            if unsolvedPeersIndexes.isEmpty { return wasEliminateCalled }
            
            //            let unsolvedPeersIndexesGT2 = unsolvedPeersIndexes.filter { count(ePuzzle.pPuzzle[$0]) > 1 && ePuzzle.pPuzzle[$0].rangeOfString(digit) != nil }
            //            if unsolvedPeersIndexesGT2.isEmpty { return ePuzzle }
            
            //            let peersOfKeyWithDigit = unsolvedPeersIndexesGT2.filter { ePuzzle.pPuzzle[$0].rangeOfString(digit) != nil }
            for peer in peersIndexes {
                ePuzzle = eliminate(&ePuzzle, key: peer, digit: digit)
                wasEliminateCalled = true
            }
        } else {
            print("eliminateDigitFromPeersOfKey: could not find key = \(key) in peersDict!")
        }
        return wasEliminateCalled
    }
    
    
    
    //
    // eliminate() eliminates the values in key except for digit.
    //
    func eliminate(inout eliminatePuzzle: PlayerPuzzleStruct, key: Int, digit: String) -> PlayerPuzzleStruct {
        
        var checkIsGridSolved = false
        
        // assign the value
        var otherValues = eliminatePuzzle.pPuzzle[key]
        
        // else eliminate it
        let existingIndex = otherValues.rangeOfString(digit)
        if existingIndex != nil {
            otherValues.removeRange(existingIndex!)
        } else {
            return eliminatePuzzle
        }
        
        // check for contradiction of no otherValues
        if otherValues.isEmpty {
            eliminatePuzzle.pState = .invalid
            return eliminatePuzzle
        }
        
        // update the puzzle with otherValues - digit is now eliminated!
        eliminatePuzzle.pPuzzle[key] = otherValues
        
        // if otherValues is a single digit, then remove it from all its peers
        if otherValues.characters.count == 1 {
            checkIsGridSolved = eliminateDigitFromPeersOfKey(&eliminatePuzzle, key: key, digit: otherValues)
        }
        
        // otherwise, if a unit is reduced to only one place for a value, then put it there
        if let threeIndexes = PuzzleLets.globalVar.indexesOfUnitsDict[key] {
            for oneIndex in threeIndexes {
                if eliminatePuzzle.pSolvedUnits.contains(oneIndex) {
                    //println("eliminate: skipping oneUnit!")
                    continue
                } else {
                    let oneUnit = PuzzleLets.globalVar.unitsArray[oneIndex]
                    var digitPlaces = [Int]()
                    for unitKey in oneUnit {
                        let UnitValues = eliminatePuzzle.pPuzzle[unitKey]
                        if UnitValues.rangeOfString(digit) != nil {
                            digitPlaces.append(unitKey)
                            // performance improvement since only interested if == 1
                            if digitPlaces.count > 1 {
                                break
                            }
                        }
                    }
                    if digitPlaces.isEmpty { // contradiction: no place for this value
                        eliminatePuzzle.pState = .invalid
                        return eliminatePuzzle
                    }
                    if digitPlaces.count == 1 {    // only one place for digit so put it there
                        //println("eliminate: Yay, only one place for \(digit) in oneUnit = \(oneUnit)")
                        eliminatePuzzle = assign(&eliminatePuzzle, key: digitPlaces[0], digit: digit)
                        if eliminatePuzzle.pState != .valid {  //return if solved or invalid
                            return eliminatePuzzle
                        }
                        checkIsGridSolved = true
                    }
                }
            }
        } else {
            print("eliminate: key of \(key) not found in PuzzleLets.globalVar.indexesOfUnitsDict!")
            eliminatePuzzle.pState = .invalid
            return eliminatePuzzle
        }
        
        // update the PuzzleStruct
        if checkIsGridSolved {
            eliminatePuzzle.pState = checkPuzzle(&eliminatePuzzle)
        }
        
        //        println("eliminate: Here's your \(eliminatePuzzle.pState.description) parsed puzzle:")
        //        printPuzzle(eliminatePuzzle.puzzle)
        
        return eliminatePuzzle
    }
    
    //
    // check4Tuples() checks for and eliminates digits of hidden or naked tuples.
    //
    func check4Tuples(inout nPuzzle: PlayerPuzzleStruct) {
        var tupleFound = false
        
        // cycle through the units ... as long as something is found
        repeat {
            tupleFound = false
            
            for (idx, unitL) in PuzzleLets.globalVar.unitsArray.enumerate() {
                if nPuzzle.pSolvedUnits.contains(idx) {
                    continue
                }
                let uVals = unitL.map { nPuzzle.pPuzzle[$0] }
                let unitLState = checkUnit(uVals)
                if unitLState == .solved {
                    //println("findTuples: unit is solved")
                    nPuzzle.pSolvedUnits.append(idx)        // Just added this 3/29/2016
                    continue
                }
                
                //  ... map the unit's keys into their corresponding values ...
                let unitLValues = unitL.map { nPuzzle.pPuzzle[$0] }
                var foundTuples = findTuples(unitLValues, tuple: 2)
                //println("findTuples: foundTuples = \(foundTuples) of \(unitLValues)")
                if foundTuples.isEmpty {
                    continue
                } else {
                    tupleFound = true
                }
                
                for (indx, unitKey) in unitL.enumerate() {
                    if foundTuples[indx] != "" {
                        for char in foundTuples[indx].characters {
                            //println("findTuples: eliminating \(char) from square \(unitKey)")
                            nPuzzle = eliminate(&nPuzzle, key: unitKey, digit: String(char))
                            if nPuzzle.pState != .valid {
                                //println("findTuples: solved or invalid return from eliminate, so returning")
                                return
                            }
                        }
                    } else {
                        continue
                    }
                }
            }
        } while tupleFound
    }
    
    //
    // solve() calls search() to find all solutions to a puzzle.
    //
    func solve(pString: PlayerPuzzleStruct, untilSolutions: Found) -> PlayerPuzzleStruct {
        
        // reduce or possibly solve puzzle with constraint propogation
        let algo = Solution(strategy: ConstraintPropagation())
        var solvePuzzle = algo.strategy.tryAlgorithm(pString, Found.all)
        //var solvePuzzle = solveByCP(pString)
        
//        // check if the puzzle was solved by constraint propagation alone
//        if solvePuzzle.pState == .solved {
//            //update uniquePuzzleSolutions
//            uniquePuzzleSolutions.append(solvePuzzle.pPuzzle)
//            
//            print("solve: Solved by CP!")
//            return solvePuzzle
//        }
        
        solvePuzzle = search(solvePuzzle, untilSolutions: untilSolutions)
        
        if uniquePuzzleSolutions.isEmpty {
            print("solve: Puzzle has no solution!")
            
        } else {
            solvePuzzle.pPuzzle = uniquePuzzleSolutions[0]
            solvePuzzle.pState = .solved
            //println("solve: Solved by DF Search! Unique solution count = \(count(uniquePuzzleSolutions)) and here's the first one:")
            //printPuzzle(uniquePuzzleSolutions[0])
        }
        
        //print("solve: uniquePuzzleSolutions.count = \(uniquePuzzleSolutions.count)")
        
        return solvePuzzle
    }
    
    
    //
    // search() controls the depth-first search and passes to some() which recursively calls search().
    //
    func search(searchPuzzle: PlayerPuzzleStruct, untilSolutions: Found) -> PlayerPuzzleStruct {
        
        switch searchPuzzle.pState {
            
        case .solved, .solvedDF:
            //println("search: returning because puzzle is solved")
            return searchPuzzle
            
        case .invalid:
            //println("search: returning because of invalid input")
            return searchPuzzle
            
        case .valid:
            if uniquePuzzleSolutions.isEmpty || untilSolutions == Found.all || (uniquePuzzleSolutions.count <= 2 && untilSolutions != Found.all) {
                // get square with minimimu remaining values
                let mrv = getMRV(searchPuzzle.pPuzzle)
                //println("search: getMRV() returned index: \(mrv.square!) and value: \(mrv.values!)")
                if mrv.square != nil && mrv.values != nil {
                    return some(searchPuzzle, s: mrv.square!, vals: mrv.values!, untilSolutions: untilSolutions)
                } else {
                    print("search: getMRV() returned nil")
                }
            }

        }
        return searchPuzzle
    }
    
    //
    // getMRV returns the square and it's values representing the minimum remaining values
    //
    func getMRV(grid: [String]) -> GridMRV {
        
        // initialize mrv.values to something that will ensure replacement or indicate no values of 2...9 were found
        var mrv = GridMRV(square: nil, values: nil)
        
        // cycle through the puzzle
        for (idx, values) in grid.enumerate() {
            switch values.characters.count {
            case 1:
                continue
            case 2:
                mrv = GridMRV(square: idx, values: values)
                return mrv
            case 3...9:
                if mrv.values == nil {
                    mrv = GridMRV(square: idx, values: values)
                } else {
                    if values.characters.count < mrv.values!.characters.count {
                        mrv = GridMRV(square: idx, values: values)
                    }
                }
            default:
                print("getMRV: unexpected count of \(values.characters.count) in switch statement for value: \(values) in square: \(idx)")
                //printGrid(grid)
                mrv = GridMRV(square: idx, values: values)
                return mrv
            }
        }
        return mrv
        
    }
    
    //
    // some() calls search() for each of the minimum remaining values of a square.
    //
    func some( somePuzzle: PlayerPuzzleStruct, s: Int, vals: String, untilSolutions: Found) -> PlayerPuzzleStruct {
        
        var copyPuzzles = [PlayerPuzzleStruct](count: vals.characters.count, repeatedValue: somePuzzle)
        
        for (idx, digit) in vals.characters.enumerate() {
            //println("some: trying digit: \(digit)")
            copyPuzzles[idx] = search(assign(&copyPuzzles[idx], key: s, digit: String(digit)), untilSolutions: untilSolutions)
        }
        
        for copyPuzzle in copyPuzzles {
            switch copyPuzzle.pState {
            case .invalid:
                //println("some: got a DF search invalid solution!")
                //return copyPuzzle     // returning the bad puzzle prevents the solution from being found!
                continue
                
            case .valid:
                //println("some: got a DF search valid solution:")
                //return copyPuzzle     // returning the valid puzzle prevents ALL solutions from being found!
                continue
                
            case .solved, .solvedDF:
                //println("some: got a DF search solution:")
                //printPuzzle(copyPuzzle.puzzle)
                // check to see if it is a unique solution and, if so, add to the array of solutions
                if uniquePuzzleSolutions.isEmpty {
                    uniquePuzzleSolutions.append(copyPuzzle.pPuzzle)
                } else {
                    
                    var doesSolutionAlreadyExist = false
                    for solvedPuzzle in uniquePuzzleSolutions {
                        // check to see if it is a different solution and, if so, add it to the collection
                        if solvedPuzzle == copyPuzzle.pPuzzle {
                            doesSolutionAlreadyExist = true
                            break
                        }
                    }
                    if !doesSolutionAlreadyExist {
                        uniquePuzzleSolutions.append(copyPuzzle.pPuzzle)
                    }
                }
                //println("some: DF search found \(count(uniquePuzzleSolutions)) unique solution(s)")
                
            }
        }
        
        copyPuzzles.removeAll()
        return somePuzzle
        
    }
    
}