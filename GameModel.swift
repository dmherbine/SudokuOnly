//
//  GameModel.swift
//  Sudoku
//
//  Created by dave herbine on 2/22/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

class Game {
    
    fileprivate var puzzleStack = GameStack()
    fileprivate var puzzle = Puzzle()

    var gamePuzzles = PzlSet()
    var savedName: String? = nil
    var favName: String = ""
    
    init (challenge: Int) {
        gamePuzzles = puzzle.getPuzzlesWithChallenge(challenge)
        _ = puzzleStack.pushPuzzlesOnStack(gamePuzzles)
        print("New Game: init: given, solution, allCandidates, playerCandidates, playerAnswered, state = \(gamePuzzles.state), solvedUnits = \(gamePuzzles.solvedUnits), solvingAlgorithm = \(String(describing: gamePuzzles.solvingAlgorithm)), challenge = \(challenge)")
//        print("New Game: init: gamePuzzles = \(gamePuzzles)")
//        printPuzzle(gamePuzzles.given)
//        printPuzzle(gamePuzzles.solution)
//        printPuzzle(gamePuzzles.allCandidates)
//        printPuzzle(gamePuzzles.playerCandidates)
//        printPuzzle(gamePuzzles.playerAnswered)
    }
    
    init (savedGames: [SavedGame]) {
        //print("Game: init: savedGames.count = \(savedGames.count)")
        for savedGame in savedGames {
            gamePuzzles = savedGame.pSet
            _ = puzzleStack.pushPuzzlesOnStack(gamePuzzles)
        }
        print("Saved Game: init: given, solution, allCandidates, playerCandidates, playerAnswered, state = \(gamePuzzles.state), solvedUnits = \(gamePuzzles.solvedUnits), solvingAlgorithm = \(String(describing: gamePuzzles.solvingAlgorithm)), challenge = \(savedGames.last!.pSet.cLevel)")
//        printPuzzle(gamePuzzles.given)
//        printPuzzle(gamePuzzles.solution)
//        printPuzzle(gamePuzzles.allCandidates)
//        printPuzzle(gamePuzzles.playerCandidates)
//        printPuzzle(gamePuzzles.playerAnswered)
    }
    
    init (favoriteGame: PersistFavGames) {
        favName = favoriteGame.sFavName
        favoriteGame.pSet.playerAnswered = favoriteGame.pSet.given
        favoriteGame.pSet.solvedUnits = [Int]()     // not sure if I need to do this, or if it matters
        favoriteGame.pSet.allCandidates = puzzle.generateAllCandidatesFromAnswered(favoriteGame.pSet)
        gamePuzzles = favoriteGame.pSet
        _ = puzzleStack.pushPuzzlesOnStack(gamePuzzles)
        print("Favorite Game: init: given, solution, allCandidates, playerCandidates, playerAnswered, state = \(gamePuzzles.state), solvedUnits = \(gamePuzzles.solvedUnits), solvingAlgorithm = \(String(describing: gamePuzzles.solvingAlgorithm)), challenge = \(favoriteGame.pSet.cLevel)")
        //        printPuzzle(gamePuzzles.given)
        //        printPuzzle(gamePuzzles.solution)
        //        printPuzzle(gamePuzzles.allCandidates)
        //        printPuzzle(gamePuzzles.playerCandidates)
        //        printPuzzle(gamePuzzles.playerAnswered)
    }
    
    init (GivenGame: PzlSet) {
        gamePuzzles = GivenGame
        gamePuzzles.allCandidates = puzzle.generateAllCandidatesFromAnswered(GivenGame)
        _ = puzzleStack.pushPuzzlesOnStack(gamePuzzles)
        print("Given Game: init: given, solution, allCandidates, playerCandidates, playerAnswered, state = \(gamePuzzles.state), solvedUnits = \(gamePuzzles.solvedUnits), solvingAlgorithm = \(String(describing: gamePuzzles.solvingAlgorithm)), challenge = \(gamePuzzles.cLevel)")
        //        printPuzzle(gamePuzzles.given)
        //        printPuzzle(gamePuzzles.solution)
        //        printPuzzle(gamePuzzles.allCandidates)
        //        printPuzzle(gamePuzzles.playerCandidates)
        //        printPuzzle(gamePuzzles.playerAnswered)
    }
    
    func popFromGameStack() -> PzlSet? {
        if let lastPuzzle = puzzleStack.popPuzzlesFromStack() {
            //gamePuzzles = lastPuzzle
            return lastPuzzle   //gamePuzzles
        }
        return nil
    }
    
    func getStackDepth() -> Int {
        return puzzleStack.getPuzzlesStackDepth()
    }
    
