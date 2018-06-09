//
//  PuzzlePermutations.swift
//  Sudoku
//
//  Created by dave herbine on 7/16/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

extension Puzzle {
    
    func newPermutation(_ givenPuzzle: [String], solutionPuzzle: [String]) -> (newGivenPuzzle: [String], newSolutionPuzzle: [String]) {
        var relabeldGivenPuzzle = givenPuzzle
        var relabeldSolutionPuzzle = solutionPuzzle
        
        // First Relabel
        let relabelSeq = relabelSequence()
        
        // First got to make a funky digit change and append to relabeled digits so I don't relabel a relabeled digit ... think about it
        let funkyDigit = "0"
        
        for (idx, relabel) in relabelSeq.enumerated() {
            relabeldGivenPuzzle = relabeldGivenPuzzle.map { $0 == "\(idx+1)" ? "\(relabel)\(funkyDigit)" : $0 }
            relabeldSolutionPuzzle = relabeldSolutionPuzzle.map { $0 == "\(idx+1)" ? "\(relabel)\(funkyDigit)" : $0 }
        }
        
        // Now remove the funky digit
        relabeldGivenPuzzle = relabeldGivenPuzzle.map { $0.count == 2 ? $0.substring(to: $0.index($0.startIndex, offsetBy: 1)) : $0 }
        relabeldSolutionPuzzle = relabeldSolutionPuzzle.map { $0.count == 2 ? $0.substring(to: $0.index($0.startIndex, offsetBy: 1)) : $0 }
        
        // Second Rotate ... maybe (rotations can be three which would effectively not rotate)
        let rotations = Int(arc4random_uniform(UInt32(3)))
        for _ in 0...rotations {
            relabeldGivenPuzzle = rotatePuzzle(relabeldGivenPuzzle)
            relabeldSolutionPuzzle = rotatePuzzle(relabeldSolutionPuzzle)
        }
        
        // Third Reflect about one of the diagonals
        let reflectOnDiagonal = Int(arc4random_uniform(UInt32(1)))
        relabeldGivenPuzzle = reflectPuzzle(relabeldGivenPuzzle, diagonal: reflectOnDiagonal)
        relabeldSolutionPuzzle = reflectPuzzle(relabeldSolutionPuzzle, diagonal: reflectOnDiagonal)
        
        // Fourth Reflect about one of the axis
        let reflectOnAxis = Int(arc4random_uniform(UInt32(1)))
        relabeldGivenPuzzle = reflectPuzzle(relabeldGivenPuzzle, axis: reflectOnAxis)
        relabeldSolutionPuzzle = reflectPuzzle(relabeldSolutionPuzzle, axis: reflectOnAxis)
        
        // Fifth Swap bands ... maybe (Swaps can be four which would not swap)
        let swapBands = Int(arc4random_uniform(UInt32(5)))
        if swapBands < 5 {
            relabeldGivenPuzzle = swapBandsOfPuzzle(relabeldGivenPuzzle, swapValue: swapBands)
            relabeldSolutionPuzzle = swapBandsOfPuzzle(relabeldSolutionPuzzle, swapValue: swapBands)
        }
        
        // Sixth Swap stacks ... maybe (Swaps can be four which would not swap)
        let swapStacks = Int(arc4random_uniform(UInt32(5)))
        if swapStacks < 5 {
            relabeldGivenPuzzle = swapStacksOfPuzzle(relabeldGivenPuzzle, swapValue: swapStacks)
            relabeldSolutionPuzzle = swapStacksOfPuzzle(relabeldSolutionPuzzle, swapValue: swapStacks)
        }
        
        // Seventh Swap rows ... maybe (Swaps can be seven which would not swap)
        let swapRows = Int(arc4random_uniform(UInt32(7)))
        if swapRows < 7 {
            (relabeldGivenPuzzle, relabeldSolutionPuzzle) = swapRowsOfPuzzle(relabeldGivenPuzzle, incomingSolutionPuzzle: relabeldSolutionPuzzle, swapValue: swapRows)
        }
        
        // Eighth Swap cols ... maybe (Swaps can be seven which would not swap)
        let swapCols = Int(arc4random_uniform(UInt32(7)))
        if swapCols < 7 {
            (relabeldGivenPuzzle, relabeldSolutionPuzzle) = swapColsOfPuzzle(relabeldGivenPuzzle, incomingSolutionPuzzle: relabeldSolutionPuzzle, swapValue: swapCols)
        }
        
        return (relabeldGivenPuzzle, relabeldSolutionPuzzle)
    }
    
    
    //
    // relabelSequence() returns a randomly sequenced array of values used to relabel a puzzle.
    //
    func relabelSequence() -> [String] {
        var relabelSeq = [String]()
        
        for (idx, _) in ["1","2","3","4","5","6","7","8","9"].enumerated() {
            // remove the relabelSeq values from consideration ... otherwise I could have a duplicate
            var labelPool = ["1","2","3","4","5","6","7","8","9"].filter { relabelSeq.contains($0) == false }
            
            if labelPool.count == 1 {
                // must mean only the idx+1 value is left so assign it and be done ... this will also prevent an index out of range crash
                relabelSeq.append(labelPool.first!)
                break
            } else {
                // otherwise remove the idx+1 value from consideration so I don't relabel to the same value
                labelPool = labelPool.filter { $0 != "\(idx+1)" }
                
                // get a value from the pool of valid values, add it to the relabelSeq, and remove it from further consideration
                let r = Int(arc4random_uniform(UInt32(labelPool.count)))
                //println("relabelSequence: count(labelPool) = \(count(labelPool)), r = \(r)")
                relabelSeq.append(labelPool[r])
            }
            
        }
        
        //println("relabelSequence: relabelSeq is \(relabelSeq)")
        return relabelSeq
    }
    
