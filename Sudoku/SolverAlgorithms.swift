//
//  SolverAlgorithms.swift
//  Sudoku
//
//  Created by dave herbine on 3/20/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//


struct Cell {
    var square: Int
    var value: String
    init(i: Int, e: String) {
        square = i
        value = e
    }
    func compare(_ cell: Cell) -> Bool {
        let areAscending = value <= cell.value
        return areAscending
    }
}
extension Cell: Equatable {
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        let areEqual = lhs.square == rhs.square && lhs.value == rhs.value
        return areEqual
    }
}

struct HelpCell {
    var square: Int
    var ansDigit: String
    var delDigit: String
    var algDigit: String
    init(sq: Int, ans: String, del: String, alg: String) {
        square = sq
        ansDigit = ans
        delDigit = del
        algDigit = alg
    }
    func compare(_ hCell: HelpCell) -> Bool {
        let concatenatedDigits = ansDigit + delDigit + algDigit
        let concatenatedChars = concatenatedDigits.characters.map(){ $0 }
        let sortedConcatenatedChars = concatenatedChars.sorted()
        let sortedConcatenatedStr = sortedConcatenatedChars.reduce("",{String($0) + String($1)})
        
        let hCellconcatenatedDigits = hCell.ansDigit + hCell.delDigit + hCell.algDigit
        let hCellconcatenatedChars = hCellconcatenatedDigits.characters.map(){ $0 }
        let hCellsortedConcatenatedChars = hCellconcatenatedChars.sorted()
        let hCellsortedConcatenatedStr = hCellsortedConcatenatedChars.reduce("",{String($0) + String($1)})
        
        let areAscending = sortedConcatenatedStr <= hCellsortedConcatenatedStr
        return areAscending
    }
    func printIt() {
        print("square: \(square), ansDigit: \(ansDigit), delDigit: \(delDigit), algDigit: \(algDigit)")
    }
}
extension HelpCell: Equatable {
    static func ==(lhs: HelpCell, rhs: HelpCell) -> Bool {
        let areEqual = lhs.square == rhs.square && lhs.ansDigit == rhs.ansDigit && rhs.delDigit == lhs.delDigit && rhs.algDigit == lhs.algDigit
        return areEqual
    }
}

struct AlgoEliminates {
    var eliminateCell: Cell
    var highlightCells: [Cell]
    var eliminateAlgo: String
    init(eCell: Cell, hCells: [Cell], eAlgo: String) {
        eliminateCell = eCell
        highlightCells = hCells
        eliminateAlgo = eAlgo
    }
    func printIt() {
        print("\nAlgoEliminates: eliminateCell = \(eliminateCell)")
        print("AlgoEliminates: highlightCells = ")
        for highlightCell in highlightCells { print("\(highlightCell)") }
        print("AlgoEliminates: eliminateAlgo = \(eliminateAlgo)")
    }
}
extension AlgoEliminates: Equatable {
    static func ==(lhs: AlgoEliminates, rhs: AlgoEliminates) -> Bool {
        let areEqual = lhs.eliminateCell == rhs.eliminateCell &&
                        lhs.highlightCells.sorted(by: {(cell1: Cell, cell2: Cell) -> Bool in return cell1.square < cell2.square }) == rhs.highlightCells.sorted(by: {(cell1: Cell, cell2: Cell) -> Bool in return cell1.square < cell2.square }) &&
                        lhs.eliminateAlgo == rhs.eliminateAlgo
        return areEqual
    }
}

