//
//  SudokuTests.swift
//  SudokuTests
//
//  Created by dave herbine on 3/25/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit
import XCTest

class SudokuTests: XCTestCase {

    
    let givenPuzzle =
    ["8", "5", "", "", "", "2", "4", "", "",
        "7", "2", "", "", "", "", "", "", "9",
        "", "", "4", "", "", "", "", "", "",
        "", "", "", "1", "", "7", "", "", "2",
        "3", "", "5", "", "", "", "9", "", "",
        "", "4", "", "", "", "", "", "", "",
        "", "", "", "", "8", "", "", "7", "",
        "", "1", "7", "", "", "", "", "", "",
        "", "", "", "", "3", "6", "", "4", ""]
    var playerCandidates =
    ["8", "5", "1369", "36", "1679", "2", "4", "136", "1367",
        "7", "2", "136", "34568", "156", "345", "13568", "13568", "9",
        "19", "369", "4", "3568", "15679", "359", "135678", "2", "135678",
        "29", "689", "2689", "1", "4", "7", "35", "35", "2",
        "3", "7", "5", "26", "26", "8", "9", "16", "4",
        "129", "4", "1269", "356", "3569", "359", "678", "68", "678",
        "245", "369", "2346", "9", "8", "1", "256", "7", "56",
        "6", "1", "7", "245", "25", "45", "38", "9", "38",
        "259", "89", "289", "7", "3", "6", "125", "4", "15"]
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
    let no6sPuzzle =
    ["8", "5", "", "", "", "2", "4", "", "",
        "7", "2", "", "", "", "", "", "", "9",
        "", "", "4", "", "", "", "", "", "",
        "", "", "", "1", "", "7", "", "", "2",
        "3", "", "5", "", "", "", "9", "", "",
        "", "4", "", "", "", "", "", "", "",
        "", "", "", "", "8", "", "", "7", "",
        "", "1", "7", "", "", "", "", "", "",
        "", "", "", "", "3", "", "", "4", ""]
    let onesAndNinesPuzzle =
    ["", "", "9", "", "1", "", "", "", "",
        "7", "2", "3", "8", "5", "4", "1", "6", "9",
        "1", "6", "4", "3", "7", "9", "5", "2", "8",
        "9", "8", "6", "1", "4", "7", "3", "5", "2",
        "3", "7", "5", "2", "6", "8", "9", "1", "4",
        "2", "4", "1", "5", "9", "3", "7", "8", "6",
        "4", "3", "2", "9", "8", "1", "6", "7", "5",
        "6", "1", "7", "4", "2", "5", "8", "9", "3",
        "5", "9", "8", "7", "3", "6", "2", "4", "1"]
    let zeroAndEightyIncorrectPuzzle =
    ["5", "5", "9", "6", "1", "2", "4", "3", "7",
        "7", "2", "3", "8", "5", "4", "1", "6", "9",
        "1", "6", "4", "3", "7", "9", "5", "2", "8",
        "9", "8", "6", "1", "4", "7", "3", "5", "2",
        "3", "7", "5", "2", "6", "8", "9", "1", "4",
        "2", "4", "1", "5", "9", "3", "7", "8", "6",
        "4", "3", "2", "9", "8", "1", "6", "7", "5",
        "6", "1", "7", "4", "2", "5", "8", "9", "3",
        "5", "9", "8", "7", "3", "6", "2", "4", "4"]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //uniquePuzzleSolutions = [[String]]()    // array of arrays
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFindAllCellsWith() {
        let sGame = Game(challenge: 4)
        var Ertn = [Int]()      // Populated for Expected return
        var Artn = [Int]()      // Populated with Actual return
        
        sGame.gamePuzzles.playerAnswered = playerCandidates
        Ertn = [2,4,7,8,11,13,15,16,18,22,24,26,30,43,45,47,59,64,78,80]
        Artn = sGame.findAllCellsWith("1")
        XCTAssertEqual(Ertn, Artn, "testFindAllCellsWith: found all cells as expected!")
        
        Ertn = [45,47,78]
        Artn = sGame.findAllCellsWith("12")
        XCTAssertEqual(Ertn, Artn, "testFindAllCellsWith: found all cells as expected!")
        
        sGame.gamePuzzles.playerAnswered = no6sPuzzle
        Ertn = []
        Artn = sGame.findAllCellsWith("6")
        XCTAssertEqual(Ertn, Artn, "testFindAllCellsWith: found no cells as expected!")
    }
    