    func getCellInfo(_ idx: Int) -> (type: cellContent, contents:String) {
        var safeIdx = idx
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("getCellInfo: Illegal puzzle index of \(idx), so setting it to 0!")
            safeIdx = 0
        }
        if isCellGiven(safeIdx) {
            return (cellContent.given, gamePuzzles.given[safeIdx])
        } else if isCellAnswered(safeIdx) {
            return (cellContent.answered, gamePuzzles.playerAnswered[safeIdx])
        } else if gamePuzzles.playerCandidates[safeIdx] != "" {
            return (cellContent.playerCandidate, gamePuzzles.playerCandidates[safeIdx])
        }
        return (cellContent.allCandidate, gamePuzzles.allCandidates[safeIdx])

    }
    
    func isCellGiven(_ idx: Int) -> Bool {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            return true     // true will prevent me from trying to read the playerPuzzle
        } else {
            return !gamePuzzles.given[idx].isEmpty
        }
    }
    
    func isCellAnswered(_ idx: Int) -> Bool {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("isCellAnswered: idx of \(idx) is out or range of playerpzl.count-1 of \(gamePuzzles.playerAnswered.count-1)")
            return true     // true will prevent me from trying to update the playerPuzzle
        } else {
            //print("isCellAnswered: gamePuzzles.playerAnswered[idx] = \(gamePuzzles.playerAnswered[idx]), isEmpty = \(gamePuzzles.playerAnswered[idx].isEmpty)")
            return !gamePuzzles.playerAnswered[idx].isEmpty
        }
    }
    
    func setCellAnswered(_ idx: Int, answerDigit: String) {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("setCellAnswered: idx of \(idx) is out of range!")
            return
        } else if answerDigit.count != 1 {
            print("setCellAnswered: answer of \(answerDigit) is not singular!")
            return
        }
        
        gamePuzzles.playerAnswered[idx] = answerDigit
        _ = puzzleStack.pushPuzzlesOnStack(gamePuzzles)
        
        return
    }
    
    func setCellUnanswered(_ idx: Int) {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("setCellAnswered: idx of \(idx) is out of range!")
        } else {
            gamePuzzles.playerAnswered[idx] = ""
            _ = puzzleStack.pushPuzzlesOnStack(gamePuzzles)
        }
        return
    }
    
    //
    // removeAnswerAtIndexFromPeers() returns an array of indexes that were modified
    //
    func removeAnswerAtIndexFromPeers(_ idx: Int) -> [Int] {
        var updatedPeers = [Int]()
        
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("removeAnswerAtIndexFromPeers: idx of \(idx) is out of range!")
            return updatedPeers
        } else if gamePuzzles.playerAnswered[idx].isEmpty {
            print("removeAnswerAtIndexFromPeers: idx of \(idx) is not answered!")
            return updatedPeers
        }
        
        if let peersIndexes = PuzzleLets.globalVar.peersDict[idx] {
            let peersValues = peersIndexes.map { self.gamePuzzles.playerAnswered[$0] }
            for (peerIdx, peerValue) in peersValues.enumerated() {
                let existingIndex = peerValue.range(of: gamePuzzles.playerAnswered[idx])
                if existingIndex != nil {
                    var mutablePeerValue = peerValue
                    mutablePeerValue.removeSubrange(existingIndex!)
                    
                    // taking advantage that indexes of peersIndexes and peersValues are equally ordered
                    let updatedPeerIndex = peersIndexes[peerIdx]
                    gamePuzzles.playerAnswered[updatedPeerIndex] = mutablePeerValue
                    
                    // add the updated index to the return array
                    updatedPeers.append(updatedPeerIndex)
                }
            }
            // Replace puzzleStack with updated playerPuzzle
            _ = puzzleStack.replacePuzzlesOnStack(gamePuzzles)
        } else {
            print("removeAnswerAtIndexFromPeers: peersDict[\(idx)] is nil!")
            return updatedPeers
        }
        
        return updatedPeers
        
    }
    
    func setPlayerCandidatesWithDigits(_ idx: Int, digits: String) -> Int {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("setPlayerCandidatesWithDigits: idx of \(idx) and digits of \(digits) is out of range!")
            return puzzleStack.getPuzzlesStackDepth()    // may allow the game to continue
        }

        gamePuzzles.playerCandidates[idx] = digits
        _ = puzzleStack.pushPuzzlesOnStack(gamePuzzles)
        return puzzleStack.getPuzzlesStackDepth()
    }
        
    func doesCellAtIndexContainDigits(_ idx: Int, _ digits: String?, _ candidateCntrl: Int) -> Bool {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("doesCellAtIndexContainDigits: idx of \(idx) is out of range!")
            return false    // may allow the game to continue
        }
        if digits == nil {
            //print("doesCellAtIndexContainDigits: digits is nil!")
            return false    // This happens frequently when cycling through collectionView's visible cells
        }
        if let cellContentsAtIndex = getCellWithIndex(idx, candidateCntrl: candidateCntrl) {
            for digit in digits! {
                if !cellContentsAtIndex.contains(String(digit)) { return false }
            }
            return true
        } else {
            return false
        }
    }

        func getCellWithIndex(_ idx: Int, candidateCntrl: Int) -> String? {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("getCellWithIndex: idx of \(idx) is out of range!")
            return nil    // may allow the game to continue
        }
        
        switch candidateCntrl {
        case 0:
            if gamePuzzles.playerAnswered[idx] == "" {
                return nil
            } else {
                return gamePuzzles.playerAnswered[idx]
            }
        case 1:
            if gamePuzzles.playerAnswered[idx] != "" {
                //print("getCellWithIndex: Case 1: returning answered \(gamePuzzles.playerAnswered[idx])")
                return gamePuzzles.playerAnswered[idx]
            } else if gamePuzzles.playerCandidates[idx] != "" {
                //print("getCellWithIndex: Case 1: returning playerCandidates \(gamePuzzles.playerCandidates[idx])")
                return gamePuzzles.playerCandidates[idx]
            } else {
                //print("getCellWithIndex: Case 1: returning nil!")
                return nil
            }
        case 2:
            if gamePuzzles.playerAnswered[idx] != "" {
                //print("getCellWithIndex: Case 2: returning answered \(gamePuzzles.playerAnswered[idx])")
                return gamePuzzles.playerAnswered[idx]
            } else if gamePuzzles.allCandidates[idx] != "" {
                //print("getCellWithIndex: Case 2: returning allCandidates \(allCandidates[idx])")
                return gamePuzzles.allCandidates[idx]
            } else {
                //print("getCellWithIndex: Case 2: returning nil!")
                return nil
            }
        default:
            print("getCellWithIndex: candidateCntrl changed to unexpected value: \(candidateCntrl)")
            return nil
        }
    }
    
    func findAllCellsWith(_ digits: String) -> [Int] {
        var idxArray = [Int]()
        
        for (idx, cellVals) in gamePuzzles.playerAnswered.enumerated() {
            if cellVals.range(of: digits) != nil {
                idxArray.append(idx)
            }
        }

        return idxArray
    }
    
    func isAnswerCorrect(_ idx: Int) -> Bool {
        if idx < 0 || idx > PuzzleLets.globalVar.numberOfSquares {
            print("isAnswerCorrect: idx of \(idx) is out of range!")
            return false    // may allow the game to continue
        }

        return gamePuzzles.solution[idx] == gamePuzzles.playerAnswered[idx]
    }
        
    func getSolvedDigits() -> String {
        var solvedDigits = ""
        
        for digit in "123456789" {
            let digitArray = gamePuzzles.playerAnswered.filter { $0 == String(digit) }
            if digitArray.count == 9 {
                solvedDigits += String(digit)
            }
        }
        //print("getSolvedDigits: solvedDigits = \(solvedDigits)")
        return solvedDigits
    }
    
    func isValidCandidate(_ candidate: String, _ square: Int) -> Bool {
        if gamePuzzles.allCandidates[square].range(of: candidate) == nil {
            return false
        }
        return true
    }
        
    func getIndexesOfUnanswered() -> [Int] {
        return puzzle.getIndexesOfUnvaluedFrom(gamePuzzles.playerAnswered)
    }
    
    func getAllCandidates(_ pSet: PzlSet) -> [String] {        
        return puzzle.generateAllCandidatesFromAnswered(pSet)
    }
    
    func getUpdatedAllCandidatesIndexes(_ selectedCell: Int) -> [Int] {
        
        return puzzle.updateAllCandidatesFromAnswered(&gamePuzzles.allCandidates,
                                                      answered: gamePuzzles.playerAnswered,
                                                      selectedCell: selectedCell)
    }
    
    func getUpdatedPlayerCandidatesIndexes(_ selectedCell: Int) -> [Int] {
        
        return puzzle.updatePlayerCandidatesFromAnswered(&gamePuzzles.playerCandidates,
                                                 answered: gamePuzzles.playerAnswered,
                                                 selectedCell: selectedCell)
    }
    
    func getBadAnswers() -> [Cell]? {
        let valuedAnsTuples = gamePuzzles.playerAnswered.enumerated().map({Cell(i: $0.offset, e: $0.element)}).filter() { $0.value != "" }
        let badAnsTuples = valuedAnsTuples.filter() { $0.value != gamePuzzles.solution[$0.square] }
        if badAnsTuples.count == 0 {
            return nil
        }
        return badAnsTuples
    }

    func getBadPlayerCandidates() -> [Cell]? {
        var badPlayerCandidatesStr = [Cell]()
        let valuedPlayerCandidateTuples = gamePuzzles.playerCandidates.enumerated().map({Cell(i: $0.offset, e: $0.element)}).filter() { $0.value != "" }
        let badPlayerCandidateTuples = valuedPlayerCandidateTuples.filter() { $0.value != gamePuzzles.allCandidates[$0.square] }
        for badPlayerCandidate in badPlayerCandidateTuples {
            let badPlayerCandidateChars = badPlayerCandidate.value.filter() { gamePuzzles.allCandidates[badPlayerCandidate.square].range(of: String($0)) == nil }
            //print("getBadPlayerCandidates: badPlayerCandidateChars = \(badPlayerCandidateChars)")
            if badPlayerCandidateChars.count < 1 {
                continue        // skip if none found
            }
            let badPlayerCandidateStr = badPlayerCandidateChars.reduce("",{String($0) + String($1)})
            //print("badPlayerCandidateStr = \(badPlayerCandidateStr)")
            badPlayerCandidatesStr.append(Cell(i: badPlayerCandidate.square, e: badPlayerCandidateStr))
            //print("badPlayerCandidateChars = \(badPlayerCandidateChars), badPlayerCandidateStr = \(badPlayerCandidateStr)")
        }
        if badPlayerCandidatesStr.count == 0 {
            return nil
        }
        return badPlayerCandidatesStr
    }
    
    func getSingularAllCandidates() -> [Cell]? {
        let singularAllCandidatesTuples = gamePuzzles.allCandidates.enumerated().map({Cell(i: $0.offset, e: $0.element)}).filter() { $0.value.count == 1 }
        if singularAllCandidatesTuples.count == 0 {
            return nil
        }
        return singularAllCandidatesTuples
    }
    
    //
    // getSingularPlayerCandidates() returns an array of items where each item's element is singular in both player and puzzle candidates
    //
    func getSingularPlayerCandidates() -> [Cell]? {
        var singularPlayerCandidatesStr = [Cell]()
        let singularPlayerCandidatesTuples = gamePuzzles.playerCandidates.enumerated().map({Cell(i: $0.offset, e: $0.element)}).filter() { $0.value.count == 1 }
        for singularPlayerCandidate in singularPlayerCandidatesTuples {
            let singularPlayerCandidateChars = singularPlayerCandidate.value.filter() { String($0) == gamePuzzles.allCandidates[singularPlayerCandidate.square] }
            //print("getSingularPlayerCandidates: singularPlayerCandidateChars = \(singularPlayerCandidateChars)")
            if singularPlayerCandidateChars.count < 1 {
                continue        // skip if none found
            }
            let singularPlayerCandidateStr = singularPlayerCandidateChars.reduce("",{String($0) + String($1)})
            //print("getSingularPlayerCandidates: singularPlayerCandidateStr = \(singularPlayerCandidateStr)")
            singularPlayerCandidatesStr.append(Cell(i: singularPlayerCandidate.square, e: singularPlayerCandidateStr))
            //print("getSingularPlayerCandidates: singularPlayerCandidateChars = \(singularPlayerCandidateChars), singularPlayerCandidateStr = \(singularPlayerCandidateStr)")
        }
        if singularPlayerCandidatesStr.count == 0 {
            return nil
        }
        return singularPlayerCandidatesStr
    }
    
    //
    //  getAlgoAssigns returns the first assigned Cell
    //
    func getAlgoAssigns() -> AlgoAssigns? {
        let pSet = gamePuzzles
        print("HELP STEP 2: getAlgoAssigns: about to call runAlgorithms()")
        let algoResults = puzzle.runAlgorithms(pSet, DFGoal.help)
        
        if algoResults.solution.strategy.algoAssigns != nil {
            print("HELP STEP 3: getAlgoAssigns: algoAssigns from runAlgorithms() is not nil, so about to call findGlobalOrFirst()")
            return findGlobalOrFirst(algoResults.solution.strategy.algoAssigns!)
        }
        
        print("HELP STEP 16: findGlobalOrFirst: algoAssigns from HELP STEP 2 was nil, so checking cpAssigns")
        if !algoResults.solution.strategy.cpAssigns.isEmpty {
            print("HELP STEP 17: getAlgoAssigns: cpAssigns has \(algoResults.solution.strategy.cpAssigns.count) items so check for any new")
            let cpAssignsLessAnswered = algoResults.solution.strategy.cpAssigns.filter() { $0.value != gamePuzzles.playerAnswered[$0.square] }
            if cpAssignsLessAnswered.count < 1 {
                print("HELP STEP 18: getAlgoAssigns: cpAssigns has \(cpAssignsLessAnswered.count) new items, so RETURNING nil! Going Whoa!")
                return nil
            } else {
                print("HELP STEP 19: getAlgoAssigns: cpAssigns has \(cpAssignsLessAnswered.count) new items, so RETURNING the first one!!")
                let cpAssignsLessAnsweredFirst = cpAssignsLessAnswered.first!
                // create array of highlight Help Cells
                var highlightHelpCells = [HelpCell]()
                highlightHelpCells.append(HelpCell(sq: cpAssignsLessAnsweredFirst.square, ans: cpAssignsLessAnsweredFirst.value, del: "", alg: ""))
                let algoReturn = algoResults.solution.strategy.algorithm != nil ? algoResults.solution.strategy.algorithm! : "Guessing"
                let algoAssign = AlgoAssigns(aCell: (cpAssignsLessAnswered.first)!, hhCells: highlightHelpCells, aAlgo: algoReturn)
                return algoAssign
            }
        } else {
            print("HELP STEP 20: getAlgoAssigns: algoAssigns and cpAssigns both nil, so RETURNING nil!  Going Whoa!")
            return nil
        }

    }
    
    func findGlobalOrFirst(_ algo: [AlgoAssigns]) -> AlgoAssigns {
        let filteredKPD = algo.filter() { $0.assignCell.value == globalKPD }
        let filteredSC = algo.filter() { $0.assignCell.square == globalSC?.row }
        print("HELP STEP 4: findGlobalOrFirst: determined if KPD or SC are in any elements of [AlgoAssigns]")
        print("findGlobalOrFirst: filteredSC = \(filteredSC)")
        print("findGlobalOrFirst: filteredKPD = \(filteredKPD)")
        if filteredKPD.isEmpty && filteredSC.isEmpty {
            print("HELP STEP 5: findGlobalOrFirst: no algoAssign with assignCell.value == \(String(describing: globalKPD)) or assignCell.square == \(String(describing: globalSC))!  returning first result!")
            return algo.first!
        }
        gamePuzzles.allCandidates = getAllCandidates(gamePuzzles)
        print("HELP STEP 6: findGlobalOrFirst: allCandidates puzzle = ")
        printPuzzle(gamePuzzles.allCandidates)
        if !filteredSC.isEmpty {
            print("HELP STEP 7: findGlobalOrFirst: looping through \(filteredSC.count) filteredSC elements")
            for algoSC in filteredSC {
                if algoSC.assignCell.square == globalSC?.row {
                    print("HELP STEP 8: findGlobalOrFirst: algoSC.assignCell.square == \(String(describing: globalSC?.row))!  now need to validate!")
                    if gamePuzzles.allCandidates[algoSC.assignCell.square].count == 1 {
                        print("HELP STEP 9: findGlobalOrFirst: found an algoAssign with selectedCell of \(String(describing: globalSC?.row)) and a singular candidtate of \(gamePuzzles.allCandidates[algoSC.assignCell.square])!  RETURNING the result!")
                        return algoSC
                    }
                }
            }
            print("HELP STEP 10: findGlobalOrFirst: did not find an element of [AlgoAssigns] with a cell of selectedCell")
        }
        if !filteredKPD.isEmpty {
            print("HELP STEP 11: findGlobalOrFirst: looping through \(filteredKPD.count) filteredKPD elements")
            for algoKPD in filteredKPD {
                if algoKPD.assignCell.value == globalKPD {
                    print("HELP STEP 12: findGlobalOrFirst: found an algoKPD.assignCell.value of \(String(describing: globalKPD)) equal to keypadDigit!  now need to validate!")
                    if gamePuzzles.allCandidates[algoKPD.assignCell.square] == globalKPD {
                        print("HELP STEP 13: findGlobalOrFirst: found an algoAssign with keypadDigit of \(String(describing: globalKPD)) and equal to a candidate value!  RETURNING the result!")
                        return algoKPD
                    }
                }
            }
            print("HELP STEP 14: findGlobalOrFirst: did not find an element of [AlgoAssigns] with a value of keypadDigit")
        }
        print("HELP STEP 15: findGlobalOrFirst: did not find an element of [AlgoAssigns] with a global KPD or SC, so simply RETURNING the first element!")
        return algo.first!
    }
    
}