struct AlgoAssigns {
    var assignCell: Cell
    var highlightHelpCells: [HelpCell]
    var assignAlgo: String
    init(aCell: Cell, hhCells: [HelpCell], aAlgo: String) {
        assignCell = aCell
        highlightHelpCells = hhCells
        assignAlgo = aAlgo
    }
    func printIt() {
        print("\nAlgoAssigns: assignCell = \(assignCell)")
        print("AlgoAssigns: highlightHelpCells = ")
        for highlightHelpCell in highlightHelpCells { print("\(highlightHelpCell)") }
        print("AlgoAssigns: assignAlgo = \(assignAlgo)")
    }
}
extension AlgoAssigns: Equatable {
    static func ==(lhs: AlgoAssigns, rhs: AlgoAssigns) -> Bool {
        let areEqual = lhs.assignCell == rhs.assignCell &&
            lhs.highlightHelpCells.sorted(by: {(cell1: HelpCell, cell2: HelpCell) -> Bool in return cell1.square < cell2.square }) == rhs.highlightHelpCells.sorted(by: {(cell1: HelpCell, cell2: HelpCell) -> Bool in return cell1.square < cell2.square }) &&
            lhs.assignAlgo == rhs.assignAlgo
        return areEqual
    }
}

protocol SolutionStrategy {
    var uniqueSolutions: [[String]] { get }     // array of arrays and has to be a class property
    var allPairs: [Cell]? { set get }
    var reducibleNakedPairs: [Cell]? { set get }
    var reducibleHiddenPairs: [Cell]? { set get }
    var cpAssigns: [Cell] { set get }
    var eliminates: [String] { get }
    var algoEliminates: [AlgoEliminates]? { set get }
    var algoAssigns: [AlgoAssigns]? { set get }
    var algorithm: String? { get }
    var pzzlSet: PzlSet { get }
    func tryAlgo(_ pzl: PzlSet, _ dfGoal: DFGoal?, _ pairs: [Cell]?) -> PzlSet
}

import Foundation

class Solution {
    
    var strategy: SolutionStrategy
    
    func tryAlgo(_ pzl: PzlSet, _ dfGoal: DFGoal?, _ help: Bool, _ pairs: [Cell]?) -> PzlSet {
        print("Solution: got to tryAlgorithm!") // This never prints
        
        return self.strategy.tryAlgo(pzl, dfGoal!, pairs)
    }
    
    init(strategy: SolutionStrategy) {
        self.strategy = strategy
    }
}

//
// checkPuzzle() checks the state of each unit of the supplied puzzle and returns the following:
//  .invalid if any unit is found to be .invalid
//  .valid if no units are .invalid and at least one unit is .valid
//  .solved if all units are .solved
//
func checkPuzzle(_ p: inout PzlSet) -> states {
    
    if p.playerAnswered == p.solution {
        p.state = .solved
        return p.state
    }
    
    var validCount = 0
    
    for (i, u) in PuzzleLets.globalVar.unitsArray.enumerated() {
        if p.solvedUnits.contains(i) {
            continue
        }
        let uVals = u.map { p.playerAnswered[$0] }
        //print("checkPuzzle: uVals = \(uVals)")
        switch checkUnit(uVals) {
        case .invalid:
            //print("checkPuzzle: invalid unit of \(uVals)")
            p.state = .invalid // any invalid unit makes the puzzle invalid
            return .invalid
        case .valid:
            validCount += 1
        case .solved:
            //print("checkPuzzle: solved unit")
            p.solvedUnits.append(i)
            continue
        }
    }
    
    if validCount > 0 {
        p.state = .valid
        return .valid
    } else {
        //print("checkPuzzle: all units solved")
        p.state = .solved
        return .solved
    }
}

//
// checkUnit() checks a given unit and returns its state,
//  with the following values and their meanings:
//   "invalid" indicates a constraint violation.
//   "solved" indicates a solved grid.
//   "valid" indicates neither a solved nor invalid unit.
//
func checkUnit(_ unit: [String]) -> states {
    
    // ensure no cell is empty
    for unitValue in unit {
        if unitValue.isEmpty {
            return .invalid
        }
    }
    
    // ensure all values are singles
    let filteredUnit = unit.filter { $0.count == 1 }
    if filteredUnit.count != unit.count {
        //println("checkUnit: VALID")
        return .valid
    }
    
    // ensure all 9 values are found
    var uniqUnit = unit //uniq(unit)
    uniqUnit.sort()
    if uniqUnit == ["1","2","3","4","5","6","7","8","9"] {
        //print("checkUnit: SOLVED")
        return .solved
    } else {
        //print("checkUnit: INVALID")
        return .invalid
    }
    
}


