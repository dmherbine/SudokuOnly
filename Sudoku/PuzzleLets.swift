//
//  PuzzleLets.swift
//  Sudoku
//
//  Created by dave herbine on 5/9/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

class PuzzleLets: NSObject {
    
    let numberOfSquares = 80
    let numberOfUnits = 27
    var unitsArray = [[Int]]()
    var unitsRows = [[Int]]()
    var unitsCols = [[Int]]()
    var indexesOfUnitsDict = [Int: [Int]](minimumCapacity: 81) //each [Int] contains the three indexes into unitsArray
    var peersDict = [Int: [Int]](minimumCapacity: 81)
    
    // rows
    let u0 = [0,1,2,3,4,5,6,7,8]
    let u1 = [9,10,11,12,13,14,15,16,17]
    let u2 = [18,19,20,21,22,23,24,25,26]
    let u3 = [27,28,29,30,31,32,33,34,35]
    let u4 = [36,37,38,39,40,41,42,43,44]
    let u5 = [45,46,47,48,49,50,51,52,53]
    let u6 = [54,55,56,57,58,59,60,61,62]
    let u7 = [63,64,65,66,67,68,69,70,71]
    let u8 = [72,73,74,75,76,77,78,79,80]
    // columns
    let u9 =  [0,9,18,27,36,45,54,63,72]
    let u10 = [1,10,19,28,37,46,55,64,73]
    let u11 = [2,11,20,29,38,47,56,65,74]
    let u12 = [3,12,21,30,39,48,57,66,75]
    let u13 = [4,13,22,31,40,49,58,67,76]
    let u14 = [5,14,23,32,41,50,59,68,77]
    let u15 = [6,15,24,33,42,51,60,69,78]
    let u16 = [7,16,25,34,43,52,61,70,79]
    let u17 = [8,17,26,35,44,53,62,71,80]
    // blocks
    let u18 = [0,1,2,9,10,11,18,19,20]
    let u19 = [3,4,5,12,13,14,21,22,23]
    let u20 = [6,7,8,15,16,17,24,25,26]
    let u21 = [27,28,29,36,37,38,45,46,47]
    let u22 = [30,31,32,39,40,41,48,49,50]
    let u23 = [33,34,35,42,43,44,51,52,53]
    let u24 = [54,55,56,63,64,65,72,73,74]
    let u25 = [57,58,59,66,67,68,75,76,77]
    let u26 = [60,61,62,69,70,71,78,79,80]
    
    override init() {
        //
        // Generate unitsArray
        //
        unitsArray.append(u0)
        unitsArray.append(u1)
        unitsArray.append(u2)
        unitsArray.append(u3)
        unitsArray.append(u4)
        unitsArray.append(u5)
        unitsArray.append(u6)
        unitsArray.append(u7)
        unitsArray.append(u8)
        unitsArray.append(u9)
        unitsArray.append(u10)
        unitsArray.append(u11)
        unitsArray.append(u12)
        unitsArray.append(u13)
        unitsArray.append(u14)
        unitsArray.append(u15)
        unitsArray.append(u16)
        unitsArray.append(u17)
        unitsArray.append(u18)
        unitsArray.append(u19)
        unitsArray.append(u20)
        unitsArray.append(u21)
        unitsArray.append(u22)
        unitsArray.append(u23)
        unitsArray.append(u24)
        unitsArray.append(u25)
        unitsArray.append(u26)
        
        //
        // Generate unitsRows
        //
        unitsRows.append(u0)
        unitsRows.append(u1)
        unitsRows.append(u2)
        unitsRows.append(u3)
        unitsRows.append(u4)
        unitsRows.append(u5)
        unitsRows.append(u6)
        unitsRows.append(u7)
        unitsRows.append(u8)
        
        //
        // Generate unitsCols
        //
        unitsCols.append(u9)
        unitsCols.append(u10)
        unitsCols.append(u11)
        unitsCols.append(u12)
        unitsCols.append(u13)
        unitsCols.append(u14)
        unitsCols.append(u15)
        unitsCols.append(u16)
        unitsCols.append(u17)
        
        //
        // Generate indexesOfUnitsDict - each key is a square, and its values are the three indexes of unitsArray.
        //
        for idx in 0...numberOfSquares {
            var threeIndexes = [Int]()
            for (indx, unit) in unitsArray.enumerated() {
                if unit.contains(idx) {
                    threeIndexes.append(indx)
                }
            }
            if threeIndexes.count == 3 {
                indexesOfUnitsDict[idx] = threeIndexes
                //print("indexesOfUnitsDict[\(idx)] = \(indexesOfUnitsDict[idx]!)")
            } else {
                print("PuzzleLets: threeIndexes does not have a count of 3!  But count(unitsArray) = \(unitsArray.count)")
            }
        }
        
        //
        // Generate peersDict - the indexes of a square's peers
        //
        for idx in 0...numberOfSquares {
            var concatenatedUnits = [Int]()
            if let threeIndexes = indexesOfUnitsDict[idx] {
                for oneIndex in threeIndexes {
                    concatenatedUnits += unitsArray[oneIndex]
                }
            }
            let peersDictSet = Set(concatenatedUnits).filter { $0 != idx }
            peersDict[idx] = peersDictSet.sorted()
        }
        
//        for peer in peersDict {
//            print("PuzzleLets: peersDict[\(peer.key)] = \(peer.value)")
//        }
        
    }
    
    //Create a class variable as a computed type property. The class variable can be called without having to instantiate the class PuzzleLets
    class var globalVar: PuzzleLets {
        
        //Nested within the class variable is a struct called "Singleton"
        struct Singleton {
            
            //Singleton wraps a static constant variable "instance". Declaring a property as static means this property only exists once. Also note that static properties in Swift are implicitly lazy, which means that Instance is not created until it’s needed.
            static let instance = PuzzleLets()
        }
        
        return Singleton.instance
    }
    
}