    func rotatePuzzle(_ incomingPuzzle: [String]) -> [String] {
        var rotatedPuzzle = incomingPuzzle
        
        // Best solved by rotating in 4 layers, so let's define them as mapping tuples
        var layers = [(top: [Int](), right: [Int](), bottom: [Int](), left: [Int]())]
        layers.append((top: [0,1,2,3,4,5,6,7,8], right: [8,17,26,35,44,53,62,71,80], bottom: [80,79,78,77,76,75,74,73,72], left: [72,63,54,45,36,27,18,9,0]))
        layers.append((top: [10,11,12,13,14,15,16], right: [16,25,34,43,52,61,70], bottom: [70,69,68,67,66,65,64], left: [64,55,46,37,28,19,10]))
        layers.append((top: [20,21,22,23,24], right: [24,33,42,51,60], bottom: [60,59,58,57,56], left: [56,47,38,29,20]))
        layers.append((top: [30,31,32], right: [32,41,50], bottom: [50,49,48], left: [48,39,30]))
        
        // Rotate layers
        for layer in layers {
            for (idx, index) in layer.top.enumerated() {
                rotatedPuzzle[layer.right[idx]] = incomingPuzzle[index]
            }
            for (idx, index) in layer.right.enumerated() {
                rotatedPuzzle[layer.bottom[idx]] = incomingPuzzle[index]
            }
            for (idx, index) in layer.bottom.enumerated() {
                rotatedPuzzle[layer.left[idx]] = incomingPuzzle[index]
            }
            for (idx, index) in layer.left.enumerated() {
                rotatedPuzzle[layer.top[idx]] = incomingPuzzle[index]
            }
        }
        
        return rotatedPuzzle
    }
    
    func reflectPuzzle(_ incomingPuzzle: [String], diagonal: Int) -> [String] {
        var reflectedPuzzle = incomingPuzzle
        
        let even = diagonal % 2 == 0
        
        if even {
            // Reflect about top-right(8) to bottom-left(72) diagonal
            for (idx, unitRow) in PuzzleLets.globalVar.unitsRows.enumerated() {
                let unitRowValues = unitRow.map { incomingPuzzle[$0] }
                var reversedUnitRowValues = unitRowValues
                reversedUnitRowValues = reversedUnitRowValues.reversed() // reverse() is lazyload so you can't index on it unless you force load by first initializing the array
                for (indx, colIdx) in PuzzleLets.globalVar.unitsCols[8-idx].enumerated() {
                    reflectedPuzzle[colIdx] = reversedUnitRowValues[indx]
                }
            }
        } else {
            // Reflect about top-left(0) to bottom-right(80) diagonal
            for (idx, unitRow) in PuzzleLets.globalVar.unitsRows.enumerated() {
                let unitRowValues = unitRow.map { incomingPuzzle[$0] }
                for (indx, colIdx) in PuzzleLets.globalVar.unitsCols[idx].enumerated() {
                    reflectedPuzzle[colIdx] = unitRowValues[indx]
                }
            }
        }
        
        return reflectedPuzzle
    }
    