    func testIsCellAnswered() {
        let sGame = Game(challenge: 4)
        var Ertn = true      // Populated for Expected return
        var Artn = true      // Populated with Actual return
        
        sGame.gamePuzzles.playerAnswered = givenPuzzle
        Ertn = true
        Artn = sGame.isCellAnswered(1)
        XCTAssertEqual(Ertn, Artn, "testIsCellAnswered: cell is answered as expected!")
        
        Ertn = false
        Artn = sGame.isCellAnswered(80)
        XCTAssertEqual(Ertn, Artn, "testIsCellAnswered: cell is answered as expected!")
        
        Ertn = true
        Artn = sGame.isCellAnswered(81)
        XCTAssertEqual(Ertn, Artn, "testIsCellAnswered: cell 81 doesn't exist so returned true as expected!")
    }

    func testGetSolvedDigits() {
        let sGame = Game(challenge: 4)
        var Ertn = ""      // Populated for Expected return
        var Artn = ""      // Populated with Actual return
        
        sGame.gamePuzzles.playerAnswered = solutionPuzzle
        Ertn = "123456789"
        Artn = sGame.getSolvedDigits()
        XCTAssertEqual(Ertn, Artn, "testGetSolvedDigits: digits answered as expected!")
        
        sGame.gamePuzzles.playerAnswered = givenPuzzle
        Ertn = ""
        Artn = sGame.getSolvedDigits()
        XCTAssertEqual(Ertn, Artn, "testGetSolvedDigits: digits.isEmpty as expected!")
        
        sGame.gamePuzzles.playerAnswered = onesAndNinesPuzzle
        Ertn = "19"
        Artn = sGame.getSolvedDigits()
        XCTAssertEqual(Ertn, Artn, "testGetSolvedDigits: digits answered as expected!")
    }
    
    func testGetLongestString() {
        var Ertn: String? = ""
        var stringArray = [String]()
        
        let ds = DSController()

        stringArray = ["Answer","Clear","Undo","Redo"]
        Ertn = "Answer"
        if let Artn = ds.getLongestString(stringArray) {
            XCTAssertEqual(Ertn!, Artn, "testGetLongestString: found the longest string as expected!")
        } else {
            assert(false, "testGetLongestString: FAILED to find the longest string as expected!")
        }
        
        stringArray = ["Answer","Answer","Answer","Answer"]
        Ertn = "Answer"
        if let Artn = ds.getLongestString(stringArray) {
            XCTAssertEqual(Ertn!, Artn, "testGetLongestString: found the longest string as expected!")
        } else {
            assert(false, "testGetLongestString: FAILED to find the longest string as expected!")
        }
        
        stringArray = ["Answer"]
        Ertn = "Answer"
        if let Artn = ds.getLongestString(stringArray) {
            XCTAssertEqual(Ertn!, Artn, "testGetLongestString: found the longest string as expected!")
        } else {
            assert(false, "testGetLongestString: FAILED to find the longest string as expected!")
        }
        
        stringArray = [""]
        Ertn = ""
        if let Artn = ds.getLongestString(stringArray) {
            XCTAssertEqual(Ertn!, Artn, "testGetLongestString: found the longest string as expected!")
        } else {
            assert(false, "testGetLongestString: FAILED to find the longest string as expected!")
        }
    }
    
    func testPuzzleLets() {
        let peersDictErtn = [1,2,3,4,5,6,7,8,9,10,11,18,19,20,27,36,45,54,63,72]
        if let peersDictArtn = PuzzleLets.globalVar.peersDict[0] {
            XCTAssertEqual(peersDictErtn, peersDictArtn, "testPuzzleLets: returned array as expected!")
        } else {
            print("testPuzzleLets: PuzzleLets.globalVar.peersDict[0] is nil!")
        }
    }
    
