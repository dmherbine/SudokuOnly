//
//  HelpTests.swift
//  Sudoku
//
//  Created by dave herbine on 4/24/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import UIKit
import XCTest

class HelpTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetBadAnswers() {
        let sGame = Game(challenge: 4)
        let solutionPuzzle =
            ["8", "5", "9", "6", "1", "2", "4", "3", "7",
             "7", "2", "3", "8", "5", "4", "1", "6", "9",
             "1", "6", "4", "3", "7", "9", "5", "2", "8",
             "9", "8", "6", "1", "4", "7", "3", "5", "2",
             "3", "7", "5", "2", "6", "8", "9", "1", "4",
             "2", "4", "1", "5", "9", "3", "7", "8", "6",
             "4", "3", "2", "9", "8", "1", "6", "7", "5",
             "6", "1", "7", "4", "2", "5", "8", "9", "3",
             "5", "9", "8", "7", "3", "6", "2", "4", "1"]
        sGame.gamePuzzles.solution = solutionPuzzle
        sGame.gamePuzzles.playerAnswered = solutionPuzzle
        if let noBadAnswerActual = sGame.getBadAnswers() {
            // force a failed test (-1)
            XCTAssertEqual(-1, noBadAnswerActual.count, "testGetBadAnswers: Return count not as expected!")
        } else {
            print("testGetBadAnswers: Return nil as expected!")
        }
        
        let oneBadAnwerPuzzle =
            ["8", "5", "9", "6", "1", "2", "4", "3", "3",
             "7", "2", "3", "8", "5", "4", "1", "6", "9",
             "1", "6", "4", "3", "7", "9", "5", "2", "8",
             "9", "8", "6", "1", "4", "7", "3", "5", "2",
             "3", "7", "5", "2", "6", "8", "9", "1", "4",
             "2", "4", "1", "5", "9", "3", "7", "8", "6",
             "4", "3", "2", "9", "8", "1", "6", "7", "5",
             "6", "1", "7", "4", "2", "5", "8", "9", "3",
             "5", "9", "8", "7", "3", "6", "2", "4", "1"]
        let oneBadAnswerExpected = [Cell(i: 8, e: "3")]
        sGame.gamePuzzles.solution = solutionPuzzle
        sGame.gamePuzzles.playerAnswered = oneBadAnwerPuzzle
        if let oneBadAnswerActual = sGame.getBadAnswers() {
            XCTAssertEqual(oneBadAnswerExpected.count, oneBadAnswerActual.count, "testGetBadAnswers: Return count not as expected!")
            XCTAssertEqual(oneBadAnswerExpected.first?.value, oneBadAnswerActual.first?.value, "testGetBadAnswers: Return element not as expected!")
        } else {
            print("testGetBadAnswers: Unexpected return of nil instead of oneBadAnswer!")
        }
        
        let twoBadAnswerPuzzle =
            ["8", "5", "9", "6", "1", "2", "4", "3", "3",
             "7", "2", "3", "8", "5", "4", "1", "6", "9",
             "1", "6", "4", "3", "7", "9", "5", "2", "8",
             "9", "8", "6", "1", "4", "7", "3", "5", "2",
             "3", "7", "5", "2", "6", "8", "9", "1", "4",
             "2", "4", "1", "5", "9", "3", "7", "8", "6",
             "4", "3", "2", "9", "8", "1", "6", "7", "5",
             "6", "1", "7", "4", "2", "5", "8", "9", "3",
             "5", "9", "8", "7", "3", "6", "2", "4", "4"]
        let twoBadAnswerExpected = [Cell(i: 8, e: "3"),Cell(i: 80, e: "4")]
        
