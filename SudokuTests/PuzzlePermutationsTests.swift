//
//  PuzzlePermutationsTests.swift
//  Sudoku
//
//  Created by dave herbine on 8/22/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation
import XCTest

class PuzzlePermutationsTests: XCTestCase {
    
    var pzl = Puzzle()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //uniquePuzzleSolutions = [[String]]()    // array of arrays
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRelabelSequence() {
        var Artn = [String]()
        
        Artn = pzl.relabelSequence()
        XCTAssertEqual(Artn.count, 9, "testRelabelSequnce: relabel values are valid!")
    }
    
    func testRotatePuzzle() {
        let incomingPuzzle =
        ["1", "2", "3", "4", "5", "6", "7", "8", "9",
            "10", "11", "12", "13", "14", "15", "16", "17", "18",
            "19", "20", "21", "22", "23", "24", "25", "26", "27",
            "28", "29", "30", "31", "32", "33", "34", "35", "36",
            "37", "38", "39", "40", "41", "42", "43", "44", "45",
            "46", "47", "48", "49", "50", "51", "52", "53", "54",
            "55", "56", "57", "58", "59", "60", "61", "62", "63",
            "64", "65", "66", "67", "68", "69", "70", "71", "72",
            "73", "74", "75", "76", "77", "78", "79", "80", "81"]
        
        let Ertn =
        ["73", "64", "55", "46", "37", "28", "19", "10", "1",
            "74", "65", "56", "47", "38", "29", "20", "11", "2",
            "75", "66", "57", "48", "39", "30", "21", "12", "3",
            "76", "67", "58", "49", "40", "31", "22", "13", "4",
            "77", "68", "59", "50", "41", "32", "23", "14", "5",
            "78", "69", "60", "51", "42", "33", "24", "15", "6",
            "79", "70", "61", "52", "43", "34", "25", "16", "7",
            "80", "71", "62", "53", "44", "35", "26", "17", "8",
            "81", "72", "63", "54", "45", "36", "27", "18", "9"]
        
        let rotatedPuzzle = pzl.rotatePuzzle(incomingPuzzle)
        //print("testRotatePuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        
        //print("testRotatePuzzle: rotated puzzle:")
        //printPuzzle(rotatedPuzzle)
        
        XCTAssertEqual(Ertn, rotatedPuzzle, "testRotatePuzzle: rotated as expected!")
        
//        var rPuzzle = incomingPuzzle
//        print("testRotatePuzzle: incoming puzzle:")
//        printPuzzle(incomingPuzzle)
//        for x in 0...3 {
//            rPuzzle = pzl.rotatePuzzle(rPuzzle)
//            print("testRotatePuzzle: rotated \(x+1) times:")
//            printPuzzle(rPuzzle)
//        }
        
    }
    
