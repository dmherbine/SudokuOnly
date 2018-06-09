//
//  DeadCode.swift
//  Sudoku
//
//  Created by dave herbine on 4/11/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

// MARK SudokuCVController Class Controller Code

// I'll need the following if I allow multiple cell selection...
//            if let selectedCells = self.collectionView?.indexPathsForSelectedItems() {
//                for selected in selectedCells {
//                    if let selectedCell = selected as? NSIndexPath {

//                            if selectedCell != nil {
//                                var cell = self.collectionView!.cellForItemAtIndexPath(selectedCell!) as SudokuCVCell
//                            }

//func highlightButtons() {
//    
//    // ONE: reset all buttons
//    unHighlightButtons()
//    
//    // TWO: put a border around any and all playableDigits
//    if playableDigits != nil {
//        for digit in playableDigits! {
//            if let btn = sCVDataSource.getButtonWithTitle("\(digit)", buttonArray: buttonArray) {
//                btn.layer.borderColor = defaultColor.CGColor
//                btn.layer.borderWidth = sGridSize.cellBorderWidth*2
//            }
//        }
//    }
//    
//    // THREE highlight keypadDigit or last digit of playableDigits
//    //        if keypadDigit != nil {
//    //            if let btn = sCVDataSource.getButtonWithTitle("\(keypadDigit!)", buttonArray: buttonArray) {
//    ////                btn.backgroundColor = bluishColor
//    //                btn.layer.borderColor = defaultColor.CGColor
//    //                btn.layer.borderWidth = sGridSize.cellBorderWidth*2
//    //            }
//    //
//    //        } else if playableDigits != nil {
//    //            if let btn = sCVDataSource.getButtonWithTitle("\(getLastDigitOf(playableDigits!))", buttonArray: buttonArray) {
//    ////                btn.backgroundColor = bluishColor
//    //                btn.layer.borderColor = defaultColor.CGColor
//    //                btn.layer.borderWidth = sGridSize.cellBorderWidth*2
//    //            }
//    //        }
//    
//}
//
//func unHighlightButtons() {
//    for digit in "123456789" {
//        if let btn = sCVDataSource.getButtonWithTitle("\(digit)", buttonArray: buttonArray) {
//            btn.backgroundColor = UIColor.blackColor()
//            //btn.layer.borderColor = defaultColor.CGColor
//            btn.layer.borderWidth = 0   //sGridSize.cellBorderWidth
//        }
//    }
//}

//func highlightBtnsWithDigits(digits: String, highlightColor: UIColor) {
//    for digit in digits {
//        if let btn = sCVDataSource.getButtonWithTitle("\(digit)", buttonArray: buttonArray) {
//            btn.backgroundColor = highlightColor
//            btn.layer.borderColor = defaultColor.CGColor
//            btn.layer.borderWidth = sGridSize.cellBorderWidth
//        }
//    }
//}
//
//func highlightButtonWithDigit(btnDigit: String, highlightColor: UIColor) {
//    for digit in "123456789" {
//        if let btn = sCVDataSource.getButtonWithTitle("\(digit)", buttonArray: buttonArray) {
//            if String(digit) == btnDigit {
//                btn.backgroundColor = highlightColor
//                btn.layer.borderColor = defaultColor.CGColor
//                btn.layer.borderWidth = sGridSize.cellBorderWidth
//            } else {
//                btn.backgroundColor = UIColor.blackColor()
//                //btn.layer.borderColor = defaultColor.CGColor
//                btn.layer.borderWidth = 0   //sGridSize.cellBorderWidth
//            }
//        }
//    }
//}
//
//func unHighlightBtnsWithDigits(digits: String) {
//    for digit in digits {
//        if let btn = sCVDataSource.getButtonWithTitle("\(digit)", buttonArray: buttonArray) {
//            btn.backgroundColor = UIColor.blackColor()
//            //btn.layer.borderColor = defaultColor.CGColor
//            btn.layer.borderWidth = 0   //sGridSize.cellBorderWidth
//        }
//    }
//}

