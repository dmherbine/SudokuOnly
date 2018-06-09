//
//  UtilityFuncsTests.swift
//  Sudoku
//
//  Created by dave herbine on 6/4/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit
import XCTest

class UtilityFuncsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPrintPuzzle() {
        // Following Hard puzzle (Arto 22 givens, 9 values) can not be solved with constraint propagation
        let ArtoPuzzle =
        ["8", "5", "", "", "", "2", "4", "", "",
            "7", "2", "", "", "", "", "", "", "9",
            "", "", "4", "", "", "", "", "", "",
            "", "", "", "1", "", "7", "", "", "2",
            "3", "", "5", "", "", "", "9", "", "",
            "", "4", "", "", "", "", "", "", "",
            "", "", "", "", "8", "", "", "7", "",
            "", "1", "7", "", "", "", "", "", "",
            "", "", "", "", "3", "6", "", "4", ""]
        printPuzzle(ArtoPuzzle)
        
        let ArtoPuzzleCPSolution =
        ["347", "347", "37", "1", "5", "278", "6", "9", "2348",
            "1479", "45679", "8", "279", "3", "2679", "1245", "145", "245",
            "2", "3569", "136", "89", "69", "4", "7", "1358", "358",
            "6", "37", "137", "34578", "17", "578", "9", "2", "3458",
            "5", "239", "123", "23489", "1269", "2689", "148", "1348", "7",
            "1379", "8", "4", "23579", "1279", "2579", "15", "135", "6",
            "3478", "2347", "9", "6", "27", "257", "2458", "4578", "1",
            "47", "2467", "267", "2579", "8", "1", "3", "457", "2459",
            "78", "1", "5", "279", "4", "3", "28", "6", "289"]
        printPuzzle(ArtoPuzzleCPSolution)
        
        let TestPuzzle1 =
        ["1", "1", "1", "1", "1", "1", "1", "1", "1",
            "12", "12", "12", "12", "12", "12", "12", "12", "12",
            "123", "123", "123", "123", "123", "123", "123", "123", "123",
            "1234", "1234", "1234", "1234", "1234", "1234", "1234", "1234", "1234",
            "12345", "12345", "12345", "12345", "12345", "12345", "12345", "12345", "12345",
            "123456", "123456", "123456", "123456", "123456", "123456", "123456", "123456", "123456",
            "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567",
            "12345678", "12345678", "12345678", "12345678", "12345678", "12345678", "12345678", "12345678", "12345678",
            "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789", "123456789"]
        printPuzzle(TestPuzzle1)
        
        let TestPuzzle2 =
        ["1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789",
            "1", "12", "123", "1234", "12345", "123456", "1234567", "12345678", "123456789"]
        printPuzzle(TestPuzzle2)
    }
    
    func testCheckUnit() {
        var Artn: states = .solved
        
        let illegalUnit = ["1","2","3","4","5","6","7"]
        Artn = checkUnit(illegalUnit)
        XCTAssertEqual(states.invalid, Artn, "checkUnit: unit is invalid!")
        
        let invalidUnit = ["1","2","3","","5","6","7","8","9"] // this could happen when reducing with a bad guess
        Artn = checkUnit(invalidUnit)
        XCTAssertEqual(states.invalid, Artn, "checkUnit: \"\" in unit is invalid!")
        
        let duplicateUnit = ["1","1","1","1","1","1","1","1","1"]
        Artn = checkUnit(duplicateUnit)
        XCTAssertEqual(states.invalid, Artn, "checkUnit: unit is invalid!")
        
        let reducibleUnitA = ["1","12","13","14","15","16","17","18","19"]
        Artn = checkUnit(reducibleUnitA)
        XCTAssertEqual(states.valid, Artn, "checkUnit: unit is valid!")
        
        let reducibleUnitB = ["1","12","3","34","5","1356","17","18","19"]
        Artn = checkUnit(reducibleUnitB)
        XCTAssertEqual(states.valid, Artn, "checkUnit: unit is valid!")
        
        let solvedUnit1 = ["1","2","3","4","5","6","7","8","9"]
        Artn = checkUnit(solvedUnit1)
        XCTAssertEqual(states.solved, Artn, "checkUnit: unit is solved!")
        
        let solvedUnit2 = ["1","3","5","7","9","8","6","4","2"]
        Artn = checkUnit(solvedUnit2)
        XCTAssertEqual(states.solved, Artn, "checkUnit: unit is solved!")
    }
    
    func testIndexesOfUnitsDict() {
        var ErtnKey = 0
        var ErtnValue = [0,9,18]    //indexes of unitsArray for ErtnKey
        
        if let ArtnValue = PuzzleLets.globalVar.indexesOfUnitsDict[ErtnKey] {
            XCTAssertEqual(ErtnValue, ArtnValue, "testIndexesOfUnitsDict: values are as expected!")
        } else {
            print("testIndexesOfUnitsDict: couldn't find key: \(ErtnKey) in PuzzleLets.globalVar.indexesOfUnitsDict!")
        }
        ErtnKey = 80
        ErtnValue = [8,17,26]    //indexes of unitsArray for ErtnKey
        
        if let ArtnValue = PuzzleLets.globalVar.indexesOfUnitsDict[ErtnKey] {
            XCTAssertEqual(ErtnValue, ArtnValue, "testIndexesOfUnitsDict: values are as expected!")
        } else {
            print("testIndexesOfUnitsDict: couldn't find key: \(ErtnKey) in PuzzleLets.globalVar.indexesOfUnitsDict!")
        }
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