    func testReflectPuzzle() {
        let incomingPuzzle =
        ["1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9",
            "10", "11", "12", "13", "14", "15", "16", "17", "18",
            "19", "20", "21", "22", "23", "24", "25", "26", "27",
            "28", "29", "30", "31", "32", "33", "34", "35", "36",
            "37", "38", "39", "40", "41", "42", "43", "44", "45",
            "46", "47", "48", "49", "50", "51", "52", "53", "54",
            "55", "56", "57", "58", "59", "60", "61", "62", "63",
            "64", "65", "66", "67", "68", "69", "70", "71", "72",
            "73", "74", "75", "76", "77", "78", "79", "80", "81"]
        
        let Ertn0 =
        ["81", "72", "63", "54", "45", "36", "27", "18", "9",
            "80", "71", "62", "53", "44", "35", "26", "17", "8",
            "79", "70", "61", "52", "43", "34", "25", "16", "7",
            "78", "69", "60", "51", "42", "33", "24", "15", "6",
            "77", "68", "59", "50", "41", "32", "23", "14", "5",
            "76", "67", "58", "49", "40", "31", "22", "13", "4",
            "75", "66", "57", "48", "39", "30", "21", "12", "3",
            "74", "65", "56", "47", "38", "29", "20", "11", "2",
            "73", "64", "55", "46", "37", "28", "19", "10", "1"]
        
        let Ertn1 =
        ["1", "10", "19", "28", "37", "46", "55", "64", "73",
            "2", "11", "20", "29", "38", "47", "56", "65", "74",
            "3", "12", "21", "30", "39", "48", "57", "66", "75",
            "4", "13", "22", "31", "40", "49", "58", "67", "76",
            "5", "14", "23", "32", "41", "50", "59", "68", "77",
            "6", "15", "24", "33", "42", "51", "60", "69", "78",
            "7", "16", "25", "34", "43", "52", "61", "70", "79",
            "8", "17", "26", "35", "44", "53", "62", "71", "80",
            "9", "18", "27", "36", "45", "54", "63", "72", "81"]
        
        let incomingPuzzle2 =
        ["1", "1", "1", "1", "1", "1", "1", "1", "1",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "3", "3", "3", "3", "3", "3", "3", "3", "3",
            "4", "4", "4", "4", "4", "4", "4", "4", "4",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "6", "6", "6", "6", "6", "6", "6", "6", "6",
            "7", "7", "7", "7", "7", "7", "7", "7", "7",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "9", "9", "9", "9", "9", "9", "9", "9", "9"]
        
        let Ertn2 =
        ["9", "9", "9", "9", "9", "9", "9", "9", "9",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "7", "7", "7", "7", "7", "7", "7", "7", "7",
            "6", "6", "6", "6", "6", "6", "6", "6", "6",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "4", "4", "4", "4", "4", "4", "4", "4", "4",
            "3", "3", "3", "3", "3", "3", "3", "3", "3",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "1", "1", "1", "1", "1", "1", "1", "1", "1"]
        
        let incomingPuzzle3 =
        [ "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        let Ertn3 =
        [ "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1",
            "9", "8", "7", "6", "5", "4", "3", "2", "1"]
        
        var reflectedPuzzle = pzl.reflectPuzzle(incomingPuzzle, diagonal: 0)
        //println("testReflectPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        
        //println("testReflectPuzzle: reflected puzzle:")
        //printPuzzle(reflectedPuzzle)
        
        XCTAssertEqual(Ertn0, reflectedPuzzle, "testReflectPuzzle: reflected as expected!")
        
        reflectedPuzzle = pzl.reflectPuzzle(incomingPuzzle, diagonal: 1)
        //println("testReflectPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        
        //println("testReflectPuzzle: reflected puzzle:")
        //printPuzzle(reflectedPuzzle)
        
        XCTAssertEqual(Ertn1, reflectedPuzzle, "testReflectPuzzle: reflected as expected!")
        
        reflectedPuzzle = pzl.reflectPuzzle(incomingPuzzle2, axis: 0)
        //println("testReflectPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle2)
        
        //println("testReflectPuzzle: reflected puzzle:")
        //printPuzzle(reflectedPuzzle)
        
        XCTAssertEqual(Ertn2, reflectedPuzzle, "testReflectPuzzle: reflected as expected!")
        
        reflectedPuzzle = pzl.reflectPuzzle(incomingPuzzle3, axis: 1)
        //println("testReflectPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle3)
        
        //println("testReflectPuzzle: reflected puzzle:")
        //printPuzzle(reflectedPuzzle)
        
        XCTAssertEqual(Ertn3, reflectedPuzzle, "testReflectPuzzle: reflected as expected!")
        
    }
    
    func testSwapBandsOfPuzzle() {
        let incomingPuzzle =
        ["1", "1", "1", "1", "1", "1", "1", "1", "1",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "3", "3", "3", "3", "3", "3", "3", "3", "3",
            "4", "4", "4", "4", "4", "4", "4", "4", "4",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "6", "6", "6", "6", "6", "6", "6", "6", "6",
            "7", "7", "7", "7", "7", "7", "7", "7", "7",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "9", "9", "9", "9", "9", "9", "9", "9", "9"]
        
        let Ertn0 =
        ["4", "4", "4", "4", "4", "4", "4", "4", "4",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "6", "6", "6", "6", "6", "6", "6", "6", "6",
            "1", "1", "1", "1", "1", "1", "1", "1", "1",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "3", "3", "3", "3", "3", "3", "3", "3", "3",
            "7", "7", "7", "7", "7", "7", "7", "7", "7",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "9", "9", "9", "9", "9", "9", "9", "9", "9"]
        
        let Ertn1 =
        ["7", "7", "7", "7", "7", "7", "7", "7", "7",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "9", "9", "9", "9", "9", "9", "9", "9", "9",
            "4", "4", "4", "4", "4", "4", "4", "4", "4",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "6", "6", "6", "6", "6", "6", "6", "6", "6",
            "1", "1", "1", "1", "1", "1", "1", "1", "1",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "3", "3", "3", "3", "3", "3", "3", "3", "3"]
        
        let Ertn2 =
        ["1", "1", "1", "1", "1", "1", "1", "1", "1",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "3", "3", "3", "3", "3", "3", "3", "3", "3",
            "7", "7", "7", "7", "7", "7", "7", "7", "7",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "9", "9", "9", "9", "9", "9", "9", "9", "9",
            "4", "4", "4", "4", "4", "4", "4", "4", "4",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "6", "6", "6", "6", "6", "6", "6", "6", "6"]
        
        let Ertn3 =
        ["7", "7", "7", "7", "7", "7", "7", "7", "7",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "9", "9", "9", "9", "9", "9", "9", "9", "9",
            "1", "1", "1", "1", "1", "1", "1", "1", "1",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "3", "3", "3", "3", "3", "3", "3", "3", "3",
            "4", "4", "4", "4", "4", "4", "4", "4", "4",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "6", "6", "6", "6", "6", "6", "6", "6", "6"]
        
        let Ertn4 =
        ["4", "4", "4", "4", "4", "4", "4", "4", "4",
            "5", "5", "5", "5", "5", "5", "5", "5", "5",
            "6", "6", "6", "6", "6", "6", "6", "6", "6",
            "7", "7", "7", "7", "7", "7", "7", "7", "7",
            "8", "8", "8", "8", "8", "8", "8", "8", "8",
            "9", "9", "9", "9", "9", "9", "9", "9", "9",
            "1", "1", "1", "1", "1", "1", "1", "1", "1",
            "2", "2", "2", "2", "2", "2", "2", "2", "2",
            "3", "3", "3", "3", "3", "3", "3", "3", "3"]
        
        var swappedPuzzle = pzl.swapBandsOfPuzzle(incomingPuzzle, swapValue: 0)
        //println("testSwapBandsOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapBandsOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn0, swappedPuzzle, "testSwapBandsOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapBandsOfPuzzle(incomingPuzzle, swapValue: 1)
        //println("testSwapBandsOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapBandsOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn1, swappedPuzzle, "testSwapBandsOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapBandsOfPuzzle(incomingPuzzle, swapValue: 2)
        //println("testSwapBandsOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapBandsOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn2, swappedPuzzle, "testSwapBandsOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapBandsOfPuzzle(incomingPuzzle, swapValue: 3)
        //println("testSwapBandsOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapBandsOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn3, swappedPuzzle, "testSwapBandsOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapBandsOfPuzzle(incomingPuzzle, swapValue: 4)
        //println("testSwapBandsOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapBandsOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn4, swappedPuzzle, "testSwapBandsOfPuzzle: swapped as expected!")
        
    }
    
    func testSwapRowsOfPuzzle() {
        var ErtnBool = false
        
        let incomingPuzzle =
        ["1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9",
            "10", "11", "12", "13", "14", "15", "16", "17", "18",
            "19", "20", "21", "22", "23", "24", "25", "26", "27",
            "28", "29", "30", "31", "32", "33", "34", "35", "36",
            "37", "38", "39", "40", "41", "42", "43", "44", "45",
            "46", "47", "48", "49", "50", "51", "52", "53", "54",
            "55", "56", "57", "58", "59", "60", "61", "62", "63",
            "64", "65", "66", "67", "68", "69", "70", "71", "72",
            "73", "74", "75", "76", "77", "78", "79", "80", "81"]
        
        let Ertn0 =
        ["10", "11", "12", "13", "14", "15", "16", "17", "18",
            "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9",
            "19", "20", "21", "22", "23", "24", "25", "26", "27",
            "28", "29", "30", "31", "32", "33", "34", "35", "36",
            "37", "38", "39", "40", "41", "42", "43", "44", "45",
            "46", "47", "48", "49", "50", "51", "52", "53", "54",
            "55", "56", "57", "58", "59", "60", "61", "62", "63",
            "64", "65", "66", "67", "68", "69", "70", "71", "72",
            "73", "74", "75", "76", "77", "78", "79", "80", "81"]
        
        let Ertn1 =
        ["19", "20", "21", "22", "23", "24", "25", "26", "27",
            "10", "11", "12", "13", "14", "15", "16", "17", "18",
            "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9",
            "28", "29", "30", "31", "32", "33", "34", "35", "36",
            "37", "38", "39", "40", "41", "42", "43", "44", "45",
            "46", "47", "48", "49", "50", "51", "52", "53", "54",
            "55", "56", "57", "58", "59", "60", "61", "62", "63",
            "64", "65", "66", "67", "68", "69", "70", "71", "72",
            "73", "74", "75", "76", "77", "78", "79", "80", "81"]
        
        let Ertn2 =
        ["1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9",
            "19", "20", "21", "22", "23", "24", "25", "26", "27",
            "10", "11", "12", "13", "14", "15", "16", "17", "18",
            "28", "29", "30", "31", "32", "33", "34", "35", "36",
            "37", "38", "39", "40", "41", "42", "43", "44", "45",
            "46", "47", "48", "49", "50", "51", "52", "53", "54",
            "55", "56", "57", "58", "59", "60", "61", "62", "63",
            "64", "65", "66", "67", "68", "69", "70", "71", "72",
            "73", "74", "75", "76", "77", "78", "79", "80", "81"]
        
        let swappedPuzzle = pzl.swapRowsOfPuzzle(incomingPuzzle, incomingSolutionPuzzle: incomingPuzzle, swapValue: 0)
        //println("testSwapRowsOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapRowsOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle.0)
        
        ErtnBool = swappedPuzzle.0 == Ertn0 || swappedPuzzle.0 == Ertn1 || swappedPuzzle.0 == Ertn2
        XCTAssertTrue(ErtnBool, "testSwapRowsOfPuzzle: swapped as expected!")
        
    }
    
    func testSwapColsOfPuzzle() {
        var ErtnBool = false
        
        let incomingPuzzle =
        [ "1",  "2",  "3", "28", "29", "30", "55", "56", "57",
            "4",  "5",  "6", "31", "32", "33", "58", "59", "60",
            "7",  "8",  "9", "34", "35", "36", "61", "62", "63",
            "10", "11", "12", "37", "38", "39", "64", "65", "66",
            "13", "14", "15", "40", "41", "42", "67", "68", "69",
            "16", "17", "18", "43", "44", "45", "70", "71", "72",
            "19", "20", "21", "46", "47", "48", "73", "74", "75",
            "22", "23", "24", "49", "50", "51", "76", "77", "78",
            "25", "26", "27", "52", "53", "54", "79", "80", "81"]
        
        let Ertn0 =
        [ "2",  "1",  "3", "28", "29", "30", "55", "56", "57",
            "5",  "4",  "6", "31", "32", "33", "58", "59", "60",
            "8",  "7",  "9", "34", "35", "36", "61", "62", "63",
            "11", "10", "12", "37", "38", "39", "64", "65", "66",
            "14", "13", "15", "40", "41", "42", "67", "68", "69",
            "17", "16", "18", "43", "44", "45", "70", "71", "72",
            "20", "19", "21", "46", "47", "48", "73", "74", "75",
            "23", "22", "24", "49", "50", "51", "76", "77", "78",
            "26", "25", "27", "52", "53", "54", "79", "80", "81"]
        
        let Ertn1 =
        [ "3",  "2",  "1", "28", "29", "30", "55", "56", "57",
            "6",  "5",  "4", "31", "32", "33", "58", "59", "60",
            "9",  "8",  "7", "34", "35", "36", "61", "62", "63",
            "12", "11", "10", "37", "38", "39", "64", "65", "66",
            "15", "14", "13", "40", "41", "42", "67", "68", "69",
            "18", "17", "16", "43", "44", "45", "70", "71", "72",
            "21", "20", "19", "46", "47", "48", "73", "74", "75",
            "24", "23", "22", "49", "50", "51", "76", "77", "78",
            "27", "26", "25", "52", "53", "54", "79", "80", "81"]
        
        let Ertn2 =
        [ "1",  "3",  "2", "28", "29", "30", "55", "56", "57",
            "4",  "6",  "5", "31", "32", "33", "58", "59", "60",
            "7",  "9",  "8", "34", "35", "36", "61", "62", "63",
            "10", "12", "11", "37", "38", "39", "64", "65", "66",
            "13", "15", "14", "40", "41", "42", "67", "68", "69",
            "16", "18", "17", "43", "44", "45", "70", "71", "72",
            "19", "21", "20", "46", "47", "48", "73", "74", "75",
            "22", "24", "23", "49", "50", "51", "76", "77", "78",
            "25", "27", "26", "52", "53", "54", "79", "80", "81"]
        
        let swappedPuzzle = pzl.swapColsOfPuzzle(incomingPuzzle, incomingSolutionPuzzle: incomingPuzzle, swapValue: 0)
        //println("testSwapColsOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapColsOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle.0)
        
        ErtnBool = swappedPuzzle.0 == Ertn0 || swappedPuzzle.0 == Ertn1 || swappedPuzzle.0 == Ertn2
        XCTAssertTrue(ErtnBool, "testSwapColsOfPuzzle: swapped as expected!")
        
    }
    
    func testSwapStacksOfPuzzle() {
        
        let incomingPuzzle =
        [ "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        let Ertn0 =
        [ "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9",
            "4", "5", "6", "1", "2", "3", "7", "8", "9"]
        
        let Ertn1 =
        [ "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3",
            "7", "8", "9", "4", "5", "6", "1", "2", "3"]
        
        let Ertn2 =
        [ "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6",
            "1", "2", "3", "7", "8", "9", "4", "5", "6"]
        
        let Ertn3 =
        [ "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6",
            "7", "8", "9", "1", "2", "3", "4", "5", "6"]
        
        let Ertn4 =
        [ "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3",
            "4", "5", "6", "7", "8", "9", "1", "2", "3"]
        
        var swappedPuzzle = pzl.swapStacksOfPuzzle(incomingPuzzle, swapValue: 0)
        //println("testSwapStacksOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapStacksOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn0, swappedPuzzle, "testSwapStacksOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapStacksOfPuzzle(incomingPuzzle, swapValue: 1)
        //println("testSwapStacksOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapStacksOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn1, swappedPuzzle, "testSwapStacksOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapStacksOfPuzzle(incomingPuzzle, swapValue: 2)
        //println("testSwapStacksOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapStacksOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn2, swappedPuzzle, "testSwapStacksOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapStacksOfPuzzle(incomingPuzzle, swapValue: 3)
        //println("testSwapStacksOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapStacksOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn3, swappedPuzzle, "testSwapStacksOfPuzzle: swapped as expected!")
        
        swappedPuzzle = pzl.swapStacksOfPuzzle(incomingPuzzle, swapValue: 4)
        //println("testSwapStacksOfPuzzle: incoming puzzle:")
        //printPuzzle(incomingPuzzle)
        //println("testSwapStacksOfPuzzle: swapped puzzle:")
        //printPuzzle(swappedPuzzle)
        XCTAssertEqual(Ertn4, swappedPuzzle, "testSwapStacksOfPuzzle: swapped as expected!")
        
    }
    

}

