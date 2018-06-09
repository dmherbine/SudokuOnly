//
//  UniqueRectangles.swift
//  Sudoku
//
//  Created by dave herbine on 10/2/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import Foundation

//
// eliminateFromDeadlyPatterns() -> checkForDeadlyPattern() -> eliminate() which performs constraint propagation for any Deadly Patterns found.
//
class UniqueRectangles: SolutionStrategy {
    
    var uniqueSolutions = [[String]]()    // array of arrays and has to be a class property
    
    var algorithm: String? = "finding a Unique Rectangle"
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
        if pzzlSet.playerAnswered == pzzlSet.solution {
            pzzlSet.state = .solved
            uniqueSolutions.append(pzzlSet.playerAnswered)
            return pzzlSet
        }
        if pzzlSet.state == .invalid {
            return pzzlSet
        }
        
        if pairs != nil {
            pzzlSet = eliminateFromDeadlyPatterns(pzl, pairs)
            if pzzlSet.state == .solved {
                pzzlSet.solvingAlgorithm = .solvedByT1UR
            }
        }
        return pzzlSet
    }
    
    //
    // eliminateFromDeadlyPatterns() checks for and eliminates digits of T1UR Deadly Patterns.
    //
    func eliminateFromDeadlyPatterns(_ puzzle: PzlSet, _ pairs: [Cell]?) -> PzlSet {
        var mPuzzle = puzzle
        var urIndexes: [Int]? = nil
        
        if pairs != nil {
            let uniquePairs = Set(pairs!.map(){ $0.value })
            for uniquePair in uniquePairs {
                //print("eliminateFromDeadlyPatterns: uniquePair = \(uniquePair)")
                let uniquePairCells = pairs?.filter(){ $0.value == uniquePair }.map(){ $0.square }
                switch uniquePairCells!.count {
                case 0...2:
                    //print("eliminateFromDeadlyPatterns: case 0...2: uniquePairCells = \(uniquePairCells)")
                    break
                case 3:
                    let mResults = checkForDeadlyPattern(uniquePairCells!, uniquePair, puzzle)
                    mPuzzle = mResults.pSet
                    urIndexes = mResults.urSquares
                    populateURAssigns(urIndexes, mResults.missingCell, uniquePair, mResults.remaining)
                    if mPuzzle.state == .solved {
                        return mPuzzle
                    }
                default:    // case >3:
                    var bestAssigns = [Cell]()
                    var bestPzl = mPuzzle
                    let combosOfUniquePairs = combinations(uniquePairCells!, 3)
                    for aUniquePair in combosOfUniquePairs {
                        //print("eliminateFromDeadlyPatterns: default (> 3): aUniquePair = \(aUniquePair) of \(combosOfUniquePairs.count)")
                        let mResults = checkForDeadlyPattern(aUniquePair, uniquePair, puzzle)
                        mPuzzle = mResults.pSet
                        urIndexes = mResults.urSquares
                        populateURAssigns(urIndexes, mResults.missingCell, uniquePair, mResults.remaining)
                        if mPuzzle.state == .solved {
                            return mPuzzle
                        } else if mPuzzle.state == .valid && !cpAssigns.isEmpty {
                            if bestAssigns.isEmpty {
                                bestAssigns = cpAssigns
                            } else if cpAssigns.count > bestAssigns.count {
                                bestAssigns = cpAssigns
                                bestPzl = mPuzzle
                            }
                        }
                    }
                    if !bestAssigns.isEmpty {
                        cpAssigns = bestAssigns
                        mPuzzle = bestPzl
                    }
                    return mPuzzle
                }
            }
        } else {
            print("eliminateFromDeadlyPatterns: pairs is nil")
        }
        
        return mPuzzle
    }
    
    //
    // checkForDeadlyPattern() ensures the contents of the missingCell contain both digits in the pair and at least one other digit.
    //
    func checkForDeadlyPattern(_ uniquePairsCells: [Int], _ uniquePair: String, _ pzl: PzlSet) -> (pSet: PzlSet, urSquares: [Int]?, missingCell: Int?, remaining: String) {
        var tPuzzle = pzl
        let cp = ConstraintPropagation()    // needed to feed eliminate()
        var urCells: [Int]? = nil

        if let missingCell = find4thCellFrom3(uniquePairsCells) {
            urCells = uniquePairsCells
            urCells?.append(missingCell)
            //print("checkForDeadlyPattern: missingCell = \(missingCell)")
            if let remainingDigits = findPairInMissingCellDigits(uniquePair, missingCellDigits: tPuzzle.playerAnswered[missingCell]) {
                //print("checkForDeadlyPattern: remainingDigits = \(remainingDigits)")
                eliminates[missingCell] = uniquePair
                for char in uniquePair {
                    //print("eliminateFromDeadlyPatterns: eliminating \(char) at cell \(missingCell)")
                    tPuzzle = cp.eliminate(&tPuzzle, key: missingCell, digit: String(char), nil)
                    if tPuzzle.state != .valid {
                        //print("eliminateFromDeadlyPatterns: solved or invalid return from eliminate, so returning")
                        cpAssigns = cp.cpAssigns    // NOT SURE IF I NEED THIS
                        return (tPuzzle, urCells, missingCell, remainingDigits)
                    }
                }
            }
        }
        cpAssigns = cp.cpAssigns    // NOT SURE IF I NEED THIS
        return (tPuzzle, nil, nil, "")
    }
    
    //
    // findPairInMissingCellDigits() ensures the contents of the missingCell contain both digits in the pair and at least one other digit.
    //
    func findPairInMissingCellDigits(_ pair: String, missingCellDigits: String) -> String? {
        var mCellDigits = missingCellDigits
        
        //print("findPairInMissingCellDigits: pair = \(pair), missingCellDigits = \(missingCellDigits)")

        // eliminate found digits
        for digit in pair {
            let digitIndex = mCellDigits.range(of: String(digit))
            if digitIndex != nil {
                mCellDigits.removeSubrange(digitIndex!)
                if mCellDigits.isEmpty { return nil }
            } else {
                return nil
            }
        }
        return mCellDigits  // return the missingCellDigits less the pair or nil
    }
    
    //
    // find4thCellFrom3() computes the fourth cell of a rectangle given three cells with matching pairs of digits.
    //  To be a valid rectangle, each row and each column must occur in only two of the cells.
    //  The derived cell is found by building the underrepresented row and col and calculating it's position in 0 <= cell <= 80.
    //  The rows are simply the integer division by 9 and the columns are simply the remainder of modulo 9.
    //
    func find4thCellFrom3(_ threeCells: [Int]) -> Int? {
        var returnCell: Int?
        
        let rows = threeCells.map() { $0/9 }
        //print("find4thCellFrom3: rows = \(rows)")
        let theRowsSet = Set(rows)
        if theRowsSet.count != 2 { return nil }
        var theRowsArray = [Int]()
        for aRow in theRowsSet { theRowsArray.append(aRow) }
        
        let firstRows = rows.filter() { $0 == theRowsArray[0] }
        //print("find4thCellFrom3: firstRows = \(firstRows), count = \(firstRows.count)")
        let missingRow = firstRows.count == 1 ? theRowsArray[0] : theRowsArray[1]
        
        let cols = threeCells.map() { $0 % 9 }
        //print("find4thCellFrom3: cols = \(cols)")
        let theColsSet = Set(cols)
        if theColsSet.count != 2 { return nil }
        var theColsArray = [Int]()
        for aCol in theColsSet { theColsArray.append(aCol) }
        
        let firstCols = cols.filter() { $0 == theColsArray[0] }
        //print("find4thCellFrom3: firstCols = \(firstCols), count = \(firstCols.count)")
        let missingCol = firstCols.count == 1 ? theColsArray[0] : theColsArray[1]
        
        let missingCell = missingRow*9 + missingCol
        returnCell = missingCell < 0 || missingCell > PuzzleLets.globalVar.numberOfSquares ? nil : missingCell
        //print("find4thCellFrom3: returnCell = \(returnCell)")
        return returnCell
    }
    
    func populateURAssigns(_ hIndexes: [Int]?, _ missingCell: Int?, _ pair: String, _ remaining: String) {
        if cpAssigns.isEmpty {
            //print("populateAssigns: cpAssigns isEmpty!")
            return
        }
        if hIndexes == nil {
            print("populateAssigns: highlight Cells indexes are nil!")
            return
        } else if hIndexes?.count != 4 {
            print("populateAssigns: highlight Cells indexes.count of \(String(describing: hIndexes?.count)) are not equal to 4!")
            return
        }

        // create array of highlight Help Cells
        var highlightHelpCells = [HelpCell]()
        for hIndex in hIndexes! {
            if hIndex == missingCell {
                if remaining.count == 1 {
                    highlightHelpCells.append(HelpCell(sq: hIndex, ans: remaining, del: pair, alg: ""))
                } else {
                    highlightHelpCells.append(HelpCell(sq: hIndex, ans: "", del: pair, alg: ""))
                }
            } else {
                highlightHelpCells.append(HelpCell(sq: hIndex, ans: "", del: "", alg: pair))
            }
        }
        
        for aCell in cpAssigns {
            if algoAssigns == nil { algoAssigns = [AlgoAssigns]() }
            algoAssigns?.append(AlgoAssigns(aCell: aCell, hhCells: highlightHelpCells, aAlgo: "Deadly Pattern"))
        }
    }

}