    func reflectPuzzle(_ incomingPuzzle: [String], axis: Int) -> [String] {
        var reflectedPuzzle = incomingPuzzle
        
        let even = axis % 2 == 0
        
        if even {
            // Reflect about the middle row
            for (_, unit) in PuzzleLets.globalVar.unitsCols.enumerated() {
                let unitValues = unit.map { incomingPuzzle[$0] }
                var reversedUnitValues = unitValues
                reversedUnitValues = reversedUnitValues.reversed() // reverse() is lazyload so you can't index on it unless you force load by first initializing the array
                for (indx, square) in unit.enumerated() {
                    reflectedPuzzle[square] = reversedUnitValues[indx]
                }
            }
        } else {
            // Reflect about the middle column
            for (_, unit) in PuzzleLets.globalVar.unitsRows.enumerated() {
                let unitValues = unit.map { incomingPuzzle[$0] }
                var reversedUnitValues = unitValues
                reversedUnitValues = reversedUnitValues.reversed() // reverse() is lazyload so you can't index on it unless you force load by first initializing the array
                for (indx, square) in unit.enumerated() {
                    reflectedPuzzle[square] = reversedUnitValues[indx]
                }
            }
        }
        
        return reflectedPuzzle
    }
    
    //
    // swapValue of 0, swaps 0&1
    // swapValue of 1, swaps 0&2
    // swapValue of 2, swaps 1&2
    // swapValue of 4, swaps 0&1 and 1&2
    // swapValue of 5, swaps 0&2 and 1&2
    //
    func swapTrios(_ incomingGivenPuzzle: [String], swapTrio: [[Int]], swapValue: Int) -> [String] {
        var swappedGivenPuzzle = incomingGivenPuzzle
        
        switch swapValue {
        case 0:
            swappedGivenPuzzle = swapTriosOfPuzzle(incomingGivenPuzzle, swapTrio: swapTrio, swapValue: 0)
        case 1:
            swappedGivenPuzzle = swapTriosOfPuzzle(incomingGivenPuzzle, swapTrio: swapTrio, swapValue: 1)
        case 2:
            swappedGivenPuzzle = swapTriosOfPuzzle(incomingGivenPuzzle, swapTrio: swapTrio, swapValue: 2)
        case 3:
            swappedGivenPuzzle = swapTriosOfPuzzle(incomingGivenPuzzle, swapTrio: swapTrio, swapValue: 0)
            swappedGivenPuzzle = swapTriosOfPuzzle(swappedGivenPuzzle, swapTrio: swapTrio, swapValue: 1)
        case 4:
            swappedGivenPuzzle = swapTriosOfPuzzle(incomingGivenPuzzle, swapTrio: swapTrio, swapValue: 0)
            swappedGivenPuzzle = swapTriosOfPuzzle(swappedGivenPuzzle, swapTrio: swapTrio, swapValue: 2)
        default:
            print("swapTrios: Unexpected swapValue of \(swapValue) received!")
            break
        }
        
        return swappedGivenPuzzle
    }
    
    //
    // swapValue of 0, swaps 0&1
    // swapValue of 1, swaps 0&2
    // swapValue of 2, swaps 1&2
    //
    func swapTriosOfPuzzle(_ incomingPuzzle: [String], swapTrio: [[Int]], swapValue: Int) -> [String] {
        var swappedPuzzle = incomingPuzzle
        
        var trios = [(from: 0, to: 1)]
        trios.append((from: 0, to: 2))
        trios.append((from: 1, to: 2))
        
        //print("swapTriosOfPuzzle: swapValue = \(swapValue), trios.from: \(trios[swapValue].from), trios.to: \(trios[swapValue].to)")
        
        for idx in 0...2 {
            let fromUnit = swapTrio[idx+3*trios[swapValue].from]
            //println("swapTriosOfPuzzle: idx+3*bands[swapValue].from = \(idx+3*trios[swapValue].from)")
            let fromUnitValues = fromUnit.map { incomingPuzzle[$0] }
            
            let toUnit = swapTrio[idx+3*trios[swapValue].to]
            for (indx, fromUnitValue) in fromUnitValues.enumerated() {
                swappedPuzzle[toUnit[indx]] = fromUnitValue
            }
        }
        
        for idx in 0...2 {
            let fromUnit = swapTrio[idx+3*trios[swapValue].to]
            //print("swapTriosOfPuzzle: idx+3*bands[swapValue].to = \(idx+3*trios[swapValue].to)")
            let fromUnitValues = fromUnit.map { incomingPuzzle[$0] }
            
            let toUnit = swapTrio[idx+3*trios[swapValue].from]
            for (indx, fromUnitValue) in fromUnitValues.enumerated() {
                swappedPuzzle[toUnit[indx]] = fromUnitValue
            }
        }
        
        return swappedPuzzle
    }
    