    func testRemoveAnswerAtIndexFromPeers() {
        let sGame = Game(challenge: 4)
        let playerPuzzle =
           ["8", "58", "1369", "36", "1679", "28", "48", "136", "1367",
            "78", "28", "136", "", "", "", "", "", "",
            "19", "369", "48", "", "", "", "", "", "",
            "29", "", "", "", "", "", "", "", "",
            "38", "", "", "", "", "", "", "", "",
            "129", "", "", "", "", "", "", "", "",
            "245", "", "", "", "", "", "", "", "",
            "68", "", "", "", "", "", "", "", "",
            "259", "", "", "", "", "", "", "", ""]
        let ErtnPuzzle =
        ["8", "5", "1369", "36", "1679", "2", "4", "136", "1367",
            "7", "2", "136", "", "", "", "", "", "",
            "19", "369", "4", "", "", "", "", "", "",
            "29", "", "", "", "", "", "", "", "",
            "3", "", "", "", "", "", "", "", "",
            "129", "", "", "", "", "", "", "", "",
            "245", "", "", "", "", "", "", "", "",
            "6", "", "", "", "", "", "", "", "",
            "259", "", "", "", "", "", "", "", ""]

        sGame.gamePuzzles.playerAnswered = playerPuzzle
        _ = sGame.removeAnswerAtIndexFromPeers(0)
        let ArtnPuzzle = sGame.gamePuzzles.playerAnswered   // playerPuzzle should be updated
        XCTAssertEqual(ErtnPuzzle, ArtnPuzzle, "testRemoveAnswerFromPeers: digits removed from peers as expected!")
        
    }
    
    func testCheckPuzzle() {
        var Ertn = PzlSet()
        Ertn.solution = solutionPuzzle
        Ertn.state = states.solved
        var Artn = PzlSet()
        Artn.playerAnswered = solutionPuzzle
        
        //sGame.puzzle.checkPuzzle(&Artn)
        _ = checkPuzzle(&Artn)
        XCTAssertEqual(Ertn.state, Artn.state, "testCheckPuzzle: result is .solved as expected!")
        
        Ertn.state = states.valid
        Artn.playerAnswered = playerCandidates
        Artn.solvedUnits = [Int]()
        _ = checkPuzzle(&Artn)
        XCTAssertEqual(Ertn.state, Artn.state, "testCheckPuzzle: result is .valid as expected!")

        Ertn.state = states.invalid
        Artn.playerAnswered = zeroAndEightyIncorrectPuzzle
        Artn.solvedUnits = [Int]()
        _ = checkPuzzle(&Artn)
        XCTAssertEqual(Ertn.state, Artn.state, "testCheckPuzzle: result is .invalid as expected!")
    }
    
    func testArtoPermutations() {
        var ArtoPuzzlePermutation = PzlSet()
        let sPzl = Puzzle()
        let runCount = 10
        
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
        ArtoPuzzle.state = .valid
        let ArtoPuzzleDFSolution =
            ["8", "5", "9", "6", "1", "2", "4", "3", "7",
             "7", "2", "3", "8", "5", "4", "1", "6", "9",
             "1", "6", "4", "3", "7", "9", "5", "2", "8",
             "9", "8", "6", "1", "4", "7", "3", "5", "2",
             "3", "7", "5", "2", "6", "8", "9", "1", "4",
             "2", "4", "1", "5", "9", "3", "7", "8", "6",
             "4", "3", "2", "9", "8", "1", "6", "7", "5",
             "6", "1", "7", "4", "2", "5", "8", "9", "3",
             "5", "9", "8", "7", "3", "6", "2", "4", "1"]
        var ArtoPuzzlePermutationSolution = ArtoPuzzleDFSolution
        
        for i in 0...runCount {
            print("testArtoPermutations: \(i)")
            (ArtoPuzzlePermutation.playerAnswered, ArtoPuzzlePermutationSolution) = sPzl.newPermutation(ArtoPuzzle.playerAnswered, solutionPuzzle: ArtoPuzzleDFSolution)
            
            var Artn = Solution(strategy: ConstraintPropagation())
            var algo = Artn.strategy.tryAlgo(ArtoPuzzlePermutation, DFGoal.proper, nil)
            
            Artn = Solution(strategy: Tuples())
            algo = Artn.strategy.tryAlgo(algo, DFGoal.proper, nil)
            
            XCTAssertEqual(ArtoPuzzlePermutationSolution, Artn.strategy.pzzlSet.playerAnswered, "testArtoPermutations: Arto's unique solution found!")
        }
        
    }
    
        
    func testCreatePuzzle() {
        var randomPuzzle = PzlSet()
        let sPzl = Puzzle()
        randomPuzzle.playerAnswered = sPzl.createPuzzle()
        
        var Artn = Solution(strategy: ConstraintPropagation())
        let algo = Artn.strategy.tryAlgo(randomPuzzle, DFGoal.proper, nil)

        Artn = Solution(strategy: DepthFirst())
        _ = Artn.strategy.tryAlgo(algo, DFGoal.terminal, nil)
        //sGame.puzzle.solve(randomPuzzle, untilSolutions: Found.terminal)
        
        //XCTAssertTrue(sGame.puzzle.uniquePuzzleSolutions.count > 0, "testCreatePuzzle: >0 unique solutions found!")
        XCTAssertTrue(Artn.strategy.uniqueSolutions.count > 0, "testCreatePuzzle: < 1 unique solutions found!")
        
    }
    
