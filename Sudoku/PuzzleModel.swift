//
//  PuzzleModel.swift
//  Sudoku
//
//  Created by dave herbine on 4/11/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

// define the structure for the PuzzleQueue, Permutations, Generation, Solutions, and, Game classes
struct PzlSet {
    var type = ""
    var cLevel = 2
    var given = [String]()
    var solution = [String]()
    var solvingAlgorithm: solvingAlgo? = nil
    var allCandidates = [String](repeating: "", count: 81)  // candidate values for cells that don't violate the constraints of its peers
    var solvedUnits = [Int]()   // only used during puzzle generation
    var state = states.valid
    var playerAnswered = [String]()
    var playerCandidates = [String](repeating: "", count: 81)
    
    func isPuzzleSolved() -> Bool {
        let anyNotOne = playerAnswered.filter({ $0.count != 1 })
        if anyNotOne.isEmpty && playerAnswered == solution {
            return true
        }
        return false
    }
}

// define the states of a puzzle
enum states: CustomStringConvertible {
    case invalid
    case valid
    case solved
    
    var description: String {
        get {
            switch self {
            case .invalid:
                return "invalid"
            case .valid:
                return "valid"
            case .solved:
                return "solved"
            }
        }
    }
}

// define the solved by algorithms of a puzzle
enum solvingAlgo: CustomStringConvertible {
    case solvedByCP
    case solvedByPairs
    case solvedByDF
    case solvedByT1UR
    
    var description: String {
        get {
            switch self {
            case .solvedByCP:
                return "solvedByCP"
            case .solvedByPairs:
                return "solvedByPairs"
            case .solvedByDF:
                return "solvedByDF"
            case .solvedByT1UR:
                return "solvedByDF"
            }
        }
    }
}

// define the structure for the contents of a cell
enum cellContent: CustomStringConvertible {
    case given
    case answered
    case playerCandidate
    case allCandidate
    
    var description: String {
        get {
            switch self {
            case .given:
                return "given"
            case .answered:
                return "answered"
            case .playerCandidate:
                return "playerCandidate"
            case .allCandidate:
                return "allCandidate"
            }
        }
    }
}

class Puzzle: NSObject {
    
    var uniquePuzzleSolutions = [[String]]()  // array of arrays and has to be a class property

    func getPuzzlesWithChallenge(_ challengeLevel: Int) -> PzlSet {
        return PuzzleQueue.globalVar.popPuzzleQueueWithChallengeLevel(challengeLevel)
    }
    
    //
    // updateAllCandidatesFromAnswered() uses a supplied playerAnswered puzzle, updates the candidates puzzle,
    //  where the cells that correspond to holes in the playerAnswered puzzle are filled with
    //  all candidate digits not found in the three peer units of the given puzzle
    //
    // It returns the array of indexes that changed to be used in reloading those cells of the game
    //
    func updateAllCandidatesFromAnswered(_ inoutCandidates: inout [String], answered: [String], selectedCell: Int?) -> [Int] {
        var candidates = [String](repeating: "", count: 81)
        
        for (idx, value) in answered.enumerated() {
            // if the given puzzle's value is "", then the corresponding candidates value should be set
            if value == "" {
                var givens = ""
                if let peersIndexes = PuzzleLets.globalVar.peersDict[idx] {
                    for peer in peersIndexes {
                        givens += answered[peer]
                    }
                    let candidatesArray = ["1","2","3","4","5","6","7","8","9"].filter { givens.range(of: $0) == nil }
                    candidates[idx] = candidatesArray.reduce("", {$0 + $1})  // combines the array of candidate digits into a string
                } else {
                    print("upateFromAnswered: could not find key = \(idx) in peersDict!")
                }
            }
        }
        
        var changedIndexes = zip(inoutCandidates, candidates).enumerated().filter() { $1.0 != $1.1 }.map{$0.0}
        inoutCandidates = candidates
        
        if selectedCell != nil {
            if !changedIndexes.contains(selectedCell!) {
                changedIndexes.append(selectedCell!)
            }
        }
        
        return changedIndexes
    }
        
