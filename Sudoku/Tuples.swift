//
//  Tuples.swift
//  Sudoku
//
//  Created by dave herbine on 3/26/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import Foundation

//
// Tuples essentially feeds eliminate() which performs constraint propagation if any tuples are found.
//
class Tuples: SolutionStrategy {
    
    var uniqueSolutions = [[String]]()    // array of arrays and has to be a class property
    
    var pzzlSet = PzlSet()
    var algorithm: String? = nil     // Will get set to firt type of Pair found
    var eliminates = [String](repeating: "", count: 81)
    var allPairs: [Cell]? = nil
    var reducibleNakedPairs: [Cell]? = nil
    var reducibleHiddenPairs: [Cell]? = nil
    var cpAssigns = [Cell]()
    var algoEliminates: [AlgoEliminates]? = nil
    var algoAssigns: [AlgoAssigns]? = nil
    
    let hiddenPair = "Hidden Pair"
    let nakedPair = "Naked Pair"
    
    struct UnitTuples {
        var allTuples = [String](repeating: "", count: 9)
        var reducibleHiddenTuples = [String](repeating: "", count: 9)
        var hiddenEliminates = [String](repeating: "", count: 9)
        var reducibleNakedTuples = [String](repeating: "", count: 9)
        var nakedEliminates = [String](repeating: "", count: 9)
        var netEliminates = [String](repeating: "", count: 9)
        var netEliminatesType = [String](repeating: "", count: 9)
        var algoEliminates = [AlgoEliminates]()
        
        func printUnitTuples() {
            print("\nUnitTuples: allTuples = \(allTuples)")
            print("UnitTuples: reducibleHiddenTuples = \(reducibleHiddenTuples)")
            print("UnitTuples: hiddenEliminates = \(hiddenEliminates)")
            print("UnitTuples: reducibleNakedTuples = \(reducibleNakedTuples)")
            print("UnitTuples: nakedEliminates = \(nakedEliminates)")
            print("UnitTuples: netEliminates = \(netEliminates)")
            print("UnitTuples: netEliminatesType = \(netEliminatesType)")
            print("UnitTuples: algoEliminates = ")
            for algoElim in algoEliminates { algoElim.printIt() }
        }
    }
    
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