//func highlightCellsWithDigits(digits: String, highlightColor: UIColor) {
//    //        println("highlightCellsWithDigits: digits = \"\(digits)\"")
//    
//    unHighlightCells()
//    
//    for cell in self.collectionView!.visibleCells() as! [UICollectionViewCell] {
//        if let idxPath = self.collectionView!.indexPathForCell(cell) {
//            for digit in digits {
//                if sCVDataSource.sGame.playerPuzzle[idxPath.row].rangeOfString(String(digit)) != nil {
//                    self.collectionView!.cellForItemAtIndexPath(idxPath)?.backgroundColor = highlightColor
//                    break
//                }
//            }
//        }
//    }
//}
//
//func unHighlightCellsWithDigits(digits: String) {
//    //        println("unHighlightCellsWithDigits: digits = \"\(digits)\"")
//    let highlightColor = UIColor.whiteColor()
//    
//    for digit in digits {
//        for cell in self.collectionView!.visibleCells() as! [UICollectionViewCell] {
//            if let idxPath = self.collectionView!.indexPathForCell(cell) {
//                if sCVDataSource.sGame.playerPuzzle[idxPath.row].rangeOfString(String(digit)) != nil {
//                    self.collectionView!.cellForItemAtIndexPath(idxPath)?.backgroundColor = highlightColor
//                }
//            }
//        }
//    }
//}
//
// solveByCP2() essentially feeds eliminate() which performs constraint propagation.
//  I would have thought this faster than feeding assign() but it was actually slower.
//


//func solveByCP2(puzzle: PlayerPuzzleStruct) -> PlayerPuzzleStruct {
//    
//    var cpPuzzle = puzzle
//    cpPuzzle.pPuzzle = puzzle.pPuzzle.map { count($0) == 1 ? $0 : digits }     // fill empties with all digits (1...9)
//    //        cpPuzzle.pState = puzzle.pState
//    //        var cpPuzzle = puzzle.map { $0 == "" ? digits : $0 }     // fill empties with all digits (1...9)
//    
//    // now assign grid values in order of squareLabels
//    for (s, d) in enumerate(puzzle.pPuzzle) {
//        // check that d is a given: length of one and in digits (1...9) and assign it
//        if count(d) == 1 {  //&& digits.rangeOfString(d) != nil {
//            if let neighborKey = getNeighboringKey(cpPuzzle, key: s, given: d) {
//                eliminate(&cpPuzzle, key: neighborKey, digit: d)
//                if cpPuzzle.pState != .valid {  //return if solved or invalid
//                    return cpPuzzle
//                }
//            } else {
//                println("solveByCP2: neighborKey not found!")
//                continue
//            }
//        }
//    }
//    
//    //remove any naked or hidden tuples found in any of the units
//    if cpPuzzle.pState == .valid {
//        println("solveByCP: Here's your valid parsed puzzle before eliminating naked or hidden tuples:")
//        printPuzzle(cpPuzzle.pPuzzle)
//        check4Tuples(&cpPuzzle)
//    }
//    
//    println("solveByCP: Here's your \(cpPuzzle.pState.description) parsed puzzle:")
//    printPuzzle(cpPuzzle.pPuzzle)
//    
//    return cpPuzzle
//}


//func getPeersOfKeyWithDigit(puzzle: PlayerPuzzleStruct, key: Int, digit: String) -> [Int] {
//    var peersOfKeyWithDigit = [Int]()
//    
//    if let peersIndexes = PuzzleLets.globalVar.peersDict[key] {
//        peersOfKeyWithDigit = peersIndexes.filter { puzzle.pPuzzle[$0].rangeOfString(digit) != nil }
//    } else {
//        println("eliminate: could not find key = \(key) in peersDict!")
//    }
//    return peersOfKeyWithDigit
//}

//func leaveDigitAndFirst(digit: String) -> String {
//    var otherDigits = digits
//    let existingIndex = otherDigits.rangeOfString(digit)
//    if existingIndex != nil {
//        otherDigits.removeRange(existingIndex!)
//    }
//    return "\(digit)\(advance(otherDigits.startIndex, 1))"
//}

//func getNeighboringKey(puzzle: PlayerPuzzleStruct, key: Int, given: String) -> Int? {
//    println("getNeighboringKey: given Index = \(key), given digit = \(given)")
//    if let peersIndexes = PuzzleLets.globalVar.peersDict[key] {
//        let unsolvedIndexes = peersIndexes.filter { contains(puzzle.pSolvedUnits, $0) == false }
//        if unsolvedIndexes.isEmpty { return nil }
//        
//        let unsolvedIndexesGT2 = unsolvedIndexes.filter { count(puzzle.pPuzzle[$0]) > 1 }
//        if unsolvedIndexesGT2.isEmpty { return nil }
//        
//        let unsolvedValuesGT2WithGiven = unsolvedIndexesGT2.filter { puzzle.pPuzzle[$0].rangeOfString(given) != nil }
//        if unsolvedValuesGT2WithGiven.isEmpty { return nil }
//        
//        println("getNeighboringKey: neighborKey = \(unsolvedValuesGT2WithGiven.first!)")
//        return unsolvedValuesGT2WithGiven.first!
//    }
//    return nil
//}