    func testGetCellContentType() {
        let sGame = Game(challenge: 4)
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
        let ArtoSolution =
            ["8", "5", "9", "6", "1", "2", "4", "3", "7",
             "7", "2", "3", "8", "5", "4", "1", "6", "9",
             "1", "6", "4", "3", "7", "9", "5", "2", "8",
             "9", "8", "6", "1", "4", "7", "3", "5", "2",
             "3", "7", "5", "2", "6", "8", "9", "1", "4",
             "2", "4", "1", "5", "9", "3", "7", "8", "6",
             "4", "3", "2", "9", "8", "1", "6", "7", "5",
             "6", "1", "7", "4", "2", "5", "8", "9", "3",
             "5", "9", "8", "7", "3", "6", "2", "4", "1"]
        let ArtoPlayerAnswered =
            ["8", "5", "", "", "", "2", "4", "", "",
             "7", "2", "", "", "", "", "", "", "9",
             "", "", "4", "", "", "", "", "2", "",
             "", "", "", "1", "4", "7", "", "", "2",
             "3", "7", "5", "", "", "8", "9", "1", "4",
             "", "4", "", "", "", "", "", "", "",
             "4", "", "", "9", "8", "1", "", "7", "",
             "", "1", "7", "", "", "", "", "9", "",
             "", "", "", "7", "3", "6", "", "4", ""]
        let ArtoAllCandidates =
            ["", "", "1369", "36", "1679", "", "", "36", "1367",
             "", "", "136", "34568", "156", "345", "13568", "3568", "",
             "169", "369", "", "3568", "15679", "359", "135678", "", "135678",
             "69", "689", "689", "", "", "", "3568", "3568", "",
             "", "", "", "26", "26", "", "", "", "",
             "1269", "", "12689", "2356", "2569", "359", "35678", "3568", "35678",
             "", "36", "236", "", "", "", "2356", "", "356",
             "256", "", "", "245", "25", "45", "23568", "", "3568",
             "259", "89", "289", "", "", "", "1258", "", "158"]
        let ArtoPlayerCandidates =
            ["", "", "", "36", "", "", "", "36", "",
             "", "", "136", "", "156", "345", "", "", "",
             "169", "369", "", "", "", "359", "", "", "",
             "69", "689", "689", "", "", "", "", "", "",
             "", "", "", "26", "26", "", "", "", "",
             "", "", "", "", "", "359", "", "", "",
             "", "36", "236", "", "", "", "", "", "356",
             "256", "", "", "245", "25", "45", "", "", "",
             "259", "89", "289", "", "", "", "", "", "158"]
        
        sGame.gamePuzzles.given = ArtoPuzzle
        sGame.gamePuzzles.solution = ArtoSolution
        sGame.gamePuzzles.playerAnswered = ArtoPlayerAnswered
        sGame.gamePuzzles.allCandidates = ArtoAllCandidates
        sGame.gamePuzzles.playerCandidates = ArtoPlayerCandidates
        sGame.gamePuzzles.state = states.valid
        
        let aGiven = sGame.getCellInfo(1)
        XCTAssertEqual(ArtoPuzzle[1], aGiven.contents, "testGetCellContentType: contents as expected!")
        XCTAssertEqual(cellContent.given, aGiven.type, "testGetCellContentType: type of given as expected!")
        
        let aAnswer = sGame.getCellInfo(25)
        XCTAssertEqual(ArtoPlayerAnswered[25], aAnswer.contents, "testGetCellContentType: contents as expected!")
        XCTAssertEqual(cellContent.answered, aAnswer.type, "testGetCellContentType: type of answered as expected!")
        
        let aPlayerCandidate = sGame.getCellInfo(3)
        XCTAssertEqual(ArtoPlayerCandidates[3], aPlayerCandidate.contents, "testGetCellContentType: contents as expected!")
        XCTAssertEqual(cellContent.playerCandidate, aPlayerCandidate.type, "testGetCellContentType: type of playerCandidate as expected!")
        
        let anAllCandidate = sGame.getCellInfo(2)
        XCTAssertEqual(ArtoAllCandidates[2], anAllCandidate.contents, "testGetCellContentType: contents as expected!")
        XCTAssertEqual(cellContent.allCandidate, anAllCandidate.type, "testGetCellContentType: type of candidate as expected!")        
    }
    
    
    
}