    //
    // swapValue of 0, swaps among 1st Band/Stack
    // swapValue of 1, swaps among 2nd Band/Stack
    // swapValue of 2, swaps among 3rd Band/Stack
    // swapValue of 3, swaps among both 1st & 2nd Bands/Stacks
    // swapValue of 4, swaps among both 1st & 3rd Bands/Stacks
    // swapValue of 5, swaps among both 2nd & 3rd Bands/Stacks
    // swapValue of 6, swaps among all Bands/Stacks
    //
    func swapTriosOfUnits(_ incomingGivenPuzzle: [String], incomingSolutionPuzzle: [String], swapTrio: [[Int]], swapValue: Int) -> (swappedGivenPuzzle: [String], swappedSolutionPuzzle: [String]) {
        var swappedGivenPuzzle = incomingGivenPuzzle
        var swappedSolutionPuzzle = incomingSolutionPuzzle
        
        switch swapValue {
        case 0:
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 0)
        case 1:
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 3)
        case 2:
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 6)
        case 3:
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 0)
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 3)
        case 4:
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 0)
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 6)
        case 5:
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 3)
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 6)
        case 6:
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 0)
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 3)
            (swappedGivenPuzzle, swappedSolutionPuzzle) = swapWithinUnit(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: swapTrio, unitIndex: 6)
        default:
            print("swapTriosOfUnits: Unexpected swapValue of \(swapValue) received!")
            break
        }
        
        return (swappedGivenPuzzle, swappedSolutionPuzzle)
    }
    
    //
    // swapValue of 0, swaps 0&1
    // swapValue of 1, swaps 0&2
    // swapValue of 2, swaps 1&2
    //
    func swapWithinUnit(_ incomingGivenPuzzle: [String], incomingSolutionPuzzle: [String], swapTrio: [[Int]], unitIndex: Int) -> ([String], [String]) {
        var swappedGivenPuzzle = incomingGivenPuzzle
        var swappedSolutionPuzzle = incomingSolutionPuzzle
        
        var trios = [(from: 0, to: 1)]
        trios.append((from: 0, to: 2))
        trios.append((from: 1, to: 2))
        
        let swap = Int(arc4random_uniform(UInt32(trios.count-1)))
        //println("swapWithinUnit: swap = \(swap)")
        
        // GivenPuzzle
        var fromUnit = swapTrio[unitIndex+trios[swap].from]
        var fromUnitValues = fromUnit.map { incomingGivenPuzzle[$0] }
        
        var toUnit = swapTrio[unitIndex+trios[swap].to]
        for (indx, fromUnitValue) in fromUnitValues.enumerated() {
            swappedGivenPuzzle[toUnit[indx]] = fromUnitValue
        }
        
        fromUnit = swapTrio[unitIndex+trios[swap].to]
        fromUnitValues = fromUnit.map { incomingGivenPuzzle[$0] }
        
        toUnit = swapTrio[unitIndex+trios[swap].from]
        for (indx, fromUnitValue) in fromUnitValues.enumerated() {
            swappedGivenPuzzle[toUnit[indx]] = fromUnitValue
        }
        
        // SolutionPuzzle
        fromUnit = swapTrio[unitIndex+trios[swap].from]
        fromUnitValues = fromUnit.map { incomingSolutionPuzzle[$0] }
        
        toUnit = swapTrio[unitIndex+trios[swap].to]
        for (indx, fromUnitValue) in fromUnitValues.enumerated() {
            swappedSolutionPuzzle[toUnit[indx]] = fromUnitValue
        }
        
        fromUnit = swapTrio[unitIndex+trios[swap].to]
        fromUnitValues = fromUnit.map { incomingSolutionPuzzle[$0] }
        
        toUnit = swapTrio[unitIndex+trios[swap].from]
        for (indx, fromUnitValue) in fromUnitValues.enumerated() {
            swappedSolutionPuzzle[toUnit[indx]] = fromUnitValue
        }
        
        return (swappedGivenPuzzle, swappedSolutionPuzzle)
    }
    
    func swapBandsOfPuzzle(_ incomingPuzzle: [String], swapValue: Int) -> [String] {
        
        return swapTrios(incomingPuzzle, swapTrio: PuzzleLets.globalVar.unitsRows, swapValue: swapValue)
    }
    
    func swapRowsOfPuzzle(_ incomingGivenPuzzle: [String], incomingSolutionPuzzle: [String], swapValue: Int) -> ([String], [String]) {
        
        return swapTriosOfUnits(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: PuzzleLets.globalVar.unitsRows, swapValue: swapValue)
    }
    
    func swapStacksOfPuzzle(_ incomingPuzzle: [String], swapValue: Int) -> [String] {
        
        return swapTrios(incomingPuzzle, swapTrio: PuzzleLets.globalVar.unitsCols, swapValue: swapValue)
    }
    
    func swapColsOfPuzzle(_ incomingGivenPuzzle: [String], incomingSolutionPuzzle: [String], swapValue: Int) -> ([String], [String]) {
        
        return swapTriosOfUnits(incomingGivenPuzzle, incomingSolutionPuzzle: incomingSolutionPuzzle, swapTrio: PuzzleLets.globalVar.unitsCols, swapValue: swapValue)
    }
    
}