    //
    // getIndexesOfValuesFrom() returns an array of indexes whose corresponding values are not ""
    //  Used to minimize the number of cells reloaded when the player changes their Candidate view
    //
    func getIndexesOfUnvaluedFrom(_ answered: [String]) -> [Int] {
        return answered.enumerated().filter() { $0.1 == "" }.map{$0.0}  // swift 2.2 was .map{$0.index}
    }
    
    //
    // updatePlayerCandidatesFromAnswered() uses a supplied playerAnswered puzzle, updates the playerCandidates puzzle,
    //  where the cells that correspond to holes in the playerAnswered puzzle are updated
    //  based on playerCandidates digits not found in the three peer units of the given puzzle
    //
    // It returns the array of indexes that changed to be used in reloading those cells of the game
    //
    func updatePlayerCandidatesFromAnswered(_ inoutPlayerCandidates: inout [String], answered: [String], selectedCell: Int?) -> [Int] {
        var newPlayerCandidates = [String](repeating: "", count: 81)
        
        for (idx, value) in answered.enumerated() {
            // if the given puzzle's value is "" and playerCandidates is NOT "", then the corresponding playerCandidates value should be updated
            if value == "" && inoutPlayerCandidates[idx] != "" {
                var givens = ""
                if let peersIndexes = PuzzleLets.globalVar.peersDict[idx] {
                    for peer in peersIndexes {
                        givens += answered[peer]
                    }
                    // filter only on the digits of the original playerCandidate
                    var candidatesArray = inoutPlayerCandidates[idx].characters.map() { String($0) }
                    candidatesArray = candidatesArray.filter { givens.range(of: $0) == nil }
                    newPlayerCandidates[idx] = candidatesArray.reduce("", {$0 + $1})  // combines the array of candidate digits into a string
                    // now exclude only if p
                } else {
                    print("upateFromAnswered: could not find key = \(idx) in peersDict!")
                }
            }
        }
        
        var changedIndexes = zip(inoutPlayerCandidates, newPlayerCandidates).enumerated().filter() { $1.0 != $1.1 }.map{$0.0}  // swift 2.2 was .map{$0.index}
        inoutPlayerCandidates = newPlayerCandidates
        
        if selectedCell != nil {
            if !changedIndexes.contains(selectedCell!) {
                changedIndexes.append(selectedCell!)
            }
        }
        
        return changedIndexes
    }
    
}


//
// printPuzzle() presents a puzzle in a gameboard view in the debug console
//
func printPuzzle(_ puzzle: [String]) {
    
    var gridColCount = 0
    
    let puzzleCount = puzzle.map { $0.count }
    let gridColMaxLen = 2 + puzzleCount.reduce(0) { max($0, $1) }  // add the surrounding spaces to separate from neighbors
    
    // The puzzle will displayed with each square having the same width based on the widest given
    var unitSegment: String = ""
    for _ in 0...gridColMaxLen*3-1 { unitSegment += "-" }
    
    // can't use "for (row, rowValues) in gridRowDict" because I won't get the proper order
    for (gridRowCount, unitRow) in PuzzleLets.globalVar.unitsRows.enumerated() {
        
        // print a line segment at top and between units
        if gridRowCount % 3 == 0 {
            print("-\(unitSegment)+\(unitSegment)+\(unitSegment)-")
        }
        
        // create a rowString of 9 squares surrounded by the appropriate number of spaces and unit dividers of "|"
        let rowValues = unitRow.map { puzzle[$0] }
        var spacesCount = 0
        var spacesRemainder = 0
        gridColCount = 1
        var rowString = "|" // every row starts with a unit divider
        for cell in rowValues {
            
            spacesCount = (gridColMaxLen - cell.count)
            spacesRemainder = spacesCount % 2   // if odd, I'll have to add an extra space
            spacesCount /= 2
            
            // prepend the value with spaces and an extra if odd
            for _ in 0...spacesCount+spacesRemainder-1 {
                rowString += " "
            }
            
            // now add the actual value
            rowString += cell
            
            // append the value with spaces
            for _ in 0...spacesCount-1 {
                rowString += " "
            }
            
            // separate the units and end the row with a unit divider
            if gridColCount % 3 == 0 {
                rowString += "|"
            }
            gridColCount += 1
        }
        
        print("\(rowString)")
    }
    print("-\(unitSegment)+\(unitSegment)+\(unitSegment)-")   // add the bottom line segment
    
}