        pzzlSet = eliminateFromTuples(pzl)
        if pzzlSet.state == .solved {
            pzzlSet.solvingAlgorithm = .solvedByPairs
            uniqueSolutions.append(pzzlSet.playerAnswered)
        } else {
            pzzlSet.solvingAlgorithm = nil
        }
        return pzzlSet
    }
    
    //
    // eliminateFromTuples() checks each unit for hidden or naked tuples and eliminates the appropriate digits in the unit if found.
    //
    func eliminateFromTuples(_ puzzle: PzlSet) -> PzlSet {
        var tupleFound = false
        var tPuzzle = puzzle
        let cp = ConstraintPropagation()    // needed to feed eliminate()
        var bestAssigns = [Cell]()
        var bestPzl = puzzle
        
        // cycle through the units ... as long as something is found
        repeat {
            tupleFound = false
            
            // idx is 0...26, and each unitL is an [Int] whose values are the cells of a row, column, or block
            for (idx, unitL) in PuzzleLets.globalVar.unitsArray.enumerated() {
                
                //print("eliminateFromTuples: unitL = \(unitL)")
                
                // Skip a unit if it's already solved, i.e., nothing to eliminate
                if tPuzzle.solvedUnits.contains(idx) {
                    continue
                }
                
                // Create a unitLValues that contains the candidates' values of the corresponding cell address ...
                //  ... remember that CP is always called before Tuples and returns playerAnswered containing reduced candidates
                let unitLValues = unitL.map { tPuzzle.playerAnswered[$0] }
                var foundTuples = findUnitTuples2(unitL, unitLValues, tuple: 2)
                //print("eliminateFromTuples: foundTuples = \(foundTuples)\n in \(unitLValues)\n of \(unitL)")
                if !foundTuples.reducibleNakedTuples.isEmpty || !foundTuples.reducibleHiddenTuples.isEmpty {
                    //print("eliminateFromTuples: foundTuples in \(unitLValues)\n of \(unitL)")
                }

                // The relative position of allTuples correspond to the specific cell addresses of unitL
                var aPair = zip(unitL, foundTuples.allTuples).map({ Cell(i: $0.0, e: $0.1) }).filter() { !$0.value.isEmpty }
                //print("eliminateFromTuples: allNakedTuples: aPair = \(aPair)")
                for pair in aPair {
                    if allPairs == nil { allPairs = [Cell]() }
                    if !allPairs!.contains(pair) {    // deleted "where:" after converting to Cell
                        allPairs?.append(pair)
                    }
                }
                //print("eliminateFromTuples: allNakedPairs = \(allNakedPairs)")
                aPair = zip(unitL, foundTuples.reducibleNakedTuples).map({ Cell(i: $0.0, e: $0.1) }).filter() { !$0.value.isEmpty }
                //print("eliminateFromTuples: reducibleNakedTuples: aPair = \(aPair)")
                for pair in aPair {
                    if reducibleNakedPairs == nil { reducibleNakedPairs = [Cell]() }
                    //print("eliminateFromTuples: pair of reducibleNakedPairs?.append(pair) = \(pair)")
                    reducibleNakedPairs?.append(pair)
                }
                //print("eliminateFromTuples: reducibleNakedPairs = \(reducibleNakedPairs)")
                
                aPair = zip(unitL, foundTuples.reducibleHiddenTuples).map({ Cell(i: $0.0, e: $0.1) }).filter() { !$0.value.isEmpty }
                //print("eliminateFromTuples: reducibleHiddenTuples: aPair = \(aPair)")
                for pair in aPair {
                    if reducibleHiddenPairs == nil { reducibleHiddenPairs = [Cell]() }
                    //print("eliminateFromTuples: pair of reducibleHiddenPairs?.append(pair) = \(pair)")
                    reducibleHiddenPairs?.append(pair)
                }
                //print("eliminateFromTuples: reducibleHiddenPairs = \(reducibleHiddenPairs)")
                if foundTuples.netEliminates.isEmpty {      // Nothing to eliminate so get the next unit
                    continue
                } else {
                    tupleFound = true
                    for (i, eDigits) in foundTuples.netEliminates.enumerated() {    // netEliminates is a generic unit [0...8]
                        eliminates[unitL[i]] = eDigits      // unitL[i] corresponds to the square of a puzzle 0...80
                    }
                }
                
                for (indx, unitKey) in unitL.enumerated() {
                    if foundTuples.netEliminates[indx] != "" {
                        for char in foundTuples.netEliminates[indx] {
                            //print("eliminateFromTuples: eliminating \(char) from square \(unitKey)")
                            tPuzzle = cp.eliminate(&tPuzzle, key: unitKey, digit: String(char), nil)
                            cpAssigns = cp.cpAssigns
                            algorithm = foundTuples.netEliminatesType[indx]
                            switch tPuzzle.state {
                            case .solved:
                                //print("eliminateFromTuples: solved from eliminate(key: \(unitKey), digit: \(char)), so returning")
                                //print("eliminateFromTuples: eliminate matrix = ")
                                //printPuzzle(tPuzzle.pEliminates)
                                if !cpAssigns.isEmpty {
                                    if let algoElimOfIndx = foundTuples.algoEliminates.filter({ $0.eliminateCell.square == indx && $0.eliminateCell.value.contains(String(char)) }).first {
                                        //print("eliminateFromTuples: cpAssigns = \(cpAssigns)")
                                        //print("eliminateFromTuples: sending the following to populateTuplesAssigns()")
                                        //algoElimOfIndx.printIt()
                                        populateTuplesAssigns(algoElimOfIndx, unitL)
                                    }
                                }
                                return tPuzzle
                            case .invalid:
                                //print("eliminateFromTuples: invalid return from eliminate, so returning")
                                //print("eliminateFromTuples: eliminate matrix = ")
                                //printPuzzle(tPuzzle.pEliminates)
                                return tPuzzle
                            case .valid:
                                //print("eliminateFromTuples: valid return from eliminate, so continuing")
                                if !cpAssigns.isEmpty {
                                    if bestAssigns.isEmpty {
                                        bestAssigns = cpAssigns
                                    } else if cpAssigns.count >= bestAssigns.count {
                                        bestAssigns = cpAssigns
                                        bestPzl = tPuzzle
                                    }
                                }

                            }
                        }
                    }
                }                
            }
        } while tupleFound
        
        //print("eliminateFromTuples: valid return from eliminate, so returning")
        //print("eliminateFromTuples: eliminate matrix = ")
        //printPuzzle(tPuzzle.pEliminates)
        if !bestAssigns.isEmpty {
            cpAssigns = bestAssigns
            tPuzzle = bestPzl
        }
        cpAssigns = cp.cpAssigns
        return tPuzzle
    }

    func populateTuplesAssigns(_ aElim: AlgoEliminates, _ units: [Int]) {

        // create array of highlight Help Cells
        var highlightHelpCells = [HelpCell]()
        switch aElim.eliminateAlgo {
        case hiddenPair:
            //print("populateTuplesAssigns: reducibleHiddenPairs = \(reducibleHiddenPairs)")
            for cell in aElim.highlightCells {
                if let pairFound = reducibleHiddenPairs?.filter({ $0.square == cell.square }) {
                    if pairFound.count > 0 {
                        let delArray = ["1","2","3","4","5","6","7","8","9"].filter { cell.value.range(of: $0) == nil }
                        let delString = delArray.reduce("", {$0 + $1})
                        highlightHelpCells.append(HelpCell(sq: cell.square, ans: "", del: delString, alg: cell.value))
                    } else {
                        highlightHelpCells.append(HelpCell(sq: cell.square, ans: "", del: "", alg: ""))
                    }
                }
            }
        case nakedPair:
            //print("populateTuplesAssigns: reducibleNakedPairs = \(reducibleNakedPairs)")
            for cell in aElim.highlightCells {
                if let pairFound = reducibleNakedPairs?.filter({ $0.square == cell.square }) {
                    if pairFound.count > 0 {
                        highlightHelpCells.append(HelpCell(sq: cell.square, ans: "", del: "", alg: cell.value))
                    } else {
                        let delArray = ["1","2","3","4","5","6","7","8","9"].filter { cell.value.range(of: $0) == nil }
                        let delString = delArray.reduce("", {$0 + $1})
                        highlightHelpCells.append(HelpCell(sq: cell.square, ans: "", del: delString, alg: ""))
                    }
                }
            }
        default:
            print("populateTuplesAssigns: aElin.eliminateAlgo of \"\(aElim.eliminateAlgo)\" not recognized!!")
        }
        //print("populateTuplesAssigns: highlightHelpCells = ")
        //for hcell in highlightHelpCells { hcell.printIt() }
        
        let cpAssignsInUnit = cpAssigns.filter() { units.contains(Int($0.square)) }
        let cpAssignsNotInUnit = cpAssigns.filter() { !units.contains(Int($0.square)) }
        cpAssigns = cpAssignsInUnit + cpAssignsNotInUnit
        for aCell in cpAssigns {
            if algoAssigns == nil { algoAssigns = [AlgoAssigns]() }
            for (hIndex, hCell) in highlightHelpCells.enumerated() {
                if hCell.square == aCell.square {highlightHelpCells[hIndex].ansDigit = aCell.value}
            }
            algoAssigns?.append(AlgoAssigns(aCell: aCell, hhCells: highlightHelpCells, aAlgo: aElim.eliminateAlgo))
        }
    }
    
    //
    // createUnitStats() returns the following statistics associated with an input:
    //  rowsBits is a collection of keys and the associated binary array indicating whether or not the key's digit was found in the column
    //  rowsSums is an array of the sum of how many times the key's digit is found in the row
    //  colsBits is a collection of keys and the associated binary array indicating whether or not the key's digit was found in the row
    //  colsSums is an array of the sum of how many times the key's digit is found in the column
    //
    func createUnitStats(_ unitB: [String]) -> (rowsBits: [String: [Int]], rowsSums: [Int], colsBits: [String: [Int]], colsSums: [Int]) {
        var rowsMatrix = [String: [Int]](minimumCapacity: 9)
        var rowArray = [Int](repeating: 0, count: 9)    //local working unit
        var rowsTotals = [Int](repeating: 0, count: 9)
        var colsMatrix = [String: [Int]](minimumCapacity: 9)
        var colArray = [Int](repeating: 0, count: 9)    //local working unit
        var colsTotals = [Int](repeating: 0, count: 9)
        
        // cycle through each digit of colVals to create the rows matrix and rowsSums
        for keyDigit in ["1","2","3","4","5","6","7","8","9"] {
            // check each item of the input array for the digit
            rowArray = unitB.map { ($0.range(of: keyDigit) != nil) ? 1 : 0 }
            rowsMatrix[keyDigit] = rowArray // array of bits indicating whether or not it's positional digit is present
            colsMatrix[keyDigit] = colArray // initialize to zeros
            //if let keyIndx = keyDigit.toInt() {
            if let keyIndx = Int(keyDigit) {
                rowsTotals[keyIndx-1] = rowArray.reduce(0,+)    // create rowsSums since I have it
            }
        }
        
        // create the columns martix from the rows matrix
        for (rowKey, rowArray) in rowsMatrix {  // iterate through the rows
            if let colPos = Int(rowKey) {    // need the colArray position as an Int
                for d in ["1","2","3","4","5","6","7","8","9"] {  //iterate through colsMatrix in colVals order
                    colArray = colsMatrix[d]!   // get current colArray
                    if let rowPos = Int(d) {  // need the rowArray position as an Int
                        if rowArray[rowPos-1] == 1 { //initialized to 0 so only need to set it if it's a 1
                            colArray[colPos-1] = rowArray[rowPos-1] // update colArray
                            colsMatrix[d] = colArray    // update colsMatrix's colArray
                        }
                    }
                }
            }
        }
        
        // cycle through the colsMatrix and calculate the colsSums
        for (colKey, colArray) in colsMatrix {
            if let keyIndx = Int(colKey) {
                colsTotals[keyIndx-1] = colArray.reduce(0,+)
            }
        }
        
//        print("rows = \(rowsMatrix)")
//        print("rowsTotals = \(rowsTotals)")
//        print("cols = \(colsMatrix)")
//        print("colsTotals = \(colsTotals)")
        return (rowsMatrix, rowsTotals, colsMatrix, colsTotals)
    }

    //
    // findUnitTuples2() returns an array of digits for each unit to be fed to eliminate().
    //  the function finds reducible naked and/or hidden tuples of the input unit.
    //  The results are for both giving hints to the player as well as solving puzzles.
    //
    //  Returns the following arrays: (they are valued only if something can be eliminated!)
    //  allTuples - unit square and digits that are the reducible or irreducible hidden or naked tuples (pair, triple, or, quad)
    //  reducibleHiddenTuples - unit square and digits that are the reducible hidden tuples (pair, triple, or, quad)
    //  hiddenEliminates - unit square and digits that can be eliminated due to hidden tuples
    //  reducibleNakedTuples - unit square and digits that are the reducible naked tuples (pair, triple, or, quad)
    //  nakedEliminates - unit square and digits that can be eliminated due to hidden tuples
    //  netEliminates - unit square and digits that can be eliminated due to hidden or naked tuples
    //
    func findUnitTuples2(_ unitL: [Int], _ unitA: [String], tuple: Int) -> UnitTuples {
        
        var unitTuples = UnitTuples()
        
        // get the statistics of the unit required to determine if it contains any hidden or naked doubles
        var unitStats = createUnitStats(unitA)
        
        // a pure naked double is where two cols are equal and their corresponding rowSums are both 2; Or, conversely,
        //  two rows are equal and their corresponding colSums are both 2.
        //print("\nfindUnitTuples2: unitA = \(unitA)")
        let rTuples = unitStats.rowsSums.filter() {$0 == tuple}
        //print("findUnitTuples2: unitStats.rowsSums = \(unitStats.rowsSums), rTuples.count = \(rTuples.count)")
        let cTuples = unitStats.colsSums.filter() {$0 == tuple}
        //print("findUnitTuples2: unitStats.colsSums = \(unitStats.colsSums), cTuples.count = \(cTuples.count)")
        
        if rTuples.count < tuple && cTuples.count < tuple {
            //print("findUnitTuples2: no tuples in unit: \(unitA)")
            return makeConsistent(unitTuples)
        }
        
        // a hidden double is where two rows are equal and is reducible if at least one of their corresponding colSums is > 2
        //  cycle through rowBits looking for equal rows and then check their corresponding colSums.
        if rTuples.count >= tuple {     // it's possible there are no matches
            var rowsMatches = [String: [Int]]()     // collection of matching rows
            var rowsBitsKeys = [Int]()
            for (indx, rCount) in unitStats.rowsSums.enumerated() {
                if rCount == tuple { rowsBitsKeys.append(indx) }
            }
            
            // Ensure I find ALL hidden tuples
            let hiddenKeysSet = combinations(rowsBitsKeys, tuple)
            for hiddenKeys in hiddenKeysSet {
                let hiddenKeysRowsBits = hiddenKeys.map(){ unitStats.rowsBits[String($0+1)] }
                if let hiddenKeysRowsBitsFirst = hiddenKeysRowsBits.first {
                    let hiddenKeysRowsBitsReduced = hiddenKeysRowsBits.filter() { $0! != hiddenKeysRowsBitsFirst! }
                    if hiddenKeysRowsBitsReduced.isEmpty {
                        let hiddenTuple = hiddenKeys.map({ String($0+1) }).reduce("", {$0 + $1})
                        var hiddenTupleCells = [Int]()
                        for (indx, rBit) in (hiddenKeysRowsBitsFirst?.enumerated())! {
                            if rBit == 1 { hiddenTupleCells.append(indx) }
                        }
                        rowsMatches[hiddenTuple] = hiddenTupleCells
                    }
                }
            }
//            if !rowsMatches.isEmpty { print("\nfindUnitTuples2: Hidden Tuples = \(rowsMatches)") }
            
            // update eliminateValues if a hiddenDouble was found
            for (hTuple, hTupleCells) in rowsMatches {                
                // create the highlight cells
                var highlightCells = [Cell]()
                for square in unitL { highlightCells.append(Cell(i: square, e: hTuple)) }
                //for hTupleCell in hTupleCells { highlightCells.append(Cell(i: hTupleCell, e: hTuple)) }

                // create the eliminate strings
                var eliminateStrings = [String](repeating: "", count: hTupleCells.count)
                for (hTupleIndex, hTupleCell) in hTupleCells.enumerated() {
                    unitTuples.reducibleHiddenTuples[hTupleCell] = hTuple
                    // check if the unit at hTupleCell contains charKey, and if so, remove it and add it to eliminated values
                    eliminateStrings[hTupleIndex] = unitA[hTupleCell]
                    for charKey in hTuple {
                        eliminateStrings[hTupleIndex] = eliminateStrings[hTupleIndex].replacingOccurrences(of: String(charKey), with: "")
                        unitTuples.hiddenEliminates[hTupleCell] = eliminateStrings[hTupleIndex]
                        unitTuples.netEliminatesType[hTupleCell] = "Hidden Pair"
                    }
                }
                
                // create the Eliminates Struct
                for (eliminateStrIndex, eliminateString) in eliminateStrings.enumerated() {
                    if !eliminateString.isEmpty {
                        let eliminateCell = Cell(i: hTupleCells[eliminateStrIndex], e: eliminateString)
                        unitTuples.algoEliminates.append(AlgoEliminates(eCell: eliminateCell, hCells: highlightCells, eAlgo: hiddenPair))
                    }
                }
            }
            
            unitTuples.netEliminates = unitTuples.hiddenEliminates
            unitTuples.allTuples = unitTuples.reducibleHiddenTuples
           
            if !unitTuples.algoEliminates.isEmpty {
                //print("\nfindUnitTuples2: Finished finding Hidden Tuples:")
                //unitTuples.printUnitTuples()
            }

        }
        
        // return if done
        if cTuples.count < tuple {
            //print("findUnitTuples2: Returning since there are no Naked Tuples to find in unit: \(unitA)")
            return makeConsistent(unitTuples)
        }
        
        // a naked tuple is where two cols are equal and reducible if at least one of their corresponding rowSums is > tuple
        //  cycle through colBits looking for equal columns and then check their corresponding rowSums.
        var colsMatches = [String: [Int]]()     // collection of matching columns
        var colsBitsKeys = [Int]()      // array of indexes where colSums == tuple
        for (indx, cCount) in unitStats.colsSums.enumerated() {
            if cCount == tuple { colsBitsKeys.append(indx) }
        }
        
        // Ensure I find ALL naked tuples
        let nakedCellsSet = combinations(colsBitsKeys, tuple)
        for nakedCells in nakedCellsSet {
            let nakedCellsColsBits = nakedCells.map(){ unitStats.colsBits[String($0+1)] }
            if let nakedCellsColsBitsFirst = nakedCellsColsBits.first {
                let nakedCellsColsBitsReduced = nakedCellsColsBits.filter() { $0! != nakedCellsColsBitsFirst! }
                if nakedCellsColsBitsReduced.isEmpty {
                    var newKey = ""
                    for (key, bits) in (nakedCellsColsBitsFirst?.enumerated())! {
                        if bits == 1 {
                            newKey += String(key+1)
                            if newKey.count == tuple { colsMatches[newKey] = nakedCells }
                        }
                    }
                }
            }
        }
//        if !colsMatches.isEmpty { print("\nfindUnitTuples2: Naked Tuples = \(colsMatches)") }
        
        for (nTuple, _) in colsMatches {
            // create the highlight cells
            var highlightCells = [Cell]()
            for square in unitL { highlightCells.append(Cell(i: square, e: nTuple)) }
            
            // create the eliminate strings
            var eliminateStrings = [String](repeating: "", count: unitA.count)
            for char in nTuple {
                for (unitIdx, unit) in unitA.enumerated() {
                    if unit == nTuple {
                        unitTuples.reducibleNakedTuples[unitIdx] = nTuple
                        unitTuples.allTuples[unitIdx] = nTuple
                        continue
                    } else {
                        if unit.contains(String(char)) {
                            eliminateStrings[unitIdx] += String(char)
                        }
                    }
                }
            }
            // create the Eliminates Struct
            for (eStringsIdx, eString) in eliminateStrings.enumerated() {
                if eString != "" {
                    let AEappend = AlgoEliminates(eCell: Cell(i: eStringsIdx, e: eString), hCells: highlightCells, eAlgo: nakedPair)
                    unitTuples.algoEliminates.append(AEappend)
                    unitTuples.nakedEliminates[eStringsIdx] += eString
                    for char in eString {
                        if !unitTuples.netEliminates[eStringsIdx].contains(String(char)) {
                            unitTuples.netEliminates[eStringsIdx] += eString
                            unitTuples.netEliminatesType[eStringsIdx] = nakedPair
                        }
                    }
                }
            }
        }

        if !unitTuples.algoEliminates.isEmpty {
            //print("\nfindUnitTuples2: Finished finding Naked Tuples:")
            //unitTuples.printUnitTuples()
        }
        
        return makeConsistent(unitTuples)
    }
    
    func makeConsistent(_ incoming: UnitTuples) -> UnitTuples {
        var outgoing = UnitTuples()
        if incoming.allTuples.filter({ $0.count > 0 }).count == 0
            { outgoing.allTuples = [String]() } else { outgoing.allTuples = incoming.allTuples }
        if incoming.reducibleHiddenTuples.filter({ $0.count > 0 }).count == 0
            { outgoing.reducibleHiddenTuples = [String]() } else { outgoing.reducibleHiddenTuples = incoming.reducibleHiddenTuples }
        if incoming.hiddenEliminates.filter({ $0.count > 0 }).count == 0
            { outgoing.hiddenEliminates = [String]() } else { outgoing.hiddenEliminates = incoming.hiddenEliminates }
        if incoming.reducibleNakedTuples.filter({ $0.count > 0 }).count == 0
            { outgoing.reducibleNakedTuples = [String]() } else { outgoing.reducibleNakedTuples = incoming.reducibleNakedTuples }
        if incoming.nakedEliminates.filter({ $0.count > 0 }).count == 0
            { outgoing.nakedEliminates = [String]() } else { outgoing.nakedEliminates = incoming.nakedEliminates }
        if incoming.netEliminates.filter({ $0.count > 0 }).count == 0
            { outgoing.netEliminates = [String]() } else { outgoing.netEliminates = incoming.netEliminates }
        if incoming.netEliminatesType.filter({ $0.count > 0 }).count == 0
            { outgoing.netEliminatesType = [String]() } else { outgoing.netEliminatesType = incoming.netEliminatesType }
        outgoing.algoEliminates = incoming.algoEliminates
        return outgoing
    }
    

}