        sGame.gamePuzzles.solution = solutionPuzzle
        sGame.gamePuzzles.playerAnswered = twoBadAnswerPuzzle
        if let twoBadAnswerActual = sGame.getBadAnswers() {
            XCTAssertEqual(twoBadAnswerExpected.count, twoBadAnswerActual.count, "testGetBadAnswers: Return count not as expected!")
            XCTAssertEqual(twoBadAnswerExpected.first?.value, twoBadAnswerActual.first?.value, "testGetBadAnswers: Return element not as expected!")
        } else {
            print("testGetBadAnswers: Unexpected return of nil instead of twoBadAnswer!")
        }
    
    }

    func testGetBadPlayerCandidates() {
        let sGame = Game(challenge: 4)
        let playerCandidates =
            ["8", "5", "1369", "36", "1679", "2", "4", "136", "1367",
             "7", "2", "136", "34568", "156", "345", "13568", "13568", "9",
             "19", "369", "4", "3568", "15679", "359", "135678", "2", "135678",
             "29", "689", "2689", "1", "4", "7", "35", "35", "2",
             "3", "7", "5", "26", "26", "8", "9", "16", "4",
             "129", "4", "1269", "356", "3569", "359", "678", "68", "678",
             "245", "369", "2346", "9", "8", "1", "256", "7", "56",
             "6", "1", "7", "245", "25", "45", "38", "9", "38",
             "259", "89", "289", "7", "3", "6", "125", "4", "15"]
        sGame.gamePuzzles.allCandidates = playerCandidates
        sGame.gamePuzzles.playerCandidates = playerCandidates
        if let noBadPlayerCandidateActual = sGame.getBadPlayerCandidates() {
            // force a failed test (-1)
            XCTAssertEqual(-1, noBadPlayerCandidateActual.count, "testGetBadPlayerCandidates: Return not nil as expected!")
        } else {
            print("testGetBadPlayerCandidates: Return nil as expected!")
        }
        
         let oneBadPlayerCandidatePuzzle =
            ["", "", "1369", "36", "1679", "", "", "136", "1368",
             "", "", "136", "34568", "156", "345", "13568", "13568", "",
             "19", "369", "", "3568", "15679", "359", "135678", "", "135678",
             "29", "689", "2689", "", "", "", "35", "35", "",
             "3", "", "", "26", "26", "", "", "16", "",
             "129", "", "1269", "356", "35", "359", "678", "68", "678",
             "245", "369", "2346", "", "", "", "256", "", "56",
             "", "", "", "245", "25", "45", "38", "", "38",
             "259", "89", "289", "", "", "", "125", "", "15"]
        let oneBadPlayerCandidateExpected = [Cell(i: 8, e: "8")]
        sGame.gamePuzzles.allCandidates = playerCandidates
        sGame.gamePuzzles.playerCandidates = oneBadPlayerCandidatePuzzle
        if let oneBadPlayerCandidateActual = sGame.getBadPlayerCandidates() {
            XCTAssertEqual(oneBadPlayerCandidateExpected.count, oneBadPlayerCandidateActual.count, "testGetBadPlayerCandidates: Return count not as expected!")
            XCTAssertEqual(oneBadPlayerCandidateExpected.first?.value, oneBadPlayerCandidateActual.first?.value, "testGetBadPlayerCandidates: Return element not as expected!")
        } else {
            print("testGetBadPlayerCandidates: Unexpected return of nil instead of oneBadPlayerCandidate!")
        }
        
        let twoBadPlayerCandidatesPuzzle =
            ["", "", "1369", "36", "1679", "", "", "136", "13689",
             "", "", "136", "34568", "156", "345", "13568", "13568", "",
             "19", "369", "", "3568", "15679", "359", "135678", "", "135678",
             "29", "689", "2689", "", "", "", "35", "35", "",
             "3", "", "", "26", "26", "", "", "16", "",
             "129", "", "1269", "356", "3569", "359", "678", "68", "678",
             "245", "369", "2346", "", "", "", "256", "", "56",
             "", "", "", "245", "25", "45", "38", "", "38",
             "259", "89", "289", "", "", "", "125", "", "26"]
        let twoBadPlayerCandidatesExpected = [Cell(i: 8, e: "89"),Cell(i: 80, e: "26")]
        
        sGame.gamePuzzles.allCandidates = playerCandidates
        sGame.gamePuzzles.playerCandidates = twoBadPlayerCandidatesPuzzle
        if let twoBadPlayerCandidatesctual = sGame.getBadPlayerCandidates() {
            XCTAssertEqual(twoBadPlayerCandidatesExpected.count, twoBadPlayerCandidatesctual.count, "testGetBadPlayerCandidates: Return count not as expected!")
            XCTAssertEqual(twoBadPlayerCandidatesExpected.first?.value, twoBadPlayerCandidatesctual.first?.value, "testGetBadPlayerCandidates: Return element not as expected!")
        } else {
            print("testGetBadPlayerCandidates: Unexpected return of nil insted of twoBadPlayerCandidates!")
        }

    }
    
    func testGetSingularAllCandidates() {
        let sGame = Game(challenge: 4)
        let ArtoNoSingularCandiates =
            ["", "", "1369", "36", "1679", "", "", "36", "1367",
             "", "", "136", "34568", "156", "345", "13568", "3568", "",
             "169", "369", "", "3568", "15679", "359", "135678", "", "135678",
             "69", "689", "689", "", "", "", "3568", "3568", "",
             "", "", "", "26", "26", "", "", "", "",
             "1269", "", "12689", "2356", "2569", "359", "35678", "3568", "35678",
             "", "36", "236", "", "", "", "2356", "", "356",
             "256", "", "", "245", "25", "45", "23568", "", "3568",
             "259", "89", "289", "", "", "", "1258", "", "158"]
        let ArtoCandidatesPostCP =
            ["", "", "1369", "36", "1679", "", "", "36", "1367",
             "", "", "136", "34568", "156", "345", "13568", "3568", "",
             "169", "369", "", "3568", "15679", "359", "135678", "2", "135678",
             "69", "689", "689", "", "4", "", "3568", "3568", "",
             "", "7", "", "26", "26", "8", "", "1", "4",
             "1269", "", "12689", "2356", "2569", "359", "35678", "3568", "35678",
             "4", "36", "236", "9", "", "1", "2356", "", "356",
             "256", "", "", "245", "25", "45", "23568", "9", "3568",
             "259", "89", "289", "7", "", "", "1258", "", "158"]

        sGame.gamePuzzles.allCandidates = ArtoNoSingularCandiates
        if let noSingularsActuals = sGame.getSingularAllCandidates() {
            // force a failed test (-1)
            XCTAssertEqual(-1, noSingularsActuals.count, "testGetSingularAllCandidates: Return not nil as expected!")
        } else {
            print("testGetSingularAllCandidates: Return nil as expected!")
        }

        let manySingularsExpected = [Cell(i: 25, e: "2"), Cell(i: 31, e: "4"), Cell(i: 37, e: "7"), Cell(i: 41, e: "8"),
                                     Cell(i: 43, e: "1"), Cell(i: 44, e: "4"), Cell(i: 54, e: "4"), Cell(i: 57, e: "9"),
                                     Cell(i: 59, e: "1"), Cell(i: 70, e: "9"), Cell(i: 75, e: "7")]
        sGame.gamePuzzles.allCandidates = ArtoCandidatesPostCP
        if let manySingularsActual = sGame.getSingularAllCandidates() {
            XCTAssertEqual(manySingularsExpected.count, manySingularsActual.count, "testGetSingularAllCandidates: Return count not as expected!")
            XCTAssertEqual(manySingularsExpected.first?.value, manySingularsActual.first?.value, "testGetSingularAllCandidates: Return element not as expected!")
        } else {
            print("testGetSingularAllCandidates: Unexpected return of nil instead of manySingularsmany!")
        }
        
    }
    
    func testGetSingularPlayerCandidates() {
        let sGame = Game(challenge: 4)
        let playerCandidates =
            ["8", "5", "1369", "36", "1679", "2", "4", "136", "1367",
             "7", "2", "136", "34568", "156", "345", "13568", "13568", "9",
             "19", "369", "4", "3568", "15679", "359", "135678", "2", "135678",
             "29", "689", "2689", "1", "4", "7", "35", "35", "2",
             "3", "7", "5", "26", "26", "8", "9", "16", "4",
             "129", "4", "1269", "356", "3569", "359", "678", "68", "678",
             "245", "369", "2346", "9", "8", "1", "256", "7", "56",
             "6", "1", "7", "245", "25", "45", "38", "9", "38",
             "259", "89", "289", "7", "3", "6", "125", "4", "15"]
        let noSingularPlayerCandidates =
            ["1", "", "1369", "3", "1679", "", "", "136", "1367",
             "", "", "136", "34568", "156", "345", "13568", "13568", "",
             "19", "369", "", "3568", "15679", "359", "135678", "", "135678",
             "29", "689", "2689", "", "", "", "35", "35", "",
             "", "", "", "26", "26", "", "", "16", "",
             "129", "", "1269", "356", "3569", "359", "678", "68", "678",
             "245", "369", "2346", "", "", "", "256", "", "56",
             "", "", "", "245", "25", "45", "38", "", "38",
             "259", "89", "289", "", "", "", "125", "", "15"]
        sGame.gamePuzzles.allCandidates = playerCandidates
        sGame.gamePuzzles.playerCandidates = noSingularPlayerCandidates
        if let noSingularPlayerCandidateActual = sGame.getSingularPlayerCandidates() {
            // force a failed test (-1)
            XCTAssertEqual(-1, noSingularPlayerCandidateActual.count, "testGetSingularPlayerCandidates: Return not nil as expected!")
            print("testGetSingularPlayerCandidates: unexpected singular playerCandidates = \(noSingularPlayerCandidateActual)")
        } else {
            print("testGetSingularPlayerCandidates: Return nil as expected!")
        }

        let twoSingularPlayerCandidates =
            ["8", "", "1369", "36", "1679", "", "", "136", "1367",
             "", "", "136", "34568", "156", "345", "13568", "13568", "",
             "19", "369", "", "3568", "15679", "359", "135678", "", "135678",
             "29", "689", "2689", "", "", "", "35", "35", "",
             "", "", "", "26", "26", "", "", "16", "",
             "129", "", "1269", "356", "3569", "359", "678", "68", "678",
             "245", "369", "2346", "", "", "", "256", "", "56",
             "", "", "", "245", "25", "45", "38", "", "38",
             "259", "89", "289", "7", "", "", "125", "", "15"]
        let twoSingularPlayerCandidatesExpected = [Cell(i: 0, e: "8"), Cell(i: 75, e: "7")]
        sGame.gamePuzzles.allCandidates = playerCandidates
        sGame.gamePuzzles.playerCandidates = twoSingularPlayerCandidates
        if let twoSingularPlayerCandidatesActual = sGame.getSingularPlayerCandidates() {
            XCTAssertEqual(twoSingularPlayerCandidatesExpected.count, twoSingularPlayerCandidatesActual.count, "testGetSingularPlayerCandidates: Return count not as expected!")
            XCTAssertEqual(twoSingularPlayerCandidatesExpected.first?.value, twoSingularPlayerCandidatesActual.first?.value, "testGetSingularPlayerCandidates: Return element not as expected!")
        } else {
            print("testGetSingularPlayerCandidates: Unexpected return of nil instead of twoSingularPlayerCandidates!")
        }
        
    }
    
    func testType1UniqueRectangel() {
        // Holding place for randomly generated puzzles that would make good seeded puzzles
        let goodCPSeedPuzzle =
            ["", "", "", "", "", "", "", "", "2",
             "2", "7", "", "", "", "", "1", "3", "",
             "", "", "", "", "4", "8", "5", "", "7",
             "", "", "", "", "", "2", "4", "", "5",
             "", "", "5", "", "", "", "", "1", "",
             "9", "", "8", "", "", "7", "3", "2", "6",
             "5", "", "", "", "", "4", "", "", "",
             "", "6", "7", "", "", "", "2", "", "4",
             "", "9", "2", "", "7", "6", "", "5", ""]
        
    }
    
    func testPlayerHelp() {
        let diagTuples = [Cell(i: 0, e: "1"), Cell(i: 10, e: "2"), Cell(i: 20, e: "3"), Cell(i: 30, e: "4"),
                             Cell(i: 40, e: "5"), Cell(i: 50, e: "6"), Cell(i: 60, e: "7"), Cell(i: 70, e: "8"),
                             Cell(i: 80, e: "9")]
        let midTuples = [Cell(i: 10, e: "1"), Cell(i: 13, e: "2"), Cell(i: 16, e: "3"), Cell(i: 37, e: "4"),
                         Cell(i: 40, e: "5"), Cell(i: 43, e: "6"), Cell(i: 64, e: "7"), Cell(i: 67, e: "8"),
                         Cell(i: 70, e: "9")]
        let diagRowSquare = [(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9)]
        let midRowSquare = [(2,2),(2,5),(2,8),(5,2),(5,5),(5,8),(8,2),(8,5),(8,8)]
        
        for (indx, dTuple) in diagTuples.enumerated() {
            let dph = PlayerHelp(fromTuple: dTuple)
            XCTAssertEqual(diagRowSquare[indx].0, dph.row, "testPlayerHelp: dph.row not as expected!")
            XCTAssertEqual(diagRowSquare[indx].1, dph.square, "testPlayerHelp: dph.sq not as expected!")
            if dph.row != diagRowSquare[indx].0 || dph.square != diagRowSquare[indx].1 {
                print("testPlayerHelp: dph.row(\(dph.row)) != (\(diagRowSquare[indx].0)) ... and/or dph.sq(\(dph.square)) != (\(diagRowSquare[indx].1))")
            }
        }
        for (indx, mTuple) in midTuples.enumerated() {
            let mph = PlayerHelp(fromTuple: mTuple)
            XCTAssertEqual(midRowSquare[indx].0, mph.row, "testPlayerHelp: mph.row not as expected!")
            XCTAssertEqual(midRowSquare[indx].1, mph.square, "testPlayerHelp: mph.sq not as expected!")
            if mph.row != midRowSquare[indx].0 || mph.square != midRowSquare[indx].1 {
                print("testPlayerHelp: mph.row(\(mph.row)) != (\(midRowSquare[indx].0)) ... and/or mph.sq(\(mph.square)) != (\(midRowSquare[indx].1))")
            }
        }

    }

    func testFindUnitTuplesAlgoEliminates() {        
        let tuple = Tuples()

        let hidden46hidden12 = ["34567", "789", "1238", "578", "589", "379", "58", "1258", "469"]
        var allTuples = ["46", "", "12", "", "", "", "", "12", "46"]
        var netEliminates = ["357", "", "38", "", "", "", "", "58", "9"]
        var algoEliminates = [AlgoEliminates]()
        let units = [0,1,2,3,4,5,6,7,8]
        var highlightCells = [Cell]()
        for unit in units { highlightCells.append(Cell(i: unit, e: "46")) }
        let algoHeliminate0_357 = AlgoEliminates(eCell: Cell(i: 0, e: "357"), hCells: highlightCells, eAlgo: "Hidden Pair")
        algoEliminates.append(algoHeliminate0_357)
        
        highlightCells = [Cell]()
        for unit in units { highlightCells.append(Cell(i: unit, e: "46")) }
        let algoHeliminate8_9 = AlgoEliminates(eCell: Cell(i: 8, e: "9"), hCells: highlightCells, eAlgo: "Hidden Pair")
        algoEliminates.append(algoHeliminate8_9)
        
        highlightCells = [Cell]()
        for unit in units { highlightCells.append(Cell(i: unit, e: "12")) }
        let algoHeliminate2_38 = AlgoEliminates(eCell: Cell(i: 2, e: "38"), hCells: highlightCells, eAlgo: "Hidden Pair")
        algoEliminates.append(algoHeliminate2_38)
        
        highlightCells = [Cell]()
        for unit in units { highlightCells.append(Cell(i: unit, e: "12")) }
        let algoHeliminate7_58 = AlgoEliminates(eCell: Cell(i: 7, e: "58"), hCells: highlightCells, eAlgo: "Hidden Pair")
        algoEliminates.append(algoHeliminate7_58)
        
        var Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], hidden46hidden12, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuplesAlgoEliminates: eliminate array is as expected!")
        //print("testFindUnitTuplesAlgoEliminates: algoEliminates of hidden46hidden12 =")
        //for algoElim in Artn.algoEliminates { algoElim.printIt() }
        XCTAssertEqual(algoEliminates, Artn.algoEliminates, "testFindUnitTuplesAlgoEliminates: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuplesAlgoEliminates: eliminate array is as expected!")
        
        let naked24naked69 = ["24", "24", "1238", "4568", "1589", "69", "258", "12458", "69"]
        allTuples = ["24", "24", "", "", "", "69", "", "", "69"]
        netEliminates = ["", "", "2", "46", "9", "", "2", "24", ""]
        algoEliminates = [AlgoEliminates]()
        highlightCells = [Cell]()
        for unit in units { highlightCells.append(Cell(i: unit, e: "24")) }
        let algoEliminate2_2 = AlgoEliminates(eCell: Cell(i: 2, e: "2"), hCells: highlightCells, eAlgo: "Naked Pair")
        algoEliminates.append(algoEliminate2_2)
        let algoEliminate3_4 = AlgoEliminates(eCell: Cell(i: 3, e: "4"), hCells: highlightCells, eAlgo: "Naked Pair")
        algoEliminates.append(algoEliminate3_4)
        let algoEliminate6_2 = AlgoEliminates(eCell: Cell(i: 6, e: "2"), hCells: highlightCells, eAlgo: "Naked Pair")
        algoEliminates.append(algoEliminate6_2)
        let algoEliminate7_24 = AlgoEliminates(eCell: Cell(i: 7, e: "24"), hCells: highlightCells, eAlgo: "Naked Pair")
        algoEliminates.append(algoEliminate7_24)

        highlightCells = [Cell]()
        for unit in units { highlightCells.append(Cell(i: unit, e: "69")) }
        let algoEliminate3_6 = AlgoEliminates(eCell: Cell(i: 3, e: "6"), hCells: highlightCells, eAlgo: "Naked Pair")
        algoEliminates.append(algoEliminate3_6)
        let algoEliminate4_9 = AlgoEliminates(eCell: Cell(i: 4, e: "9"), hCells: highlightCells, eAlgo: "Naked Pair")
        algoEliminates.append(algoEliminate4_9)
        
        Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], naked24naked69, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuplesAlgoEliminates: eliminate array is as expected!")
        //print("testFindUnitTuplesAlgoEliminates: algoEliminates of naked24naked69 =")
        //for algoElim in Artn.algoEliminates { algoElim.printIt() }
        XCTAssertEqual(algoEliminates, Artn.algoEliminates, "testFindUnitTuplesAlgoEliminates: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuplesAlgoEliminates: eliminate array is as expected!")
        
    }
    
    func testFind8Not9() {
        // Following puzzle would return the first item of cpAssignAlgo (which has an assign digit of "9", even though keypadDigit was "8").  That's the expected result from the CP algorithm.  I modified the getAlgoAssigns() to try and find an item in the CP algorithm results where the assign digit equals keypadDigit.
       let find8not9puzzle =
            ["5","9","4","1","8","7","2","3","6",
             "6","3","7","5","2","9","1","8","4",
             "2","8","1","6","3","4","9","7","5",
             "","1","2","8","4","5","3","6","7",
             "3","4","5","9","7","6","","1","2",
             "","7","6","3","1","2","5","4","9",
             "4","2","","7","5","3","6","9","1",
             "1","5","","4","6","8","7","2","3",
             "7","6","3","2","","1","4","5","8"]
        let find8not9puzzleSolution =
            ["5","9","4","1","8","7","2","3","6",
             "6","3","7","5","2","9","1","8","4",
             "2","8","1","6","3","4","9","7","5",
             "9","1","2","8","4","5","3","6","7",
             "3","4","5","9","7","6","8","1","2",
             "8","7","6","3","1","2","5","4","9",
             "4","2","8","7","5","3","6","9","1",
             "1","5","9","4","6","8","7","2","3",
             "7","6","3","2","9","1","4","5","8"]
        
        let cpAssignAlgo = [AlgoAssigns(aCell: Cell(i: 27, e: "9"), hhCells: [HelpCell(sq: 27, ans: "9", del: "", alg: ""), HelpCell(sq: 28, ans: "", del: "9", alg: ""), HelpCell(sq: 29, ans: "", del: "9", alg: ""), HelpCell(sq: 36, ans: "", del: "9", alg: ""), HelpCell(sq: 37, ans: "", del: "9", alg: ""), HelpCell(sq: 38, ans: "", del: "9", alg: ""), HelpCell(sq: 45, ans: "", del: "9", alg: ""), HelpCell(sq: 46, ans: "", del: "9", alg: ""), HelpCell(sq: 47, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 42, e: "8"), hhCells: [HelpCell(sq: 33, ans: "", del: "8", alg: ""), HelpCell(sq: 34, ans: "", del: "8", alg: ""), HelpCell(sq: 35, ans: "", del: "8", alg: ""), HelpCell(sq: 42, ans: "8", del: "", alg: ""), HelpCell(sq: 43, ans: "", del: "8", alg: ""), HelpCell(sq: 44, ans: "", del: "8", alg: ""), HelpCell(sq: 51, ans: "", del: "8", alg: ""), HelpCell(sq: 52, ans: "", del: "8", alg: ""), HelpCell(sq: 53, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 45, e: "8"), hhCells: [HelpCell(sq: 27, ans: "", del: "8", alg: ""), HelpCell(sq: 28, ans: "", del: "8", alg: ""), HelpCell(sq: 29, ans: "", del: "8", alg: ""), HelpCell(sq: 36, ans: "", del: "8", alg: ""), HelpCell(sq: 37, ans: "", del: "8", alg: ""), HelpCell(sq: 38, ans: "", del: "8", alg: ""), HelpCell(sq: 45, ans: "8", del: "", alg: ""), HelpCell(sq: 46, ans: "", del: "8", alg: ""), HelpCell(sq: 47, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 56, e: "8"), hhCells: [HelpCell(sq: 54, ans: "", del: "8", alg: ""), HelpCell(sq: 55, ans: "", del: "8", alg: ""), HelpCell(sq: 56, ans: "8", del: "", alg: ""), HelpCell(sq: 63, ans: "", del: "8", alg: ""), HelpCell(sq: 64, ans: "", del: "8", alg: ""), HelpCell(sq: 65, ans: "", del: "8", alg: ""), HelpCell(sq: 72, ans: "", del: "8", alg: ""), HelpCell(sq: 73, ans: "", del: "8", alg: ""), HelpCell(sq: 74, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 65, e: "9"), hhCells: [HelpCell(sq: 54, ans: "", del: "9", alg: ""), HelpCell(sq: 55, ans: "", del: "9", alg: ""), HelpCell(sq: 56, ans: "", del: "9", alg: ""), HelpCell(sq: 63, ans: "", del: "9", alg: ""), HelpCell(sq: 64, ans: "", del: "9", alg: ""), HelpCell(sq: 65, ans: "9", del: "", alg: ""), HelpCell(sq: 72, ans: "", del: "9", alg: ""), HelpCell(sq: 73, ans: "", del: "9", alg: ""), HelpCell(sq: 74, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 76, e: "9"), hhCells: [HelpCell(sq: 57, ans: "", del: "9", alg: ""), HelpCell(sq: 58, ans: "", del: "9", alg: ""), HelpCell(sq: 59, ans: "", del: "9", alg: ""), HelpCell(sq: 66, ans: "", del: "9", alg: ""), HelpCell(sq: 67, ans: "", del: "9", alg: ""), HelpCell(sq: 68, ans: "", del: "9", alg: ""), HelpCell(sq: 75, ans: "", del: "9", alg: ""), HelpCell(sq: 76, ans: "9", del: "", alg: ""), HelpCell(sq: 77, ans: "", del: "9", alg: "")], aAlgo: "One Rule")]
        let cpAssignAlgoFirst = cpAssignAlgo.first
        
        let pzl = Puzzle()
        var Ertn = PzlSet()
        globalKPD = "8"
        Ertn.given = find8not9puzzle
        Ertn.playerAnswered = find8not9puzzle
        Ertn.solution = find8not9puzzleSolution
        Ertn.allCandidates = pzl.generateAllCandidatesFromAnswered(Ertn)
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, nil, nil)
        
        //        print("testFind8Not9: easy puzzle = ")
        //        printPuzzle(algoResults.playerAnswered)
        
        print("testFind8Not9: solved units count = \(algoResults.solvedUnits.count)")
        print("testFind8Not9: solved units = \(algoResults.solvedUnits)")
        
        XCTAssertEqual(find8not9puzzleSolution, Artn.strategy.pzzlSet.playerAnswered, "testFind8Not9: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testFind8Not9: Solved puzzle state is solved!")
        
        if Artn.strategy.algoAssigns != nil {
//            print("\n\n Artn.strategy.algoAssigns with count of \(Artn.strategy.algoAssigns?.count) =")
//            print(Artn.strategy.algoAssigns!)
//            print("\n\n")
            XCTAssertEqual(cpAssignAlgo, Artn.strategy.algoAssigns!, "testFind8Not9: puzzle CP cpAssigns as expected!")
            XCTAssertEqual(cpAssignAlgoFirst, Artn.strategy.algoAssigns?.first!, "testFind8Not9: CP algoAssigns.first not as expected!")
            print("testFind8Not9: cpAssignAlgo.count = \(cpAssignAlgo.count), Artn.strategy.algoAssigns!.count = \(Artn.strategy.algoAssigns!.count)\n\n")
            print("Artn.strategy.algoAssigns.first = ")
            Artn.strategy.algoAssigns!.first?.printIt()
            //            for anAssign in Artn.strategy.algoAssigns! {
            //                anAssign.printIt()
            //            }
            //            print(Artn.strategy.algoAssigns!)
        } else {
            XCTAssertEqual(0, 1, "testFind8Not9: puzzle Tuples algoAssigns is nil!")
        }
        
        Ertn.given = find8not9puzzle
        Ertn.playerAnswered = find8not9puzzle
        Ertn.solution = find8not9puzzleSolution
        Ertn.state = states.valid
        let getAlgoAssignsGivenKPD = AlgoAssigns(aCell: Cell(i: 42, e: "8"), hhCells: [HelpCell(sq: 33, ans: "", del: "8", alg: ""), HelpCell(sq: 34, ans: "", del: "8", alg: ""), HelpCell(sq: 35, ans: "", del: "8", alg: ""), HelpCell(sq: 42, ans: "8", del: "", alg: ""), HelpCell(sq: 43, ans: "", del: "8", alg: ""), HelpCell(sq: 44, ans: "", del: "8", alg: ""), HelpCell(sq: 51, ans: "", del: "8", alg: ""), HelpCell(sq: 52, ans: "", del: "8", alg: ""), HelpCell(sq: 53, ans: "", del: "8", alg: "")], aAlgo: "One Rule")
        let sGame = Game(GivenGame: Ertn)
        
        if let sGameAssigns = sGame.getAlgoAssigns() {
            print("testFind8Not9: sGameAssigns = ")
            print(sGameAssigns)
            //sGameAssigns.printIt()
            XCTAssertEqual(getAlgoAssignsGivenKPD, sGameAssigns, "testFind8Not9: getAlgoAssigns() return is not equal as expected!")
            print("testFind8Not9: Ertn.solvingAlgorithm = \(String(describing: Ertn.solvingAlgorithm))")
        } else {
            XCTAssertEqual(0, 1, "testFind8Not9: getAlgoAssigns() is nil!")
        }
        globalKPD = nil

    }
    
    func testWhoa() {
        // Following Easy puzzle can be solved with constraint propagation (50 givens, 9 values)
        let whoaPuzzle =
            ["3","","4","7","8","","6","9","",
             "8","2","6","1","9","4","3","7","5",
             "9","7","1","3","6","5","4","8","2",
             "7","4","9","2","3","1","8","","6",
             "","1","3","6","7","8","9","2","4",
             "","6","8","4","5","9","","3","7",
             "1","3","7","8","","6","5","4","9",
             "4","8","","","","7","2","6","3",
             "6","9","","5","4","3","7","1","8"]
        let whoaPuzzleSolution =
            ["3","5","4","7","8","2","6","9","1",
             "8","2","6","1","9","4","3","7","5",
             "9","7","1","3","6","5","4","8","2",
             "7","4","9","2","3","1","8","5","6",
             "5","1","3","6","7","8","9","2","4",
             "2","6","8","4","5","9","1","3","7",
             "1","3","7","8","2","6","5","4","9",
             "4","8","5","9","1","7","2","6","3",
             "6","9","2","5","4","3","7","1","8"]
        
        let cpAssigns = [Cell(i: 51, e: "1"), Cell(i: 45, e: "2"), Cell(i: 36, e: "5"), Cell(i: 66, e: "9"), Cell(i: 8, e: "1"), Cell(i: 34, e: "5"), Cell(i: 65, e: "5"), Cell(i: 67, e: "1"), Cell(i: 58, e: "2"), Cell(i: 74, e: "2"), Cell(i: 1, e: "5"), Cell(i: 5, e: "2")]
        
        let cpAssignAlgo = [AlgoAssigns(aCell: Cell(i: 51, e: "1"), hhCells: [HelpCell(sq: 45, ans: "", del: "1", alg: ""), HelpCell(sq: 46, ans: "", del: "1", alg: ""), HelpCell(sq: 47, ans: "", del: "1", alg: ""), HelpCell(sq: 48, ans: "", del: "1", alg: ""), HelpCell(sq: 49, ans: "", del: "1", alg: ""), HelpCell(sq: 50, ans: "", del: "1", alg: ""), HelpCell(sq: 51, ans: "1", del: "", alg: ""), HelpCell(sq: 52, ans: "", del: "1", alg: ""), HelpCell(sq: 53, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 45, e: "2"), hhCells: [HelpCell(sq: 45, ans: "2", del: "", alg: ""), HelpCell(sq: 46, ans: "", del: "2", alg: ""), HelpCell(sq: 47, ans: "", del: "2", alg: ""), HelpCell(sq: 48, ans: "", del: "2", alg: ""), HelpCell(sq: 49, ans: "", del: "2", alg: ""), HelpCell(sq: 50, ans: "", del: "2", alg: ""), HelpCell(sq: 51, ans: "", del: "2", alg: ""), HelpCell(sq: 52, ans: "", del: "2", alg: ""), HelpCell(sq: 53, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 36, e: "5"), hhCells: [HelpCell(sq: 0, ans: "", del: "5", alg: ""), HelpCell(sq: 9, ans: "", del: "5", alg: ""), HelpCell(sq: 18, ans: "", del: "5", alg: ""), HelpCell(sq: 27, ans: "", del: "5", alg: ""), HelpCell(sq: 36, ans: "5", del: "", alg: ""), HelpCell(sq: 45, ans: "", del: "5", alg: ""), HelpCell(sq: 54, ans: "", del: "5", alg: ""), HelpCell(sq: 63, ans: "", del: "5", alg: ""), HelpCell(sq: 72, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 66, e: "9"), hhCells: [HelpCell(sq: 63, ans: "", del: "9", alg: ""), HelpCell(sq: 64, ans: "", del: "9", alg: ""), HelpCell(sq: 65, ans: "", del: "9", alg: ""), HelpCell(sq: 66, ans: "9", del: "", alg: ""), HelpCell(sq: 67, ans: "", del: "9", alg: ""), HelpCell(sq: 68, ans: "", del: "9", alg: ""), HelpCell(sq: 69, ans: "", del: "9", alg: ""), HelpCell(sq: 70, ans: "", del: "9", alg: ""), HelpCell(sq: 71, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 8, e: "1"), hhCells: [HelpCell(sq: 0, ans: "", del: "1", alg: ""), HelpCell(sq: 1, ans: "", del: "1", alg: ""), HelpCell(sq: 2, ans: "", del: "1", alg: ""), HelpCell(sq: 3, ans: "", del: "1", alg: ""), HelpCell(sq: 4, ans: "", del: "1", alg: ""), HelpCell(sq: 5, ans: "", del: "1", alg: ""), HelpCell(sq: 6, ans: "", del: "1", alg: ""), HelpCell(sq: 7, ans: "", del: "1", alg: ""), HelpCell(sq: 8, ans: "1", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 34, e: "5"), hhCells: [HelpCell(sq: 27, ans: "", del: "5", alg: ""), HelpCell(sq: 28, ans: "", del: "5", alg: ""), HelpCell(sq: 29, ans: "", del: "5", alg: ""), HelpCell(sq: 30, ans: "", del: "5", alg: ""), HelpCell(sq: 31, ans: "", del: "5", alg: ""), HelpCell(sq: 32, ans: "", del: "5", alg: ""), HelpCell(sq: 33, ans: "", del: "5", alg: ""), HelpCell(sq: 34, ans: "5", del: "", alg: ""), HelpCell(sq: 35, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 65, e: "5"), hhCells: [HelpCell(sq: 63, ans: "", del: "5", alg: ""), HelpCell(sq: 64, ans: "", del: "5", alg: ""), HelpCell(sq: 65, ans: "5", del: "", alg: ""), HelpCell(sq: 66, ans: "", del: "5", alg: ""), HelpCell(sq: 67, ans: "", del: "5", alg: ""), HelpCell(sq: 68, ans: "", del: "5", alg: ""), HelpCell(sq: 69, ans: "", del: "5", alg: ""), HelpCell(sq: 70, ans: "", del: "5", alg: ""), HelpCell(sq: 71, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 67, e: "1"), hhCells: [HelpCell(sq: 63, ans: "", del: "1", alg: ""), HelpCell(sq: 64, ans: "", del: "1", alg: ""), HelpCell(sq: 65, ans: "", del: "1", alg: ""), HelpCell(sq: 66, ans: "", del: "1", alg: ""), HelpCell(sq: 67, ans: "1", del: "", alg: ""), HelpCell(sq: 68, ans: "", del: "1", alg: ""), HelpCell(sq: 69, ans: "", del: "1", alg: ""), HelpCell(sq: 70, ans: "", del: "1", alg: ""), HelpCell(sq: 71, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 58, e: "2"), hhCells: [HelpCell(sq: 54, ans: "", del: "2", alg: ""), HelpCell(sq: 55, ans: "", del: "2", alg: ""), HelpCell(sq: 56, ans: "", del: "2", alg: ""), HelpCell(sq: 57, ans: "", del: "2", alg: ""), HelpCell(sq: 58, ans: "2", del: "", alg: ""), HelpCell(sq: 59, ans: "", del: "2", alg: ""), HelpCell(sq: 60, ans: "", del: "2", alg: ""), HelpCell(sq: 61, ans: "", del: "2", alg: ""), HelpCell(sq: 62, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 74, e: "2"), hhCells: [HelpCell(sq: 72, ans: "", del: "2", alg: ""), HelpCell(sq: 73, ans: "", del: "2", alg: ""), HelpCell(sq: 74, ans: "2", del: "", alg: ""), HelpCell(sq: 75, ans: "", del: "2", alg: ""), HelpCell(sq: 76, ans: "", del: "2", alg: ""), HelpCell(sq: 77, ans: "", del: "2", alg: ""), HelpCell(sq: 78, ans: "", del: "2", alg: ""), HelpCell(sq: 79, ans: "", del: "2", alg: ""), HelpCell(sq: 80, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 1, e: "5"), hhCells: [HelpCell(sq: 1, ans: "5", del: "", alg: ""), HelpCell(sq: 10, ans: "", del: "5", alg: ""), HelpCell(sq: 19, ans: "", del: "5", alg: ""), HelpCell(sq: 28, ans: "", del: "5", alg: ""), HelpCell(sq: 37, ans: "", del: "5", alg: ""), HelpCell(sq: 46, ans: "", del: "5", alg: ""), HelpCell(sq: 55, ans: "", del: "5", alg: ""), HelpCell(sq: 64, ans: "", del: "5", alg: ""), HelpCell(sq: 73, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 5, e: "2"), hhCells: [HelpCell(sq: 0, ans: "", del: "2", alg: ""), HelpCell(sq: 1, ans: "", del: "2", alg: ""), HelpCell(sq: 2, ans: "", del: "2", alg: ""), HelpCell(sq: 3, ans: "", del: "2", alg: ""), HelpCell(sq: 4, ans: "", del: "2", alg: ""), HelpCell(sq: 5, ans: "2", del: "", alg: ""), HelpCell(sq: 6, ans: "", del: "2", alg: ""), HelpCell(sq: 7, ans: "", del: "2", alg: ""), HelpCell(sq: 8, ans: "", del: "2", alg: "")], aAlgo: "One Rule")]
        let cpAssignAlgoFirst = cpAssignAlgo.first
        let getAlgo = AlgoAssigns(aCell: Cell(i: 1, e: "5"), hhCells: [HelpCell(sq: 0, ans: "", del: "5", alg: ""), HelpCell(sq: 1, ans: "5", del: "", alg: ""), HelpCell(sq: 2, ans: "", del: "5", alg: ""), HelpCell(sq: 9, ans: "", del: "5", alg: ""), HelpCell(sq: 10, ans: "", del: "5", alg: ""), HelpCell(sq: 11, ans: "", del: "5", alg: ""), HelpCell(sq: 18, ans: "", del: "5", alg: ""), HelpCell(sq: 19, ans: "", del: "5", alg: ""), HelpCell(sq: 20, ans: "", del: "5", alg: "")], aAlgo: "One Rule")
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = whoaPuzzle
        Ertn.solution = whoaPuzzleSolution
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, nil, nil)
        
        //        print("testAlgoAssignsByCP: easy puzzle = ")
        //        printPuzzle(algoResults.playerAnswered)
        
        print("testWhoa: solved units count = \(algoResults.solvedUnits.count)")
        print("testWhoa: solved units = \(algoResults.solvedUnits)")
        
        XCTAssertEqual(whoaPuzzleSolution, Artn.strategy.pzzlSet.playerAnswered, "testWhoa: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testWhoa: Solved puzzle state is solved!")
        
        //        print("\n\ntestWhoa: Artn.strategy.cpAssigns!.count = \(Artn.strategy.cpAssigns.count), cpAssigns.count = \(cpAssigns.count)")
        //        print(Artn.strategy.cpAssigns)
        //        print("\n\n")
        XCTAssertEqual(cpAssigns, Artn.strategy.cpAssigns, "testWhoa: puzzle CP cpAssigns as expected!")
        
        if Artn.strategy.algoAssigns != nil {
//                        print("\n\n Artn.strategy.algoAssigns with count of \(Artn.strategy.algoAssigns?.count) =")
//                        print(Artn.strategy.algoAssigns!)
//                        print("\n\n")
            XCTAssertEqual(cpAssignAlgo, Artn.strategy.algoAssigns!, "testWhoa: puzzle CP cpAssigns as expected!")
            XCTAssertEqual(cpAssignAlgoFirst, Artn.strategy.algoAssigns?.first!, "testWhoa: CP algoAssigns.first not as expected!")
            print("testWhoa: cpAssignAlgo.count = \(cpAssignAlgo.count), Artn.strategy.algoAssigns!.count = \(Artn.strategy.algoAssigns!.count)\n\n")
            print("Artn.strategy.algoAssigns.first = ")
            Artn.strategy.algoAssigns!.first?.printIt()
            //            for anAssign in Artn.strategy.algoAssigns! {
            //                anAssign.printIt()
            //            }
            //            print(Artn.strategy.algoAssigns!)
        } else {
            XCTAssertEqual(0, 1, "testWhoa: puzzle Tuples algoAssigns is nil!")
        }
        
        Ertn.playerAnswered = whoaPuzzle
        Ertn.given = whoaPuzzle
        Ertn.solution = whoaPuzzleSolution
        Ertn.state = states.valid
        let sGame = Game(GivenGame: Ertn)
        
        if let sGameAssigns = sGame.getAlgoAssigns() {
//            print("testWhoa: sGameAssigns = ")
//            print(sGameAssigns)
//            sGameAssigns.printIt()
            XCTAssertEqual(getAlgo, sGameAssigns, "testWhoa: getAlgoAssigns() return is not equal as expected!")
            print("testWhoa: Ertn.solvingAlgorithm = \(String(describing: Ertn.solvingAlgorithm))")
        } else {
            XCTAssertEqual(0, 1, "testWhoa: getAlgoAssigns() is nil!")
        }
    }
    
    func testNoPeers() {
        // Following puzzle should have returned any one of the units to highlight for help, but instead returnd the peers
        let noPeersPuzzle =
            ["5","7","4","6","8","2","","3","1",
             "2","","","5","9","3","7","4","6",
             "9","","6","1","7","4","8","2","5",
             "7","","8","4","2","5","6","9","3",
             "4","9","5","3","6","7","1","8","2",
             "3","6","2","8","1","9","5","7","4",
             "1","4","7","2","5","8","3","6","9",
             "8","5","3","9","4","6","2","","7",
             "6","2","9","7","3","","4","5","8"]
        let noPeersPuzzleSolution =
            ["5","7","4","6","8","2","9","3","1",
             "2","8","1","5","9","3","7","4","6",
             "9","3","6","1","7","4","8","2","5",
             "7","1","8","4","2","5","6","9","3",
             "4","9","5","3","6","7","1","8","2",
             "3","6","2","8","1","9","5","7","4",
             "1","4","7","2","5","8","3","6","9",
             "8","5","3","9","4","6","2","1","7",
             "6","2","9","7","3","1","4","5","8"]
        
        let cpAssigns = [Cell(i: 6, e: "9"), Cell(i: 10, e: "8"), Cell(i: 11, e: "1"), Cell(i: 19, e: "3"), Cell(i: 28, e: "1"), Cell(i: 70, e: "1"), Cell(i: 77, e: "1")]
        
        let cpAssignAlgo = [AlgoAssigns(aCell: Cell(i: 19, e: "3"), hhCells: [HelpCell(sq: 1, ans: "", del: "3", alg: ""), HelpCell(sq: 10, ans: "", del: "3", alg: ""), HelpCell(sq: 19, ans: "3", del: "", alg: ""), HelpCell(sq: 28, ans: "", del: "3", alg: ""), HelpCell(sq: 37, ans: "", del: "3", alg: ""), HelpCell(sq: 46, ans: "", del: "3", alg: ""), HelpCell(sq: 55, ans: "", del: "3", alg: ""), HelpCell(sq: 64, ans: "", del: "3", alg: ""), HelpCell(sq: 73, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 6, e: "9"), hhCells: [HelpCell(sq: 0, ans: "", del: "9", alg: ""), HelpCell(sq: 1, ans: "", del: "9", alg: ""), HelpCell(sq: 2, ans: "", del: "9", alg: ""), HelpCell(sq: 3, ans: "", del: "9", alg: ""), HelpCell(sq: 4, ans: "", del: "9", alg: ""), HelpCell(sq: 5, ans: "", del: "9", alg: ""), HelpCell(sq: 6, ans: "9", del: "", alg: ""), HelpCell(sq: 7, ans: "", del: "9", alg: ""), HelpCell(sq: 8, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 70, e: "1"), hhCells: [HelpCell(sq: 63, ans: "", del: "1", alg: ""), HelpCell(sq: 64, ans: "", del: "1", alg: ""), HelpCell(sq: 65, ans: "", del: "1", alg: ""), HelpCell(sq: 66, ans: "", del: "1", alg: ""), HelpCell(sq: 67, ans: "", del: "1", alg: ""), HelpCell(sq: 68, ans: "", del: "1", alg: ""), HelpCell(sq: 69, ans: "", del: "1", alg: ""), HelpCell(sq: 70, ans: "1", del: "", alg: ""), HelpCell(sq: 71, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 77, e: "1"), hhCells: [HelpCell(sq: 72, ans: "", del: "1", alg: ""), HelpCell(sq: 73, ans: "", del: "1", alg: ""), HelpCell(sq: 74, ans: "", del: "1", alg: ""), HelpCell(sq: 75, ans: "", del: "1", alg: ""), HelpCell(sq: 76, ans: "", del: "1", alg: ""), HelpCell(sq: 77, ans: "1", del: "", alg: ""), HelpCell(sq: 78, ans: "", del: "1", alg: ""), HelpCell(sq: 79, ans: "", del: "1", alg: ""), HelpCell(sq: 80, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 11, e: "1"), hhCells: [HelpCell(sq: 2, ans: "", del: "1", alg: ""), HelpCell(sq: 11, ans: "1", del: "", alg: ""), HelpCell(sq: 20, ans: "", del: "1", alg: ""), HelpCell(sq: 29, ans: "", del: "1", alg: ""), HelpCell(sq: 38, ans: "", del: "1", alg: ""), HelpCell(sq: 47, ans: "", del: "1", alg: ""), HelpCell(sq: 56, ans: "", del: "1", alg: ""), HelpCell(sq: 65, ans: "", del: "1", alg: ""), HelpCell(sq: 74, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 10, e: "8"), hhCells: [HelpCell(sq: 9, ans: "", del: "8", alg: ""), HelpCell(sq: 10, ans: "8", del: "", alg: ""), HelpCell(sq: 11, ans: "", del: "8", alg: ""), HelpCell(sq: 12, ans: "", del: "8", alg: ""), HelpCell(sq: 13, ans: "", del: "8", alg: ""), HelpCell(sq: 14, ans: "", del: "8", alg: ""), HelpCell(sq: 15, ans: "", del: "8", alg: ""), HelpCell(sq: 16, ans: "", del: "8", alg: ""), HelpCell(sq: 17, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 28, e: "1"), hhCells: [HelpCell(sq: 27, ans: "", del: "1", alg: ""), HelpCell(sq: 28, ans: "1", del: "", alg: ""), HelpCell(sq: 29, ans: "", del: "1", alg: ""), HelpCell(sq: 30, ans: "", del: "1", alg: ""), HelpCell(sq: 31, ans: "", del: "1", alg: ""), HelpCell(sq: 32, ans: "", del: "1", alg: ""), HelpCell(sq: 33, ans: "", del: "1", alg: ""), HelpCell(sq: 34, ans: "", del: "1", alg: ""), HelpCell(sq: 35, ans: "", del: "1", alg: "")], aAlgo: "One Rule")]
        let cpAssignAlgoFirst = cpAssignAlgo.first
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = noPeersPuzzle
        Ertn.solution = noPeersPuzzleSolution
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, nil, nil)
        
        print("testNoPeers: solved units count = \(algoResults.solvedUnits.count)")
        print("testNoPeers: solved units = \(algoResults.solvedUnits)")
        
        XCTAssertEqual(noPeersPuzzleSolution, Artn.strategy.pzzlSet.playerAnswered, "testNoPeers: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testNoPeers: Solved puzzle state is solved!")
        
        print("\n\n noPeersPuzzle: Artn.strategy.cpAssigns!.count = \(Artn.strategy.cpAssigns.count), cpAssigns.count = \(cpAssigns.count)")
        let ArtnCpAssignsSorted = Artn.strategy.cpAssigns.sorted(by: {(cell1: Cell, cell2: Cell) -> Bool in return cell1.square < cell2.square })
//        print(ArtnCpAssignsSorted)
//        print("\n\n")
        XCTAssertEqual(cpAssigns, ArtnCpAssignsSorted, "noPeersPuzzle: puzzle CP cpAssigns as expected!")
        
        if Artn.strategy.algoAssigns != nil {
            print("\n\n Artn.strategy.algoAssigns with count of \(String(describing: Artn.strategy.algoAssigns?.count)) =")
            print(Artn.strategy.algoAssigns!)
            print("\n\n")
            XCTAssertEqual(cpAssignAlgo, Artn.strategy.algoAssigns!, "noPeersPuzzle: puzzle CP cpAssigns as expected!")
            XCTAssertEqual(cpAssignAlgoFirst, Artn.strategy.algoAssigns?.first!, "noPeersPuzzle: CP algoAssigns.first not as expected!")
            print("noPeersPuzzle: cpAssignAlgo.count = \(cpAssignAlgo.count), Artn.strategy.algoAssigns!.count = \(Artn.strategy.algoAssigns!.count)\n\n")
            print("Artn.strategy.algoAssigns.first = ")
            Artn.strategy.algoAssigns!.first?.printIt()
            //            for anAssign in Artn.strategy.algoAssigns! {
            //                anAssign.printIt()
            //            }
            //            print(Artn.strategy.algoAssigns!)
        } else {
            XCTAssertEqual(0, 1, "noPeersPuzzle: puzzle Tuples algoAssigns is nil!")
        }
        
//        Ertn.playerAnswered = noPeersPuzzle
//        Ertn.given = noPeersPuzzle
//        Ertn.solution = noPeersPuzzleSolution
//        Ertn.state = states.valid
//        let sGame = Game(GivenGame: Ertn)
//        
//        if let sGameAssigns = sGame.getAlgoAssigns() {
//            print("noPeersPuzzle: sGameAssigns = ")
//            sGameAssigns.printIt()
//            XCTAssertEqual(cpAssignAlgoFirst, sGameAssigns, "noPeersPuzzle: getAlgoAssigns() return is not equal as expected!")
//            print("noPeersPuzzle: Ertn.solvingAlgorithm = \(Ertn.solvingAlgorithm)")
//        } else {
//            XCTAssertEqual(0, 1, "noPeersPuzzle: getAlgoAssigns() is nil!")
//        }
    }
    
    func testHighlightCells() {
        // Following Easy puzzle can be solved with constraint propagation (50 givens, 9 values)
        let easyPuzzle =
            ["5","1","6","","","","","","",
             "8","4","9","5","1","7","2","","",
             "","2","7","","6","","4","1","5",
             "1","","5","6","","","","","",
             "9","6","4","","7","5","","","",
             "7","8","2","","","1","6","5","",
             "4","5","3","7","","","","","",
             "2","7","8","1","5","6","3","9","4",
             "6","9","1","4","","","5","2","7"]
        let easyPuzzleSolution =
            ["5", "1", "6", "2", "3", "4", "9", "7", "8",
             "8", "4", "9", "5", "1", "7", "2", "3", "6",
             "3", "2", "7", "8", "6", "9", "4", "1", "5",
             "1", "3", "5", "6", "2", "8", "7", "4", "9",
             "9", "6", "4", "3", "7", "5", "1", "8", "2",
             "7", "8", "2", "9", "4", "1", "6", "5", "3",
             "4", "5", "3", "7", "9", "2", "8", "6", "1",
             "2", "7", "8", "1", "5", "6", "3", "9", "4",
             "6", "9", "1", "4", "8", "3", "5", "2", "7"]
        
        let cpAssigns = [Cell(i: 3, e: "2"), Cell(i: 4, e: "3"), Cell(i: 5, e: "4"), Cell(i: 6, e: "9"), Cell(i: 7, e: "7"), Cell(i: 8, e: "8"), Cell(i: 16, e: "3"), Cell(i: 17, e: "6"), Cell(i: 18, e: "3"), Cell(i: 21, e: "8"), Cell(i: 23, e: "9"), Cell(i: 28, e: "3"), Cell(i: 31, e: "2"), Cell(i: 32, e: "8"), Cell(i: 33, e: "7"), Cell(i: 34, e: "4"), Cell(i: 35, e: "9"), Cell(i: 39, e: "3"), Cell(i: 42, e: "1"), Cell(i: 43, e: "8"), Cell(i: 44, e: "2"), Cell(i: 48, e: "9"), Cell(i: 49, e: "4"), Cell(i: 53, e: "3"), Cell(i: 58, e: "9"), Cell(i: 59, e: "2"), Cell(i: 60, e: "8"), Cell(i: 61, e: "6"), Cell(i: 62, e: "1"), Cell(i: 76, e: "8"), Cell(i: 77, e: "3")]
        
        let cpAssignAlgo = [AlgoAssigns(aCell: Cell(i: 49, e: "4"), hhCells: [HelpCell(sq: 45, ans: "", del: "4", alg: ""), HelpCell(sq: 46, ans: "", del: "4", alg: ""), HelpCell(sq: 47, ans: "", del: "4", alg: ""), HelpCell(sq: 48, ans: "", del: "4", alg: ""), HelpCell(sq: 49, ans: "4", del: "", alg: ""), HelpCell(sq: 50, ans: "", del: "4", alg: ""), HelpCell(sq: 51, ans: "", del: "4", alg: ""), HelpCell(sq: 52, ans: "", del: "4", alg: ""), HelpCell(sq: 53, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 5, e: "4"), hhCells: [HelpCell(sq: 0, ans: "", del: "4", alg: ""), HelpCell(sq: 1, ans: "", del: "4", alg: ""), HelpCell(sq: 2, ans: "", del: "4", alg: ""), HelpCell(sq: 3, ans: "", del: "4", alg: ""), HelpCell(sq: 4, ans: "", del: "4", alg: ""), HelpCell(sq: 5, ans: "4", del: "", alg: ""), HelpCell(sq: 6, ans: "", del: "4", alg: ""), HelpCell(sq: 7, ans: "", del: "4", alg: ""), HelpCell(sq: 8, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 34, e: "4"), hhCells: [HelpCell(sq: 27, ans: "", del: "4", alg: ""), HelpCell(sq: 28, ans: "", del: "4", alg: ""), HelpCell(sq: 29, ans: "", del: "4", alg: ""), HelpCell(sq: 30, ans: "", del: "4", alg: ""), HelpCell(sq: 31, ans: "", del: "4", alg: ""), HelpCell(sq: 32, ans: "", del: "4", alg: ""), HelpCell(sq: 33, ans: "", del: "4", alg: ""), HelpCell(sq: 34, ans: "4", del: "", alg: ""), HelpCell(sq: 35, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 33, e: "7"), hhCells: [HelpCell(sq: 27, ans: "", del: "7", alg: ""), HelpCell(sq: 28, ans: "", del: "7", alg: ""), HelpCell(sq: 29, ans: "", del: "7", alg: ""), HelpCell(sq: 30, ans: "", del: "7", alg: ""), HelpCell(sq: 31, ans: "", del: "7", alg: ""), HelpCell(sq: 32, ans: "", del: "7", alg: ""), HelpCell(sq: 33, ans: "7", del: "", alg: ""), HelpCell(sq: 34, ans: "", del: "7", alg: ""), HelpCell(sq: 35, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 7, e: "7"), hhCells: [HelpCell(sq: 0, ans: "", del: "7", alg: ""), HelpCell(sq: 1, ans: "", del: "7", alg: ""), HelpCell(sq: 2, ans: "", del: "7", alg: ""), HelpCell(sq: 3, ans: "", del: "7", alg: ""), HelpCell(sq: 4, ans: "", del: "7", alg: ""), HelpCell(sq: 5, ans: "", del: "7", alg: ""), HelpCell(sq: 6, ans: "", del: "7", alg: ""), HelpCell(sq: 7, ans: "7", del: "", alg: ""), HelpCell(sq: 8, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 18, e: "3"), hhCells: [HelpCell(sq: 0, ans: "", del: "3", alg: ""), HelpCell(sq: 9, ans: "", del: "3", alg: ""), HelpCell(sq: 18, ans: "3", del: "", alg: ""), HelpCell(sq: 27, ans: "", del: "3", alg: ""), HelpCell(sq: 36, ans: "", del: "3", alg: ""), HelpCell(sq: 45, ans: "", del: "3", alg: ""), HelpCell(sq: 54, ans: "", del: "3", alg: ""), HelpCell(sq: 63, ans: "", del: "3", alg: ""), HelpCell(sq: 72, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 28, e: "3"), hhCells: [HelpCell(sq: 1, ans: "", del: "3", alg: ""), HelpCell(sq: 10, ans: "", del: "3", alg: ""), HelpCell(sq: 19, ans: "", del: "3", alg: ""), HelpCell(sq: 28, ans: "3", del: "", alg: ""), HelpCell(sq: 37, ans: "", del: "3", alg: ""), HelpCell(sq: 46, ans: "", del: "3", alg: ""), HelpCell(sq: 55, ans: "", del: "3", alg: ""), HelpCell(sq: 64, ans: "", del: "3", alg: ""), HelpCell(sq: 73, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 77, e: "3"), hhCells: [HelpCell(sq: 5, ans: "", del: "3", alg: ""), HelpCell(sq: 14, ans: "", del: "3", alg: ""), HelpCell(sq: 23, ans: "", del: "3", alg: ""), HelpCell(sq: 32, ans: "", del: "3", alg: ""), HelpCell(sq: 41, ans: "", del: "3", alg: ""), HelpCell(sq: 50, ans: "", del: "3", alg: ""), HelpCell(sq: 59, ans: "", del: "3", alg: ""), HelpCell(sq: 68, ans: "", del: "3", alg: ""), HelpCell(sq: 77, ans: "3", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 76, e: "8"), hhCells: [HelpCell(sq: 72, ans: "", del: "8", alg: ""), HelpCell(sq: 73, ans: "", del: "8", alg: ""), HelpCell(sq: 74, ans: "", del: "8", alg: ""), HelpCell(sq: 75, ans: "", del: "8", alg: ""), HelpCell(sq: 76, ans: "8", del: "", alg: ""), HelpCell(sq: 77, ans: "", del: "8", alg: ""), HelpCell(sq: 78, ans: "", del: "8", alg: ""), HelpCell(sq: 79, ans: "", del: "8", alg: ""), HelpCell(sq: 80, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 4, e: "3"), hhCells: [HelpCell(sq: 4, ans: "3", del: "", alg: ""), HelpCell(sq: 13, ans: "", del: "3", alg: ""), HelpCell(sq: 22, ans: "", del: "3", alg: ""), HelpCell(sq: 31, ans: "", del: "3", alg: ""), HelpCell(sq: 40, ans: "", del: "3", alg: ""), HelpCell(sq: 49, ans: "", del: "3", alg: ""), HelpCell(sq: 58, ans: "", del: "3", alg: ""), HelpCell(sq: 67, ans: "", del: "3", alg: ""), HelpCell(sq: 76, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 3, e: "2"), hhCells: [HelpCell(sq: 0, ans: "", del: "2", alg: ""), HelpCell(sq: 1, ans: "", del: "2", alg: ""), HelpCell(sq: 2, ans: "", del: "2", alg: ""), HelpCell(sq: 3, ans: "2", del: "", alg: ""), HelpCell(sq: 4, ans: "", del: "2", alg: ""), HelpCell(sq: 5, ans: "", del: "2", alg: ""), HelpCell(sq: 6, ans: "", del: "2", alg: ""), HelpCell(sq: 7, ans: "", del: "2", alg: ""), HelpCell(sq: 8, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 44, e: "2"), hhCells: [HelpCell(sq: 36, ans: "", del: "2", alg: ""), HelpCell(sq: 37, ans: "", del: "2", alg: ""), HelpCell(sq: 38, ans: "", del: "2", alg: ""), HelpCell(sq: 39, ans: "", del: "2", alg: ""), HelpCell(sq: 40, ans: "", del: "2", alg: ""), HelpCell(sq: 41, ans: "", del: "2", alg: ""), HelpCell(sq: 42, ans: "", del: "2", alg: ""), HelpCell(sq: 43, ans: "", del: "2", alg: ""), HelpCell(sq: 44, ans: "2", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 42, e: "1"), hhCells: [HelpCell(sq: 36, ans: "", del: "1", alg: ""), HelpCell(sq: 37, ans: "", del: "1", alg: ""), HelpCell(sq: 38, ans: "", del: "1", alg: ""), HelpCell(sq: 39, ans: "", del: "1", alg: ""), HelpCell(sq: 40, ans: "", del: "1", alg: ""), HelpCell(sq: 41, ans: "", del: "1", alg: ""), HelpCell(sq: 42, ans: "1", del: "", alg: ""), HelpCell(sq: 43, ans: "", del: "1", alg: ""), HelpCell(sq: 44, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 62, e: "1"), hhCells: [HelpCell(sq: 54, ans: "", del: "1", alg: ""), HelpCell(sq: 55, ans: "", del: "1", alg: ""), HelpCell(sq: 56, ans: "", del: "1", alg: ""), HelpCell(sq: 57, ans: "", del: "1", alg: ""), HelpCell(sq: 58, ans: "", del: "1", alg: ""), HelpCell(sq: 59, ans: "", del: "1", alg: ""), HelpCell(sq: 60, ans: "", del: "1", alg: ""), HelpCell(sq: 61, ans: "", del: "1", alg: ""), HelpCell(sq: 62, ans: "1", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 61, e: "6"), hhCells: [HelpCell(sq: 54, ans: "", del: "6", alg: ""), HelpCell(sq: 55, ans: "", del: "6", alg: ""), HelpCell(sq: 56, ans: "", del: "6", alg: ""), HelpCell(sq: 57, ans: "", del: "6", alg: ""), HelpCell(sq: 58, ans: "", del: "6", alg: ""), HelpCell(sq: 59, ans: "", del: "6", alg: ""), HelpCell(sq: 60, ans: "", del: "6", alg: ""), HelpCell(sq: 61, ans: "6", del: "", alg: ""), HelpCell(sq: 62, ans: "", del: "6", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 43, e: "8"), hhCells: [HelpCell(sq: 7, ans: "", del: "8", alg: ""), HelpCell(sq: 16, ans: "", del: "8", alg: ""), HelpCell(sq: 25, ans: "", del: "8", alg: ""), HelpCell(sq: 34, ans: "", del: "8", alg: ""), HelpCell(sq: 43, ans: "8", del: "", alg: ""), HelpCell(sq: 52, ans: "", del: "8", alg: ""), HelpCell(sq: 61, ans: "", del: "8", alg: ""), HelpCell(sq: 70, ans: "", del: "8", alg: ""), HelpCell(sq: 79, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 16, e: "3"), hhCells: [HelpCell(sq: 7, ans: "", del: "3", alg: ""), HelpCell(sq: 16, ans: "3", del: "", alg: ""), HelpCell(sq: 25, ans: "", del: "3", alg: ""), HelpCell(sq: 34, ans: "", del: "3", alg: ""), HelpCell(sq: 43, ans: "", del: "3", alg: ""), HelpCell(sq: 52, ans: "", del: "3", alg: ""), HelpCell(sq: 61, ans: "", del: "3", alg: ""), HelpCell(sq: 70, ans: "", del: "3", alg: ""), HelpCell(sq: 79, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 17, e: "6"), hhCells: [HelpCell(sq: 9, ans: "", del: "6", alg: ""), HelpCell(sq: 10, ans: "", del: "6", alg: ""), HelpCell(sq: 11, ans: "", del: "6", alg: ""), HelpCell(sq: 12, ans: "", del: "6", alg: ""), HelpCell(sq: 13, ans: "", del: "6", alg: ""), HelpCell(sq: 14, ans: "", del: "6", alg: ""), HelpCell(sq: 15, ans: "", del: "6", alg: ""), HelpCell(sq: 16, ans: "", del: "6", alg: ""), HelpCell(sq: 17, ans: "6", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 21, e: "8"), hhCells: [HelpCell(sq: 3, ans: "", del: "8", alg: ""), HelpCell(sq: 12, ans: "", del: "8", alg: ""), HelpCell(sq: 21, ans: "8", del: "", alg: ""), HelpCell(sq: 30, ans: "", del: "8", alg: ""), HelpCell(sq: 39, ans: "", del: "8", alg: ""), HelpCell(sq: 48, ans: "", del: "8", alg: ""), HelpCell(sq: 57, ans: "", del: "8", alg: ""), HelpCell(sq: 66, ans: "", del: "8", alg: ""), HelpCell(sq: 75, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 23, e: "9"), hhCells: [HelpCell(sq: 18, ans: "", del: "9", alg: ""), HelpCell(sq: 19, ans: "", del: "9", alg: ""), HelpCell(sq: 20, ans: "", del: "9", alg: ""), HelpCell(sq: 21, ans: "", del: "9", alg: ""), HelpCell(sq: 22, ans: "", del: "9", alg: ""), HelpCell(sq: 23, ans: "9", del: "", alg: ""), HelpCell(sq: 24, ans: "", del: "9", alg: ""), HelpCell(sq: 25, ans: "", del: "9", alg: ""), HelpCell(sq: 26, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 8, e: "8"), hhCells: [HelpCell(sq: 8, ans: "8", del: "", alg: ""), HelpCell(sq: 17, ans: "", del: "8", alg: ""), HelpCell(sq: 26, ans: "", del: "8", alg: ""), HelpCell(sq: 35, ans: "", del: "8", alg: ""), HelpCell(sq: 44, ans: "", del: "8", alg: ""), HelpCell(sq: 53, ans: "", del: "8", alg: ""), HelpCell(sq: 62, ans: "", del: "8", alg: ""), HelpCell(sq: 71, ans: "", del: "8", alg: ""), HelpCell(sq: 80, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 6, e: "9"), hhCells: [HelpCell(sq: 0, ans: "", del: "9", alg: ""), HelpCell(sq: 1, ans: "", del: "9", alg: ""), HelpCell(sq: 2, ans: "", del: "9", alg: ""), HelpCell(sq: 3, ans: "", del: "9", alg: ""), HelpCell(sq: 4, ans: "", del: "9", alg: ""), HelpCell(sq: 5, ans: "", del: "9", alg: ""), HelpCell(sq: 6, ans: "9", del: "", alg: ""), HelpCell(sq: 7, ans: "", del: "9", alg: ""), HelpCell(sq: 8, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 60, e: "8"), hhCells: [HelpCell(sq: 6, ans: "", del: "8", alg: ""), HelpCell(sq: 15, ans: "", del: "8", alg: ""), HelpCell(sq: 24, ans: "", del: "8", alg: ""), HelpCell(sq: 33, ans: "", del: "8", alg: ""), HelpCell(sq: 42, ans: "", del: "8", alg: ""), HelpCell(sq: 51, ans: "", del: "8", alg: ""), HelpCell(sq: 60, ans: "8", del: "", alg: ""), HelpCell(sq: 69, ans: "", del: "8", alg: ""), HelpCell(sq: 78, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 59, e: "2"), hhCells: [HelpCell(sq: 5, ans: "", del: "2", alg: ""), HelpCell(sq: 14, ans: "", del: "2", alg: ""), HelpCell(sq: 23, ans: "", del: "2", alg: ""), HelpCell(sq: 32, ans: "", del: "2", alg: ""), HelpCell(sq: 41, ans: "", del: "2", alg: ""), HelpCell(sq: 50, ans: "", del: "2", alg: ""), HelpCell(sq: 54, ans: "", del: "2", alg: ""), HelpCell(sq: 55, ans: "", del: "2", alg: ""), HelpCell(sq: 56, ans: "", del: "2", alg: ""), HelpCell(sq: 57, ans: "", del: "2", alg: ""), HelpCell(sq: 58, ans: "", del: "2", alg: ""), HelpCell(sq: 60, ans: "", del: "2", alg: ""), HelpCell(sq: 61, ans: "", del: "2", alg: ""), HelpCell(sq: 62, ans: "", del: "2", alg: ""), HelpCell(sq: 66, ans: "", del: "2", alg: ""), HelpCell(sq: 67, ans: "", del: "2", alg: ""), HelpCell(sq: 68, ans: "", del: "2", alg: ""), HelpCell(sq: 75, ans: "", del: "2", alg: ""), HelpCell(sq: 76, ans: "", del: "2", alg: ""), HelpCell(sq: 77, ans: "", del: "2", alg: ""), HelpCell(sq: 59, ans: "2", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 32, e: "8"), hhCells: [HelpCell(sq: 5, ans: "", del: "8", alg: ""), HelpCell(sq: 14, ans: "", del: "8", alg: ""), HelpCell(sq: 23, ans: "", del: "8", alg: ""), HelpCell(sq: 32, ans: "8", del: "", alg: ""), HelpCell(sq: 41, ans: "", del: "8", alg: ""), HelpCell(sq: 50, ans: "", del: "8", alg: ""), HelpCell(sq: 59, ans: "", del: "8", alg: ""), HelpCell(sq: 68, ans: "", del: "8", alg: ""), HelpCell(sq: 77, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 58, e: "9"), hhCells: [HelpCell(sq: 57, ans: "", del: "9", alg: ""), HelpCell(sq: 58, ans: "9", del: "", alg: ""), HelpCell(sq: 59, ans: "", del: "9", alg: ""), HelpCell(sq: 66, ans: "", del: "9", alg: ""), HelpCell(sq: 67, ans: "", del: "9", alg: ""), HelpCell(sq: 68, ans: "", del: "9", alg: ""), HelpCell(sq: 75, ans: "", del: "9", alg: ""), HelpCell(sq: 76, ans: "", del: "9", alg: ""), HelpCell(sq: 77, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 31, e: "2"), hhCells: [HelpCell(sq: 4, ans: "", del: "2", alg: ""), HelpCell(sq: 13, ans: "", del: "2", alg: ""), HelpCell(sq: 22, ans: "", del: "2", alg: ""), HelpCell(sq: 31, ans: "2", del: "", alg: ""), HelpCell(sq: 40, ans: "", del: "2", alg: ""), HelpCell(sq: 49, ans: "", del: "2", alg: ""), HelpCell(sq: 58, ans: "", del: "2", alg: ""), HelpCell(sq: 67, ans: "", del: "2", alg: ""), HelpCell(sq: 76, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 39, e: "3"), hhCells: [HelpCell(sq: 36, ans: "", del: "3", alg: ""), HelpCell(sq: 37, ans: "", del: "3", alg: ""), HelpCell(sq: 38, ans: "", del: "3", alg: ""), HelpCell(sq: 39, ans: "3", del: "", alg: ""), HelpCell(sq: 40, ans: "", del: "3", alg: ""), HelpCell(sq: 41, ans: "", del: "3", alg: ""), HelpCell(sq: 42, ans: "", del: "3", alg: ""), HelpCell(sq: 43, ans: "", del: "3", alg: ""), HelpCell(sq: 44, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 48, e: "9"), hhCells: [HelpCell(sq: 3, ans: "", del: "9", alg: ""), HelpCell(sq: 12, ans: "", del: "9", alg: ""), HelpCell(sq: 21, ans: "", del: "9", alg: ""), HelpCell(sq: 30, ans: "", del: "9", alg: ""), HelpCell(sq: 39, ans: "", del: "9", alg: ""), HelpCell(sq: 48, ans: "9", del: "", alg: ""), HelpCell(sq: 57, ans: "", del: "9", alg: ""), HelpCell(sq: 66, ans: "", del: "9", alg: ""), HelpCell(sq: 75, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 53, e: "3"), hhCells: [HelpCell(sq: 45, ans: "", del: "3", alg: ""), HelpCell(sq: 46, ans: "", del: "3", alg: ""), HelpCell(sq: 47, ans: "", del: "3", alg: ""), HelpCell(sq: 48, ans: "", del: "3", alg: ""), HelpCell(sq: 49, ans: "", del: "3", alg: ""), HelpCell(sq: 50, ans: "", del: "3", alg: ""), HelpCell(sq: 51, ans: "", del: "3", alg: ""), HelpCell(sq: 52, ans: "", del: "3", alg: ""), HelpCell(sq: 53, ans: "3", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 35, e: "9"), hhCells: [HelpCell(sq: 27, ans: "", del: "9", alg: ""), HelpCell(sq: 28, ans: "", del: "9", alg: ""), HelpCell(sq: 29, ans: "", del: "9", alg: ""), HelpCell(sq: 30, ans: "", del: "9", alg: ""), HelpCell(sq: 31, ans: "", del: "9", alg: ""), HelpCell(sq: 32, ans: "", del: "9", alg: ""), HelpCell(sq: 33, ans: "", del: "9", alg: ""), HelpCell(sq: 34, ans: "", del: "9", alg: ""), HelpCell(sq: 35, ans: "9", del: "", alg: "")], aAlgo: "One Rule")]
        let cpAssignAlgoFirst = cpAssignAlgo.first
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = easyPuzzle
        Ertn.solution = easyPuzzleSolution
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, nil, nil)
        
        //        print("testAlgoAssignsByCP: easy puzzle = ")
        //        printPuzzle(algoResults.playerAnswered)
        
        print("testHighlightCells: solved units count = \(algoResults.solvedUnits.count)")
        print("testHighlightCells: solved units = \(algoResults.solvedUnits)")
        
        XCTAssertEqual(easyPuzzleSolution, Artn.strategy.pzzlSet.playerAnswered, "testHighlightCells: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testHighlightCells: Solved puzzle state is solved!")
        
        print("\n\n testHighlightCells: Artn.strategy.cpAssigns!.count = \(Artn.strategy.cpAssigns.count), cpAssigns.count = \(cpAssigns.count)")
        let ArtnCpAssignsSorted = Artn.strategy.cpAssigns.sorted(by: {(cell1: Cell, cell2: Cell) -> Bool in return cell1.square < cell2.square })
//        print(ArtnCpAssignsSorted)
//        print("\n\n")
        XCTAssertEqual(cpAssigns, ArtnCpAssignsSorted, "testHighlightCells: puzzle CP cpAssigns as expected!")
        
        if Artn.strategy.algoAssigns != nil {
//            print("\n\n Artn.strategy.algoAssigns with count of \(String(describing: Artn.strategy.algoAssigns?.count)) =")
//            print(Artn.strategy.algoAssigns!)
//            print("\n\n")
            XCTAssertEqual(cpAssignAlgo, Artn.strategy.algoAssigns!, "testHighlightCells: puzzle CP cpAssigns as expected!")
            XCTAssertEqual(cpAssignAlgoFirst, Artn.strategy.algoAssigns?.first!, "testHighlightCells: CP algoAssigns.first not as expected!")
            print("testHighlightCells: cpAssignAlgo.count = \(cpAssignAlgo.count), Artn.strategy.algoAssigns!.count = \(Artn.strategy.algoAssigns!.count)\n\n")
            print("Artn.strategy.algoAssigns.first = ")
            Artn.strategy.algoAssigns!.first?.printIt()
            //            for anAssign in Artn.strategy.algoAssigns! {
            //                anAssign.printIt()
            //            }
            //            print(Artn.strategy.algoAssigns!)
        } else {
            XCTAssertEqual(0, 1, "testHighlightCells: puzzle Tuples algoAssigns is nil!")
        }
        
        Ertn.playerAnswered = easyPuzzle
        Ertn.given = easyPuzzle
        Ertn.solution = easyPuzzleSolution
        Ertn.state = states.valid
        let sGame = Game(GivenGame: Ertn)
        if let peersOf18 = PuzzleLets.globalVar.peersDict[18] {
            print("testHighlightCells: peers of 18 = \(peersOf18)")
        } else {
            print("testHighlightCells: peers of 18 is nil!")
        }
        
        if let sGameAssigns = sGame.getAlgoAssigns() {
            print("testHighlightCells: sGameAssigns = ")
            sGameAssigns.printIt()
            XCTAssertEqual(cpAssignAlgoFirst, sGameAssigns, "testHighlightCells: getAlgoAssigns() return is not equal as expected!")
            print("testHighlightCells: Ertn.solvingAlgorithm = \(String(describing: Ertn.solvingAlgorithm))")
        } else {
            XCTAssertEqual(0, 1, "testHighlightCells: getAlgoAssigns() is nil!")
        }
    }
    
    func testAlgoAssignsByCP() {
        
        // Following Easy puzzle can be solved with constraint propagation (32 givens, 9 values)
        let easyPuzzle =
            ["","","3","","2","","6","","",
             "9","","","3","","5","","","1",
             "","","1","8","","6","4","","",
             "","","8","1","","2","9","","",
             "7","","","","","","","","8",
             "","","6","7","","8","2","","",
             "","","2","6","","9","5","","",
             "8","","","2","","3","","","9",
             "","","5","","1","","3","",""]
        let easyPuzzleSolution =
            ["4","8","3","9","2","1","6","5","7",
             "9","6","7","3","4","5","8","2","1",
             "2","5","1","8","7","6","4","9","3",
             "5","4","8","1","3","2","9","7","6",
             "7","2","9","5","6","4","1","3","8",
             "1","3","6","7","9","8","2","4","5",
             "3","7","2","6","8","9","5","1","4",
             "8","1","4","2","5","3","7","6","9",
             "6","9","5","4","1","7","3","8","2"]

        let cpAssigns = [Cell(i: 5, e: "1"), Cell(i: 37, e: "2"), Cell(i: 18, e: "2"), Cell(i: 16, e: "2"), Cell(i: 80, e: "2"), Cell(i: 39, e: "5"), Cell(i: 67, e: "5"), Cell(i: 10, e: "6"), Cell(i: 72, e: "6"), Cell(i: 70, e: "6"), Cell(i: 40, e: "6"), Cell(i: 43, e: "3"), Cell(i: 42, e: "1"), Cell(i: 61, e: "1"), Cell(i: 45, e: "1"), Cell(i: 64, e: "1"), Cell(i: 65, e: "4"), Cell(i: 13, e: "4"), Cell(i: 75, e: "4"), Cell(i: 41, e: "4"), Cell(i: 77, e: "7"), Cell(i: 58, e: "8"), Cell(i: 62, e: "4"), Cell(i: 69, e: "7"), Cell(i: 15, e: "8"), Cell(i: 11, e: "7"), Cell(i: 38, e: "9"), Cell(i: 79, e: "8"), Cell(i: 73, e: "9"), Cell(i: 3, e: "9"), Cell(i: 35, e: "6"), Cell(i: 22, e: "7"), Cell(i: 25, e: "9"), Cell(i: 26, e: "3"), Cell(i: 49, e: "9"), Cell(i: 31, e: "3"), Cell(i: 54, e: "3"), Cell(i: 55, e: "7"), Cell(i: 46, e: "3"), Cell(i: 52, e: "4"), Cell(i: 53, e: "5"), Cell(i: 8, e: "7"), Cell(i: 7, e: "5"), Cell(i: 27, e: "5"), Cell(i: 0, e: "4"), Cell(i: 28, e: "4"), Cell(i: 34, e: "7"), Cell(i: 1, e: "8"), Cell(i: 19, e: "5")]
        
        let cpAssignAlgo = [AlgoAssigns(aCell: Cell(i: 5, e: "1"), hhCells: [HelpCell(sq: 0, ans: "", del: "1", alg: ""), HelpCell(sq: 1, ans: "", del: "1", alg: ""), HelpCell(sq: 2, ans: "", del: "1", alg: ""), HelpCell(sq: 3, ans: "", del: "1", alg: ""), HelpCell(sq: 4, ans: "", del: "1", alg: ""), HelpCell(sq: 5, ans: "1", del: "", alg: ""), HelpCell(sq: 6, ans: "", del: "1", alg: ""), HelpCell(sq: 7, ans: "", del: "1", alg: ""), HelpCell(sq: 8, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 37, e: "2"), hhCells: [HelpCell(sq: 36, ans: "", del: "2", alg: ""), HelpCell(sq: 37, ans: "2", del: "", alg: ""), HelpCell(sq: 38, ans: "", del: "2", alg: ""), HelpCell(sq: 39, ans: "", del: "2", alg: ""), HelpCell(sq: 40, ans: "", del: "2", alg: ""), HelpCell(sq: 41, ans: "", del: "2", alg: ""), HelpCell(sq: 42, ans: "", del: "2", alg: ""), HelpCell(sq: 43, ans: "", del: "2", alg: ""), HelpCell(sq: 44, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 18, e: "2"), hhCells: [HelpCell(sq: 0, ans: "", del: "2", alg: ""), HelpCell(sq: 9, ans: "", del: "2", alg: ""), HelpCell(sq: 18, ans: "2", del: "", alg: ""), HelpCell(sq: 27, ans: "", del: "2", alg: ""), HelpCell(sq: 36, ans: "", del: "2", alg: ""), HelpCell(sq: 45, ans: "", del: "2", alg: ""), HelpCell(sq: 54, ans: "", del: "2", alg: ""), HelpCell(sq: 63, ans: "", del: "2", alg: ""), HelpCell(sq: 72, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 16, e: "2"), hhCells: [HelpCell(sq: 9, ans: "", del: "2", alg: ""), HelpCell(sq: 10, ans: "", del: "2", alg: ""), HelpCell(sq: 11, ans: "", del: "2", alg: ""), HelpCell(sq: 12, ans: "", del: "2", alg: ""), HelpCell(sq: 13, ans: "", del: "2", alg: ""), HelpCell(sq: 14, ans: "", del: "2", alg: ""), HelpCell(sq: 15, ans: "", del: "2", alg: ""), HelpCell(sq: 16, ans: "2", del: "", alg: ""), HelpCell(sq: 17, ans: "", del: "2", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 80, e: "2"), hhCells: [HelpCell(sq: 72, ans: "", del: "2", alg: ""), HelpCell(sq: 73, ans: "", del: "2", alg: ""), HelpCell(sq: 74, ans: "", del: "2", alg: ""), HelpCell(sq: 75, ans: "", del: "2", alg: ""), HelpCell(sq: 76, ans: "", del: "2", alg: ""), HelpCell(sq: 77, ans: "", del: "2", alg: ""), HelpCell(sq: 78, ans: "", del: "2", alg: ""), HelpCell(sq: 79, ans: "", del: "2", alg: ""), HelpCell(sq: 80, ans: "2", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 39, e: "5"), hhCells: [HelpCell(sq: 3, ans: "", del: "5", alg: ""), HelpCell(sq: 12, ans: "", del: "5", alg: ""), HelpCell(sq: 21, ans: "", del: "5", alg: ""), HelpCell(sq: 30, ans: "", del: "5", alg: ""), HelpCell(sq: 39, ans: "5", del: "", alg: ""), HelpCell(sq: 48, ans: "", del: "5", alg: ""), HelpCell(sq: 57, ans: "", del: "5", alg: ""), HelpCell(sq: 66, ans: "", del: "5", alg: ""), HelpCell(sq: 75, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 67, e: "5"), hhCells: [HelpCell(sq: 4, ans: "", del: "5", alg: ""), HelpCell(sq: 13, ans: "", del: "5", alg: ""), HelpCell(sq: 22, ans: "", del: "5", alg: ""), HelpCell(sq: 31, ans: "", del: "5", alg: ""), HelpCell(sq: 40, ans: "", del: "5", alg: ""), HelpCell(sq: 49, ans: "", del: "5", alg: ""), HelpCell(sq: 58, ans: "", del: "5", alg: ""), HelpCell(sq: 67, ans: "5", del: "", alg: ""), HelpCell(sq: 76, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 10, e: "6"), hhCells: [HelpCell(sq: 9, ans: "", del: "6", alg: ""), HelpCell(sq: 10, ans: "6", del: "", alg: ""), HelpCell(sq: 11, ans: "", del: "6", alg: ""), HelpCell(sq: 12, ans: "", del: "6", alg: ""), HelpCell(sq: 13, ans: "", del: "6", alg: ""), HelpCell(sq: 14, ans: "", del: "6", alg: ""), HelpCell(sq: 15, ans: "", del: "6", alg: ""), HelpCell(sq: 16, ans: "", del: "6", alg: ""), HelpCell(sq: 17, ans: "", del: "6", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 72, e: "6"), hhCells: [HelpCell(sq: 0, ans: "", del: "6", alg: ""), HelpCell(sq: 9, ans: "", del: "6", alg: ""), HelpCell(sq: 18, ans: "", del: "6", alg: ""), HelpCell(sq: 27, ans: "", del: "6", alg: ""), HelpCell(sq: 36, ans: "", del: "6", alg: ""), HelpCell(sq: 45, ans: "", del: "6", alg: ""), HelpCell(sq: 54, ans: "", del: "6", alg: ""), HelpCell(sq: 63, ans: "", del: "6", alg: ""), HelpCell(sq: 72, ans: "6", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 70, e: "6"), hhCells: [HelpCell(sq: 63, ans: "", del: "6", alg: ""), HelpCell(sq: 64, ans: "", del: "6", alg: ""), HelpCell(sq: 65, ans: "", del: "6", alg: ""), HelpCell(sq: 66, ans: "", del: "6", alg: ""), HelpCell(sq: 67, ans: "", del: "6", alg: ""), HelpCell(sq: 68, ans: "", del: "6", alg: ""), HelpCell(sq: 69, ans: "", del: "6", alg: ""), HelpCell(sq: 70, ans: "6", del: "", alg: ""), HelpCell(sq: 71, ans: "", del: "6", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 40, e: "6"), hhCells: [HelpCell(sq: 36, ans: "", del: "6", alg: ""), HelpCell(sq: 37, ans: "", del: "6", alg: ""), HelpCell(sq: 38, ans: "", del: "6", alg: ""), HelpCell(sq: 39, ans: "", del: "6", alg: ""), HelpCell(sq: 40, ans: "6", del: "", alg: ""), HelpCell(sq: 41, ans: "", del: "6", alg: ""), HelpCell(sq: 42, ans: "", del: "6", alg: ""), HelpCell(sq: 43, ans: "", del: "6", alg: ""), HelpCell(sq: 44, ans: "", del: "6", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 43, e: "3"), hhCells: [HelpCell(sq: 36, ans: "", del: "3", alg: ""), HelpCell(sq: 37, ans: "", del: "3", alg: ""), HelpCell(sq: 38, ans: "", del: "3", alg: ""), HelpCell(sq: 39, ans: "", del: "3", alg: ""), HelpCell(sq: 40, ans: "", del: "3", alg: ""), HelpCell(sq: 41, ans: "", del: "3", alg: ""), HelpCell(sq: 42, ans: "", del: "3", alg: ""), HelpCell(sq: 43, ans: "3", del: "", alg: ""), HelpCell(sq: 44, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 42, e: "1"), hhCells: [HelpCell(sq: 36, ans: "", del: "1", alg: ""), HelpCell(sq: 37, ans: "", del: "1", alg: ""), HelpCell(sq: 38, ans: "", del: "1", alg: ""), HelpCell(sq: 39, ans: "", del: "1", alg: ""), HelpCell(sq: 40, ans: "", del: "1", alg: ""), HelpCell(sq: 41, ans: "", del: "1", alg: ""), HelpCell(sq: 42, ans: "1", del: "", alg: ""), HelpCell(sq: 43, ans: "", del: "1", alg: ""), HelpCell(sq: 44, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 61, e: "1"), hhCells: [HelpCell(sq: 7, ans: "", del: "1", alg: ""), HelpCell(sq: 16, ans: "", del: "1", alg: ""), HelpCell(sq: 25, ans: "", del: "1", alg: ""), HelpCell(sq: 34, ans: "", del: "1", alg: ""), HelpCell(sq: 43, ans: "", del: "1", alg: ""), HelpCell(sq: 52, ans: "", del: "1", alg: ""), HelpCell(sq: 61, ans: "1", del: "", alg: ""), HelpCell(sq: 70, ans: "", del: "1", alg: ""), HelpCell(sq: 79, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 45, e: "1"), hhCells: [HelpCell(sq: 0, ans: "", del: "1", alg: ""), HelpCell(sq: 9, ans: "", del: "1", alg: ""), HelpCell(sq: 18, ans: "", del: "1", alg: ""), HelpCell(sq: 27, ans: "", del: "1", alg: ""), HelpCell(sq: 36, ans: "", del: "1", alg: ""), HelpCell(sq: 45, ans: "1", del: "", alg: ""), HelpCell(sq: 54, ans: "", del: "1", alg: ""), HelpCell(sq: 63, ans: "", del: "1", alg: ""), HelpCell(sq: 72, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 64, e: "1"), hhCells: [HelpCell(sq: 63, ans: "", del: "1", alg: ""), HelpCell(sq: 64, ans: "1", del: "", alg: ""), HelpCell(sq: 65, ans: "", del: "1", alg: ""), HelpCell(sq: 66, ans: "", del: "1", alg: ""), HelpCell(sq: 67, ans: "", del: "1", alg: ""), HelpCell(sq: 68, ans: "", del: "1", alg: ""), HelpCell(sq: 69, ans: "", del: "1", alg: ""), HelpCell(sq: 70, ans: "", del: "1", alg: ""), HelpCell(sq: 71, ans: "", del: "1", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 65, e: "4"), hhCells: [HelpCell(sq: 63, ans: "", del: "4", alg: ""), HelpCell(sq: 64, ans: "", del: "4", alg: ""), HelpCell(sq: 65, ans: "4", del: "", alg: ""), HelpCell(sq: 66, ans: "", del: "4", alg: ""), HelpCell(sq: 67, ans: "", del: "4", alg: ""), HelpCell(sq: 68, ans: "", del: "4", alg: ""), HelpCell(sq: 69, ans: "", del: "4", alg: ""), HelpCell(sq: 70, ans: "", del: "4", alg: ""), HelpCell(sq: 71, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 13, e: "4"), hhCells: [HelpCell(sq: 9, ans: "", del: "4", alg: ""), HelpCell(sq: 10, ans: "", del: "4", alg: ""), HelpCell(sq: 11, ans: "", del: "4", alg: ""), HelpCell(sq: 12, ans: "", del: "4", alg: ""), HelpCell(sq: 13, ans: "4", del: "", alg: ""), HelpCell(sq: 14, ans: "", del: "4", alg: ""), HelpCell(sq: 15, ans: "", del: "4", alg: ""), HelpCell(sq: 16, ans: "", del: "4", alg: ""), HelpCell(sq: 17, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 75, e: "4"), hhCells: [HelpCell(sq: 3, ans: "", del: "4", alg: ""), HelpCell(sq: 12, ans: "", del: "4", alg: ""), HelpCell(sq: 21, ans: "", del: "4", alg: ""), HelpCell(sq: 30, ans: "", del: "4", alg: ""), HelpCell(sq: 39, ans: "", del: "4", alg: ""), HelpCell(sq: 48, ans: "", del: "4", alg: ""), HelpCell(sq: 57, ans: "", del: "4", alg: ""), HelpCell(sq: 66, ans: "", del: "4", alg: ""), HelpCell(sq: 75, ans: "4", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 41, e: "4"), hhCells: [HelpCell(sq: 5, ans: "", del: "4", alg: ""), HelpCell(sq: 14, ans: "", del: "4", alg: ""), HelpCell(sq: 23, ans: "", del: "4", alg: ""), HelpCell(sq: 32, ans: "", del: "4", alg: ""), HelpCell(sq: 41, ans: "4", del: "", alg: ""), HelpCell(sq: 50, ans: "", del: "4", alg: ""), HelpCell(sq: 59, ans: "", del: "4", alg: ""), HelpCell(sq: 68, ans: "", del: "4", alg: ""), HelpCell(sq: 77, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 77, e: "7"), hhCells: [HelpCell(sq: 5, ans: "", del: "7", alg: ""), HelpCell(sq: 14, ans: "", del: "7", alg: ""), HelpCell(sq: 23, ans: "", del: "7", alg: ""), HelpCell(sq: 32, ans: "", del: "7", alg: ""), HelpCell(sq: 41, ans: "", del: "7", alg: ""), HelpCell(sq: 50, ans: "", del: "7", alg: ""), HelpCell(sq: 59, ans: "", del: "7", alg: ""), HelpCell(sq: 68, ans: "", del: "7", alg: ""), HelpCell(sq: 77, ans: "7", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 58, e: "8"), hhCells: [HelpCell(sq: 57, ans: "", del: "8", alg: ""), HelpCell(sq: 58, ans: "8", del: "", alg: ""), HelpCell(sq: 59, ans: "", del: "8", alg: ""), HelpCell(sq: 66, ans: "", del: "8", alg: ""), HelpCell(sq: 67, ans: "", del: "8", alg: ""), HelpCell(sq: 68, ans: "", del: "8", alg: ""), HelpCell(sq: 75, ans: "", del: "8", alg: ""), HelpCell(sq: 76, ans: "", del: "8", alg: ""), HelpCell(sq: 77, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 62, e: "4"), hhCells: [HelpCell(sq: 54, ans: "", del: "4", alg: ""), HelpCell(sq: 55, ans: "", del: "4", alg: ""), HelpCell(sq: 56, ans: "", del: "4", alg: ""), HelpCell(sq: 57, ans: "", del: "4", alg: ""), HelpCell(sq: 58, ans: "", del: "4", alg: ""), HelpCell(sq: 59, ans: "", del: "4", alg: ""), HelpCell(sq: 60, ans: "", del: "4", alg: ""), HelpCell(sq: 61, ans: "", del: "4", alg: ""), HelpCell(sq: 62, ans: "4", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 69, e: "7"), hhCells: [HelpCell(sq: 60, ans: "", del: "7", alg: ""), HelpCell(sq: 61, ans: "", del: "7", alg: ""), HelpCell(sq: 62, ans: "", del: "7", alg: ""), HelpCell(sq: 69, ans: "7", del: "", alg: ""), HelpCell(sq: 70, ans: "", del: "7", alg: ""), HelpCell(sq: 71, ans: "", del: "7", alg: ""), HelpCell(sq: 78, ans: "", del: "7", alg: ""), HelpCell(sq: 79, ans: "", del: "7", alg: ""), HelpCell(sq: 80, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 15, e: "8"), hhCells: [HelpCell(sq: 6, ans: "", del: "8", alg: ""), HelpCell(sq: 15, ans: "8", del: "", alg: ""), HelpCell(sq: 24, ans: "", del: "8", alg: ""), HelpCell(sq: 33, ans: "", del: "8", alg: ""), HelpCell(sq: 42, ans: "", del: "8", alg: ""), HelpCell(sq: 51, ans: "", del: "8", alg: ""), HelpCell(sq: 60, ans: "", del: "8", alg: ""), HelpCell(sq: 69, ans: "", del: "8", alg: ""), HelpCell(sq: 78, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 11, e: "7"), hhCells: [HelpCell(sq: 9, ans: "", del: "7", alg: ""), HelpCell(sq: 10, ans: "", del: "7", alg: ""), HelpCell(sq: 11, ans: "7", del: "", alg: ""), HelpCell(sq: 12, ans: "", del: "7", alg: ""), HelpCell(sq: 13, ans: "", del: "7", alg: ""), HelpCell(sq: 14, ans: "", del: "7", alg: ""), HelpCell(sq: 15, ans: "", del: "7", alg: ""), HelpCell(sq: 16, ans: "", del: "7", alg: ""), HelpCell(sq: 17, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 38, e: "9"), hhCells: [HelpCell(sq: 2, ans: "", del: "9", alg: ""), HelpCell(sq: 11, ans: "", del: "9", alg: ""), HelpCell(sq: 20, ans: "", del: "9", alg: ""), HelpCell(sq: 29, ans: "", del: "9", alg: ""), HelpCell(sq: 38, ans: "9", del: "", alg: ""), HelpCell(sq: 47, ans: "", del: "9", alg: ""), HelpCell(sq: 56, ans: "", del: "9", alg: ""), HelpCell(sq: 65, ans: "", del: "9", alg: ""), HelpCell(sq: 74, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 79, e: "8"), hhCells: [HelpCell(sq: 60, ans: "", del: "8", alg: ""), HelpCell(sq: 61, ans: "", del: "8", alg: ""), HelpCell(sq: 62, ans: "", del: "8", alg: ""), HelpCell(sq: 69, ans: "", del: "8", alg: ""), HelpCell(sq: 70, ans: "", del: "8", alg: ""), HelpCell(sq: 71, ans: "", del: "8", alg: ""), HelpCell(sq: 78, ans: "", del: "8", alg: ""), HelpCell(sq: 79, ans: "8", del: "", alg: ""), HelpCell(sq: 80, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 73, e: "9"), hhCells: [HelpCell(sq: 72, ans: "", del: "9", alg: ""), HelpCell(sq: 73, ans: "9", del: "", alg: ""), HelpCell(sq: 74, ans: "", del: "9", alg: ""), HelpCell(sq: 75, ans: "", del: "9", alg: ""), HelpCell(sq: 76, ans: "", del: "9", alg: ""), HelpCell(sq: 77, ans: "", del: "9", alg: ""), HelpCell(sq: 78, ans: "", del: "9", alg: ""), HelpCell(sq: 79, ans: "", del: "9", alg: ""), HelpCell(sq: 80, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 3, e: "9"), hhCells: [HelpCell(sq: 3, ans: "9", del: "", alg: ""), HelpCell(sq: 12, ans: "", del: "9", alg: ""), HelpCell(sq: 21, ans: "", del: "9", alg: ""), HelpCell(sq: 30, ans: "", del: "9", alg: ""), HelpCell(sq: 39, ans: "", del: "9", alg: ""), HelpCell(sq: 48, ans: "", del: "9", alg: ""), HelpCell(sq: 57, ans: "", del: "9", alg: ""), HelpCell(sq: 66, ans: "", del: "9", alg: ""), HelpCell(sq: 75, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 35, e: "6"), hhCells: [HelpCell(sq: 27, ans: "", del: "6", alg: ""), HelpCell(sq: 28, ans: "", del: "6", alg: ""), HelpCell(sq: 29, ans: "", del: "6", alg: ""), HelpCell(sq: 30, ans: "", del: "6", alg: ""), HelpCell(sq: 31, ans: "", del: "6", alg: ""), HelpCell(sq: 32, ans: "", del: "6", alg: ""), HelpCell(sq: 33, ans: "", del: "6", alg: ""), HelpCell(sq: 34, ans: "", del: "6", alg: ""), HelpCell(sq: 35, ans: "6", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 22, e: "7"), hhCells: [HelpCell(sq: 4, ans: "", del: "7", alg: ""), HelpCell(sq: 13, ans: "", del: "7", alg: ""), HelpCell(sq: 22, ans: "7", del: "", alg: ""), HelpCell(sq: 31, ans: "", del: "7", alg: ""), HelpCell(sq: 40, ans: "", del: "7", alg: ""), HelpCell(sq: 49, ans: "", del: "7", alg: ""), HelpCell(sq: 58, ans: "", del: "7", alg: ""), HelpCell(sq: 67, ans: "", del: "7", alg: ""), HelpCell(sq: 76, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 25, e: "9"), hhCells: [HelpCell(sq: 18, ans: "", del: "9", alg: ""), HelpCell(sq: 19, ans: "", del: "9", alg: ""), HelpCell(sq: 20, ans: "", del: "9", alg: ""), HelpCell(sq: 21, ans: "", del: "9", alg: ""), HelpCell(sq: 22, ans: "", del: "9", alg: ""), HelpCell(sq: 23, ans: "", del: "9", alg: ""), HelpCell(sq: 24, ans: "", del: "9", alg: ""), HelpCell(sq: 25, ans: "9", del: "", alg: ""), HelpCell(sq: 26, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 26, e: "3"), hhCells: [HelpCell(sq: 18, ans: "", del: "3", alg: ""), HelpCell(sq: 19, ans: "", del: "3", alg: ""), HelpCell(sq: 20, ans: "", del: "3", alg: ""), HelpCell(sq: 21, ans: "", del: "3", alg: ""), HelpCell(sq: 22, ans: "", del: "3", alg: ""), HelpCell(sq: 23, ans: "", del: "3", alg: ""), HelpCell(sq: 24, ans: "", del: "3", alg: ""), HelpCell(sq: 25, ans: "", del: "3", alg: ""), HelpCell(sq: 26, ans: "3", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 49, e: "9"), hhCells: [HelpCell(sq: 45, ans: "", del: "9", alg: ""), HelpCell(sq: 46, ans: "", del: "9", alg: ""), HelpCell(sq: 47, ans: "", del: "9", alg: ""), HelpCell(sq: 48, ans: "", del: "9", alg: ""), HelpCell(sq: 49, ans: "9", del: "", alg: ""), HelpCell(sq: 50, ans: "", del: "9", alg: ""), HelpCell(sq: 51, ans: "", del: "9", alg: ""), HelpCell(sq: 52, ans: "", del: "9", alg: ""), HelpCell(sq: 53, ans: "", del: "9", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 31, e: "3"), hhCells: [HelpCell(sq: 4, ans: "", del: "3", alg: ""), HelpCell(sq: 13, ans: "", del: "3", alg: ""), HelpCell(sq: 22, ans: "", del: "3", alg: ""), HelpCell(sq: 31, ans: "3", del: "", alg: ""), HelpCell(sq: 40, ans: "", del: "3", alg: ""), HelpCell(sq: 49, ans: "", del: "3", alg: ""), HelpCell(sq: 58, ans: "", del: "3", alg: ""), HelpCell(sq: 67, ans: "", del: "3", alg: ""), HelpCell(sq: 76, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 54, e: "3"), hhCells: [HelpCell(sq: 0, ans: "", del: "3", alg: ""), HelpCell(sq: 9, ans: "", del: "3", alg: ""), HelpCell(sq: 18, ans: "", del: "3", alg: ""), HelpCell(sq: 27, ans: "", del: "3", alg: ""), HelpCell(sq: 36, ans: "", del: "3", alg: ""), HelpCell(sq: 45, ans: "", del: "3", alg: ""), HelpCell(sq: 54, ans: "3", del: "", alg: ""), HelpCell(sq: 63, ans: "", del: "3", alg: ""), HelpCell(sq: 72, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 55, e: "7"), hhCells: [HelpCell(sq: 54, ans: "", del: "7", alg: ""), HelpCell(sq: 55, ans: "7", del: "", alg: ""), HelpCell(sq: 56, ans: "", del: "7", alg: ""), HelpCell(sq: 57, ans: "", del: "7", alg: ""), HelpCell(sq: 58, ans: "", del: "7", alg: ""), HelpCell(sq: 59, ans: "", del: "7", alg: ""), HelpCell(sq: 60, ans: "", del: "7", alg: ""), HelpCell(sq: 61, ans: "", del: "7", alg: ""), HelpCell(sq: 62, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 46, e: "3"), hhCells: [HelpCell(sq: 1, ans: "", del: "3", alg: ""), HelpCell(sq: 10, ans: "", del: "3", alg: ""), HelpCell(sq: 19, ans: "", del: "3", alg: ""), HelpCell(sq: 28, ans: "", del: "3", alg: ""), HelpCell(sq: 37, ans: "", del: "3", alg: ""), HelpCell(sq: 46, ans: "3", del: "", alg: ""), HelpCell(sq: 55, ans: "", del: "3", alg: ""), HelpCell(sq: 64, ans: "", del: "3", alg: ""), HelpCell(sq: 73, ans: "", del: "3", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 52, e: "4"), hhCells: [HelpCell(sq: 45, ans: "", del: "4", alg: ""), HelpCell(sq: 46, ans: "", del: "4", alg: ""), HelpCell(sq: 47, ans: "", del: "4", alg: ""), HelpCell(sq: 48, ans: "", del: "4", alg: ""), HelpCell(sq: 49, ans: "", del: "4", alg: ""), HelpCell(sq: 50, ans: "", del: "4", alg: ""), HelpCell(sq: 51, ans: "", del: "4", alg: ""), HelpCell(sq: 52, ans: "4", del: "", alg: ""), HelpCell(sq: 53, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 53, e: "5"), hhCells: [HelpCell(sq: 45, ans: "", del: "5", alg: ""), HelpCell(sq: 46, ans: "", del: "5", alg: ""), HelpCell(sq: 47, ans: "", del: "5", alg: ""), HelpCell(sq: 48, ans: "", del: "5", alg: ""), HelpCell(sq: 49, ans: "", del: "5", alg: ""), HelpCell(sq: 50, ans: "", del: "5", alg: ""), HelpCell(sq: 51, ans: "", del: "5", alg: ""), HelpCell(sq: 52, ans: "", del: "5", alg: ""), HelpCell(sq: 53, ans: "5", del: "", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 8, e: "7"), hhCells: [HelpCell(sq: 8, ans: "7", del: "", alg: ""), HelpCell(sq: 17, ans: "", del: "7", alg: ""), HelpCell(sq: 26, ans: "", del: "7", alg: ""), HelpCell(sq: 35, ans: "", del: "7", alg: ""), HelpCell(sq: 44, ans: "", del: "7", alg: ""), HelpCell(sq: 53, ans: "", del: "7", alg: ""), HelpCell(sq: 62, ans: "", del: "7", alg: ""), HelpCell(sq: 71, ans: "", del: "7", alg: ""), HelpCell(sq: 80, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 7, e: "5"), hhCells: [HelpCell(sq: 6, ans: "", del: "5", alg: ""), HelpCell(sq: 7, ans: "5", del: "", alg: ""), HelpCell(sq: 8, ans: "", del: "5", alg: ""), HelpCell(sq: 15, ans: "", del: "5", alg: ""), HelpCell(sq: 16, ans: "", del: "5", alg: ""), HelpCell(sq: 17, ans: "", del: "5", alg: ""), HelpCell(sq: 24, ans: "", del: "5", alg: ""), HelpCell(sq: 25, ans: "", del: "5", alg: ""), HelpCell(sq: 26, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 27, e: "5"), hhCells: [HelpCell(sq: 0, ans: "", del: "5", alg: ""), HelpCell(sq: 9, ans: "", del: "5", alg: ""), HelpCell(sq: 18, ans: "", del: "5", alg: ""), HelpCell(sq: 27, ans: "5", del: "", alg: ""), HelpCell(sq: 36, ans: "", del: "5", alg: ""), HelpCell(sq: 45, ans: "", del: "5", alg: ""), HelpCell(sq: 54, ans: "", del: "5", alg: ""), HelpCell(sq: 63, ans: "", del: "5", alg: ""), HelpCell(sq: 72, ans: "", del: "5", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 0, e: "4"), hhCells: [HelpCell(sq: 0, ans: "4", del: "", alg: ""), HelpCell(sq: 9, ans: "", del: "4", alg: ""), HelpCell(sq: 18, ans: "", del: "4", alg: ""), HelpCell(sq: 27, ans: "", del: "4", alg: ""), HelpCell(sq: 36, ans: "", del: "4", alg: ""), HelpCell(sq: 45, ans: "", del: "4", alg: ""), HelpCell(sq: 54, ans: "", del: "4", alg: ""), HelpCell(sq: 63, ans: "", del: "4", alg: ""), HelpCell(sq: 72, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 28, e: "4"), hhCells: [HelpCell(sq: 1, ans: "", del: "4", alg: ""), HelpCell(sq: 10, ans: "", del: "4", alg: ""), HelpCell(sq: 19, ans: "", del: "4", alg: ""), HelpCell(sq: 28, ans: "4", del: "", alg: ""), HelpCell(sq: 37, ans: "", del: "4", alg: ""), HelpCell(sq: 46, ans: "", del: "4", alg: ""), HelpCell(sq: 55, ans: "", del: "4", alg: ""), HelpCell(sq: 64, ans: "", del: "4", alg: ""), HelpCell(sq: 73, ans: "", del: "4", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 34, e: "7"), hhCells: [HelpCell(sq: 27, ans: "", del: "7", alg: ""), HelpCell(sq: 28, ans: "", del: "7", alg: ""), HelpCell(sq: 29, ans: "", del: "7", alg: ""), HelpCell(sq: 30, ans: "", del: "7", alg: ""), HelpCell(sq: 31, ans: "", del: "7", alg: ""), HelpCell(sq: 32, ans: "", del: "7", alg: ""), HelpCell(sq: 33, ans: "", del: "7", alg: ""), HelpCell(sq: 34, ans: "7", del: "", alg: ""), HelpCell(sq: 35, ans: "", del: "7", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 1, e: "8"), hhCells: [HelpCell(sq: 0, ans: "", del: "8", alg: ""), HelpCell(sq: 1, ans: "8", del: "", alg: ""), HelpCell(sq: 2, ans: "", del: "8", alg: ""), HelpCell(sq: 3, ans: "", del: "8", alg: ""), HelpCell(sq: 4, ans: "", del: "8", alg: ""), HelpCell(sq: 5, ans: "", del: "8", alg: ""), HelpCell(sq: 6, ans: "", del: "8", alg: ""), HelpCell(sq: 7, ans: "", del: "8", alg: ""), HelpCell(sq: 8, ans: "", del: "8", alg: "")], aAlgo: "One Rule"), AlgoAssigns(aCell: Cell(i: 19, e: "5"), hhCells: [HelpCell(sq: 18, ans: "", del: "5", alg: ""), HelpCell(sq: 19, ans: "5", del: "", alg: ""), HelpCell(sq: 20, ans: "", del: "5", alg: ""), HelpCell(sq: 21, ans: "", del: "5", alg: ""), HelpCell(sq: 22, ans: "", del: "5", alg: ""), HelpCell(sq: 23, ans: "", del: "5", alg: ""), HelpCell(sq: 24, ans: "", del: "5", alg: ""), HelpCell(sq: 25, ans: "", del: "5", alg: ""), HelpCell(sq: 26, ans: "", del: "5", alg: "")], aAlgo: "One Rule")]
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = easyPuzzle
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, nil, nil)
        
        //        print("testAlgoAssignsByCP: easy puzzle = ")
        //        printPuzzle(algoResults.playerAnswered)
        
        print("testAlgoAssignsByCP: solved units count = \(algoResults.solvedUnits.count)")
        print("testAlgoAssignsByCP: solved units = \(algoResults.solvedUnits)")
        
        XCTAssertEqual(easyPuzzleSolution, Artn.strategy.pzzlSet.playerAnswered, "testAlgoAssignsByCP: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testAlgoAssignsByCP: Solved puzzle state is solved!")
        
        print("\n\n testAlgoAssignsByCP: Artn.strategy.cpAssigns!.count = \(Artn.strategy.cpAssigns.count), cpAssigns.count = \(cpAssigns.count)")
//        print(Artn.strategy.cpAssigns)
//        print("\n\n")
        XCTAssertEqual(cpAssigns, Artn.strategy.cpAssigns, "testAlgoAssignsByCP: puzzle CP cpAssigns as expected!")
        if Artn.strategy.algoAssigns != nil {
            print("\n\n testAlgoAssignsByCP: cpAssignAlgo.count = \(cpAssignAlgo.count), Artn.strategy.algoAssigns!.count = \(Artn.strategy.algoAssigns!.count)")
            //            for anAssign in Artn.strategy.algoAssigns! {
            //                anAssign.printIt()
            //            }
            //print(Artn.strategy.algoAssigns!)
            //print("\n\n")
            XCTAssertEqual(cpAssignAlgo, Artn.strategy.algoAssigns!, "testAlgoAssignsByCP: puzzle CP cpAssigns as expected!")
        } else {
            XCTAssertEqual(0, 1, "testAlgoAssignsByTuples: puzzle Tuples algoAssigns is nil!")
        }
        
    }
    
    func testAlgoAssignsByTuples() {
        
        // The Arto puzzle (Arto 22 givens, 9 values) can not be solved with constraint propagation.
        //  But the resulting puzzle from constraint propagation has a naked pair of [3,6] and hidden pairs of [5,3] and [8,3].
        //  The puzzle can then be reduced as a result of the subsequent elimination digits, as determined by tuples, and ultimately be solved by constraint propagation.
        var ArtoPuzzle = PzlSet()
        
        // Following Hard puzzle (Arto 22 givens, 9 values) can not be solved with constraint propagation
        ArtoPuzzle.playerAnswered =
            ["8", "5", "", "", "", "2", "4", "", "",
             "7", "2", "", "", "", "", "", "", "9",
             "", "", "4", "", "", "", "", "", "",
             "", "", "", "1", "", "7", "", "", "2",
             "3", "", "5", "", "", "", "9", "", "",
             "", "4", "", "", "", "", "", "", "",
             "", "", "", "", "8", "", "", "7", "",
             "", "1", "7", "", "", "", "", "", "",
             "", "", "", "", "3", "6", "", "4", ""]
        let ArtoPuzzleCPSolution =
            ["8", "5", "1369", "36", "1679", "2", "4", "36", "1367",
             "7", "2", "136", "34568", "156", "345", "13568", "3568", "9",
             "169", "369", "4", "3568", "15679", "359", "135678", "2", "135678",
             "69", "689", "689", "1", "4", "7", "3568", "3568", "2",
             "3", "7", "5", "26", "26", "8", "9", "1", "4",
             "1269", "4", "12689", "2356", "2569", "359", "35678", "3568", "35678",
             "4", "36", "236", "9", "8", "1", "2356", "7", "356",
             "256", "1", "7", "245", "25", "45", "23568", "9", "3568",
             "259", "89", "289", "7", "3", "6", "1258", "4", "158"]
        let ArtoPuzzleTuplesSolution =
            ["8", "5", "9", "6", "1", "2", "4", "3", "7",
             "7", "2", "3", "8", "5", "4", "1", "6", "9",
             "1", "6", "4", "3", "7", "9", "5", "2", "8",
             "9", "8", "6", "1", "4", "7", "3", "5", "2",
             "3", "7", "5", "2", "6", "8", "9", "1", "4",
             "2", "4", "1", "5", "9", "3", "7", "8", "6",
             "4", "3", "2", "9", "8", "1", "6", "7", "5",
             "6", "1", "7", "4", "2", "5", "8", "9", "3",
             "5", "9", "8", "7", "3", "6", "2", "4", "1"]
        let units = [63,64,65,66,67,68,69,70,71]
        var highlightCells = [Cell]()
        for unit in units { highlightCells.append(Cell(i: unit, e: "38")) }
        let firstTuplesAssignAlgo = AlgoAssigns(aCell: Cell(i: 63, e: "6"), hhCells: [HelpCell(sq: 63, ans: "6", del: "", alg: ""), HelpCell(sq: 64, ans: "", del: "", alg: ""), HelpCell(sq: 65, ans: "", del: "", alg: ""), HelpCell(sq: 66, ans: "", del: "", alg: ""), HelpCell(sq: 67, ans: "", del: "", alg: ""), HelpCell(sq: 68, ans: "", del: "", alg: ""), HelpCell(sq: 69, ans: "", del: "1245679", alg: "38"), HelpCell(sq: 70, ans: "", del: "", alg: ""), HelpCell(sq: 71, ans: "", del: "1245679", alg: "38")], aAlgo: "Hidden Pair")
        
        //print("testAlgoAssignsByTuples: Arto puzzle = ")
        //printPuzzle(ArtoPuzzle.playerAnswered)
        
        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(ArtoPuzzle, DFGoal.proper, nil)
        //print("testAlgoAssignsByTuples: Arto puzzle results from constraint propagation = ")
        //printPuzzle(algoResults.playerAnswered)
        XCTAssertEqual(ArtoPuzzleCPSolution, algoResults.playerAnswered, "testAlgoAssignsByTuples: puzzle solution as expected!")
        
        Artn = Solution(strategy: Tuples())
        algoResults = Artn.strategy.tryAlgo(algoResults, DFGoal.proper, nil)
        //print("testAlgoAssignsByTuples: Arto puzzle results from Tuples = ")
        //printPuzzle(algoResults.playerAnswered)
        XCTAssertEqual(ArtoPuzzleTuplesSolution, Artn.strategy.pzzlSet.playerAnswered, "testAlgoAssignsByTuples: Arto puzzle NOT solved!")
        
        if Artn.strategy.algoAssigns != nil {
            let firstAssign = Artn.strategy.algoAssigns?.first
            //print("testAlgoAssignsByTuples: first algoAssigns from Tuples = ")
            //print(firstAssign!)
            //            for anAssign in Artn.strategy.algoAssigns! { anAssign.printIt() }
            XCTAssertEqual(firstTuplesAssignAlgo, firstAssign, "testAlgoAssignsByTuples: puzzle algoAssigns NOT as expected!")
        } else {
            XCTAssertEqual(0, 1, "testAlgoAssignsByTuples: puzzle Tuples algoAssigns is nil!")
        }
        
    }
    
    func testAlgoAssignsByUR() {
        
        var type1URPuzzle = PzlSet()
        
        // Following puzzle (26 givens, 8 values) requires eliminating the two values of the deadly pattern to solve
        let deadlyPatternGivenPuzzle =
            ["", "", "", "", "1", "9", "", "4", "",
             "", "5", "", "", "", "", "", "8", "",
             "", "", "", "", "", "", "", "", "",
             "3", "2", "", "4", "8", "", "", "", "5",
             "", "", "4", "9", "", "5", "7", "3", "",
             "", "9", "", "7", "", "1", "4", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "3", "1", "", "", "", "", "7", "2",
             "2", "", "", "5", "", "", "", "9", ""]
        let deadlyPatternCPResultsPuzzle =
            ["678", "678", "2368", "236", "1", "9", "5", "4", "37",
             "169", "5", "2369", "236", "4", "7", "123", "8", "139",
             "1479", "147", "239", "23", "5", "8", "123", "6", "1379",
             "3", "2", "7", "4", "8", "6", "9", "1", "5",
             "168", "168", "4", "9", "2", "5", "7", "3", "68",
             "68", "9", "5", "7", "3", "1", "4", "2", "68",
             "46789", "4678", "689", "1", "67", "2", "38", "5", "348",
             "5", "3", "1", "8", "9", "4", "6", "7", "2",
             "2", "4678", "68", "5", "67", "3", "18", "9", "148"]
        let deadlyPatternTuplesResultsPuzzle =
            ["678", "678", "2368", "236", "1", "9", "5", "4", "37",
             "169", "5", "2369", "236", "4", "7", "123", "8", "139",
             "1479", "147", "239", "23", "5", "8", "123", "6", "1379",
             "3", "2", "7", "4", "8", "6", "9", "1", "5",
             "168", "168", "4", "9", "2", "5", "7", "3", "68",
             "68", "9", "5", "7", "3", "1", "4", "2", "68",
             "46789", "4678", "689", "1", "67", "2", "38", "5", "34",
             "5", "3", "1", "8", "9", "4", "6", "7", "2",
             "2", "4678", "68", "5", "67", "3", "18", "9", "14"]
        let deadlyPatternTuplesEliminates =
            ["", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "8",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "8"]
        let deadlyPatternUniqueRectanglesResultsPuzzle =
            ["7", "8", "2", "6", "1", "9", "5", "4", "3",
             "6", "5", "3", "2", "4", "7", "1", "8", "9",
             "4", "1", "9", "3", "5", "8", "2", "6", "7",
             "3", "2", "7", "4", "8", "6", "9", "1", "5",
             "1", "6", "4", "9", "2", "5", "7", "3", "8",
             "8", "9", "5", "7", "3", "1", "4", "2", "6",
             "9", "7", "8", "1", "6", "2", "3", "5", "4",
             "5", "3", "1", "8", "9", "4", "6", "7", "2",
             "2", "4", "6", "5", "7", "3", "8", "9", "1"]
        let deadlyPatternUniqueRectanglesEliminates =
            ["", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "68", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", ""]
        let deadlyPatternAllPairsResults = [Cell(i: 45, e: "68"), Cell(i: 53, e: "68"), Cell(i: 58, e: "67"), Cell(i: 76, e: "67"), Cell(i: 44, e: "68")]
        let deadlyPatternCPassigns = [Cell(i: 6, e: "5"), Cell(i: 13, e: "4"), Cell(i: 14, e: "7"), Cell(i: 22, e: "5"), Cell(i: 23, e: "8"), Cell(i: 25, e: "6"), Cell(i: 29, e: "7"), Cell(i: 32, e: "6"), Cell(i: 33, e: "9"), Cell(i: 34, e: "1"), Cell(i: 40, e: "2"), Cell(i: 47, e: "5"), Cell(i: 49, e: "3"), Cell(i: 52, e: "2"), Cell(i: 57, e: "1"), Cell(i: 59, e: "2"), Cell(i: 61, e: "5"), Cell(i: 63, e: "5"), Cell(i: 66, e: "8"), Cell(i: 67, e: "9"), Cell(i: 68, e: "4"), Cell(i: 69, e: "6"), Cell(i: 77, e: "3")]
        
        let deadlyPatternURassigns = [Cell(i: 36, e: "1"), Cell(i: 19, e: "1"), Cell(i: 18, e: "4"), Cell(i: 26, e: "7"), Cell(i: 8, e: "3"), Cell(i: 24, e: "2"), Cell(i: 15, e: "1"), Cell(i: 17, e: "9"), Cell(i: 9, e: "6"), Cell(i: 3, e: "6"), Cell(i: 2, e: "2"), Cell(i: 12, e: "2"), Cell(i: 21, e: "3"), Cell(i: 11, e: "3"), Cell(i: 45, e: "8"), Cell(i: 0, e: "7"), Cell(i: 1, e: "8"), Cell(i: 37, e: "6"), Cell(i: 44, e: "8"), Cell(i: 53, e: "6"), Cell(i: 54, e: "9"), Cell(i: 20, e: "9"), Cell(i: 80, e: "1"), Cell(i: 78, e: "8"), Cell(i: 60, e: "3"), Cell(i: 62, e: "4"), Cell(i: 55, e: "7"), Cell(i: 58, e: "6"), Cell(i: 56, e: "8"), Cell(i: 74, e: "6"), Cell(i: 76, e: "7"), Cell(i: 73, e: "4")]
        
        let deadlyPatternFirstURassignAlgo = AlgoAssigns(aCell: Cell(i: 36, e: "1"), hhCells: [HelpCell(sq: 45, ans: "", del: "", alg: "68"), HelpCell(sq: 53, ans: "", del: "", alg: "68"), HelpCell(sq: 44, ans: "", del: "", alg: "68"), HelpCell(sq: 36, ans: "1", del: "68", alg: "")], aAlgo: "Deadly Pattern")
        
        type1URPuzzle.given = deadlyPatternGivenPuzzle
        type1URPuzzle.playerAnswered = deadlyPatternGivenPuzzle
        
//        print("testAlgoAssignsByUR: given puzzle = ")
//        printPuzzle(type1URPuzzle.given)
        
        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(type1URPuzzle, nil, nil)
        print("testAlgoAssignsByUR: DeadlyPattern puzzle results from constraint propagation = ")
        //printPuzzle(algoResults.playerAnswered)
        print("Artn.strategy.cpAssigns.count = \(Artn.strategy.cpAssigns.count)")
        let ArtnCpAssignsSorted = Artn.strategy.cpAssigns.sorted(by: {(cell1: Cell, cell2: Cell) -> Bool in return cell1.square < cell2.square })
        //print("Artn.strategy.cpAssigns = \(ArtnCpAssignsSorted)")
        if Artn.strategy.algoAssigns != nil {
            print("Artn.strategy.algoAssigns!.count = \(Artn.strategy.algoAssigns!.count)")
//            for anAssign in Artn.strategy.algoAssigns! {
//                anAssign.printIt()
//            }
        }
        XCTAssertEqual(deadlyPatternCPassigns, ArtnCpAssignsSorted, "testAlgoAssignsByUR: puzzle CP cpAssigns as expected!")
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternCPResultsPuzzle, type1URPuzzle.allCandidates, "testAlgoAssignsByUR: puzzle CP results as expected!")
        
        Artn = Solution(strategy: Tuples())
        algoResults = Artn.strategy.tryAlgo(algoResults, nil, nil)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        if !Artn.strategy.cpAssigns.isEmpty {
            print("testAlgoAssignsByUR: Artn.strategy.cpAssigns.count = \(Artn.strategy.cpAssigns.count)")
            XCTAssertEqual(0, 1, "testAlgoAssignsByUR: puzzle Tuples cpAssigns not empty as expected!")
        }
        XCTAssertEqual(deadlyPatternTuplesResultsPuzzle, type1URPuzzle.allCandidates, "testAlgoAssignsByUR: puzzle Tuples results as expected!")
        XCTAssertEqual(deadlyPatternTuplesEliminates, Artn.strategy.eliminates, "testAlgoAssignsByUR: puzzle Tuples Eliminates as expected!")
        XCTAssertEqual(deadlyPatternAllPairsResults.count, Artn.strategy.allPairs?.count, "testAlgoAssignsByUR: puzzle Tuples results as expected!")
        
        let tuplesAllPairs = Artn.strategy.allPairs
        Artn = Solution(strategy: UniqueRectangles())
        algoResults = Artn.strategy.tryAlgo(algoResults, nil, tuplesAllPairs)
        if Artn.strategy.algoAssigns != nil {
            let firstAssign = Artn.strategy.algoAssigns?.first
            print("testAlgoAssignsByUR: first DeadlyPattern puzzle algoAssigns from UniqueRectangles = ")
            //firstAssign?.printIt()
            //            for anAssign in Artn.strategy.algoAssigns! { anAssign.printIt() }
            XCTAssertEqual(deadlyPatternFirstURassignAlgo, firstAssign, "testAlgoAssignsByUR: puzzle UR algoAssigns as expected!")
        } else {
            XCTAssertEqual(0, 1, "testAlgoAssignsByUR: puzzle UR algoAssigns is nil!")
        }
        print("Artn.strategy.cpAssigns.count = \(Artn.strategy.cpAssigns.count), deadlyPatternURassigns.count = \(deadlyPatternURassigns.count)")
        //print("Artn.strategy.cpAssigns = \(Artn.strategy.cpAssigns)")
        XCTAssertEqual(deadlyPatternURassigns, Artn.strategy.cpAssigns, "testAlgoAssignsByUR: puzzle UR cpAssigns as expected!")
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternUniqueRectanglesResultsPuzzle, type1URPuzzle.allCandidates, "testAlgoAssignsByUR: puzzle UniqueRectangles results as expected!")
        XCTAssertEqual(deadlyPatternUniqueRectanglesEliminates, Artn.strategy.eliminates, "testAlgoAssignsByUR: puzzle UniqueRectangles Eliminates as expected!")
    }
    
    func testAlgoAssignsByDF() {
        
        // Following puzzle is the famous Sky TV puzzle competition with 1,905 solutions! It cannot be solved with constraint propagation (26 givens, 9 values)
        let SkyPuzzle =
            ["5","","6","","2","","9","","3",
             "","","8","","","","5","","",
             "","","","","","","","","",
             "6","","","2","8","5","","","9",
             "","","","9","","3","","","",
             "8","","","7","6","1","","","4",
             "","","","","","","","","",
             "","","4","","","","3","","",
             "2","","1","","5","","6","","7"]
        let firstDFassignAlgo = AlgoAssigns(aCell: Cell(i: 1, e: "1"), hhCells: [HelpCell(sq: 1, ans: "1", del: "7", alg: "")], aAlgo: "Depth First Guess")
        
        // First, reduce Sky puzzle by Contraint Propagation.  Otherwise, Depth First would run for a long time.
        var Ertn = PzlSet()
        Ertn.playerAnswered = SkyPuzzle
        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(Ertn, nil, nil)
        
        // Now set to the results from Constraint Propagation and run Depth First
        Ertn = algoResults
        Artn = Solution(strategy: DepthFirst())
        algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.help, nil)
        print("testAlgoAssignsByDF: DF uniqueSolutions.count = \(Artn.strategy.uniqueSolutions.count)")
        
        if Artn.strategy.algoAssigns != nil {
            let firstAssign = Artn.strategy.algoAssigns?.first
            print("testAlgoAssignsByDF: first algoAssigns from DF = ")
            print(firstAssign!)
            //firstAssign?.printIt()
            //            for anAssign in Artn.strategy.algoAssigns! { anAssign.printIt() }
            XCTAssertEqual(firstDFassignAlgo, firstAssign, "testAlgoAssignsByDF: puzzle DF algoAssigns NOT as expected!")
        } else {
            XCTAssertEqual(0, 1, "testAlgoAssignsByDF: puzzle DF algoAssigns is nil!")
        }
    }
    
    

}
