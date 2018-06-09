//
//  SolutionsTests.swift
//  Sudoku
//
//  Created by dave herbine on 3/20/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import UIKit
import XCTest

class SolutionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //uniquePuzzleSolutions = [[String]]()    // array of arrays
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testGenerateSeededPuzzles() {
        
        let givenSeeds = [
            ["", "", "", "7", "1", "9", "", "3", "", "", "", "", "8", "2", "6", "5", "1", "", "7", "1", "6", "4", "3", "5", "", "", "",
                "4", "5", "", "2", "9", "", "", "6", "1", "3", "", "", "6", "4", "7", "8", "5", "2", "6", "", "7", "", "", "8", "4", "9", "3",
                "2", "", "", "", "8", "1", "3", "", "", "8", "6", "3", "5", "", "2", "1", "4", "", "", "7", "9", "", "", "", "2", "", ""],
            ["", "1", "2", "7", "4", "", "", "9", "", "5", "", "", "8", "", "9", "", "", "1", "", "3", "6", "", "", "", "", "8", "7",
                "3", "6", "", "2", "1", "", "", "", "", "4", "", "", "3", "", "6", "2", "7", "9", "2", "8", "7", "", "", "5", "1", "", "6",
                "", "4", "5", "", "", "2", "", "", "3", "", "", "", "1", "", "8", "", "", "", "", "9", "", "", "", "4", "", "5", ""],
            ["", "3", "8", "2", "", "", "", "1", "6", "", "", "", "", "", "", "", "", "3", "", "", "", "", "", "", "4", "7", "9",
                "", "", "", "", "", "5", "", "", "7", "", "4", "6", "8", "1", "3", "", "", "2", "", "5", "9", "4", "", "6", "", "8", "",
                "", "", "", "6", "", "", "", "", "", "", "1", "4", "", "", "8", "2", "", "", "", "6", "", "", "", "4", "", "9", ""],
            ["8", "5", "", "", "", "2", "4", "", "", "7", "2", "", "", "", "", "", "", "9", "", "", "4", "", "", "", "", "", "",
                "", "", "", "1", "", "7", "", "", "2", "3", "", "5", "", "", "", "9", "", "", "", "4", "", "", "", "", "", "", "",
                "", "", "", "", "8", "", "", "7", "", "", "1", "7", "", "", "", "", "", "", "", "", "", "", "3", "6", "", "4", ""],
            ["", "6", "", "3", "", "9", "", "", "5", "", "7", "4", "", "2", "5", "1", "", "", "5", "", "", "1", "", "6", "", "4", "9",
                "", "", "7", "", "", "1", "", "6", "", "3", "4", "", "", "", "", "7", "9", "", "", "", "", "", "", "", "", "", "",
                "", "", "", "", "", "", "", "", "", "", "1", "", "", "", "", "", "2", "", "", "", "", "6", "3", "", "", "5", ""]
            ]
        let solutionSeeds = [
            ["5", "8", "2", "7", "1", "9", "6", "3", "4", "9", "3", "4", "8", "2", "6", "5", "1", "7", "7", "1", "6", "4", "3", "5", "9", "2", "8",
                "4", "5", "8", "2", "9", "3", "7", "6", "1", "3", "9", "1", "6", "4", "7", "8", "5", "2", "6", "2", "7", "1", "5", "8", "4", "9", "3",
                "2", "4", "5", "9", "8", "1", "3", "7", "6", "8", "6", "3", "5", "7", "2", "1", "4", "9", "1", "7", "9", "3", "6", "4", "2", "8", "5"],
            ["8", "1", "2", "7", "4", "3", "6", "9", "5", "5", "7", "4", "8", "6", "9", "3", "2", "1", "9", "3", "6", "5", "2", "1", "4", "8", "7",
                "3", "6", "9", "2", "1", "7", "5", "4", "8", "4", "5", "1", "3", "8", "6", "2", "7", "9", "2", "8", "7", "4", "9", "5", "1", "3", "6",
                "6", "4", "5", "9", "7", "2", "8", "1", "3", "7", "2", "3", "1", "5", "8", "9", "6", "4", "1", "9", "8", "6", "3", "4", "7", "5", "2"],
            ["9", "3", "8", "2", "4", "7", "5", "1", "6", "4", "7", "1", "5", "6", "9", "8", "2", "3", "6", "2", "5", "3", "8", "1", "4", "7", "9",
                "1", "8", "3", "9", "2", "5", "6", "4", "7", "7", "4", "6", "8", "1", "3", "9", "5", "2", "2", "5", "9", "4", "7", "6", "3", "8", "1",
                "8", "9", "7", "6", "5", "2", "1", "3", "4", "3", "1", "4", "7", "9", "8", "2", "6", "5", "5", "6", "2", "1", "3", "4", "7", "9", "8"],
            ["8", "5", "9", "6", "1", "2", "4", "3", "7", "7", "2", "3", "8", "5", "4", "1", "6", "9", "1", "6", "4", "3", "7", "9", "5", "2", "8",
                "9", "8", "6", "1", "4", "7", "3", "5", "2", "3", "7", "5", "2", "6", "8", "9", "1", "4", "2", "4", "1", "5", "9", "3", "7", "8", "6",
                "4", "3", "2", "9", "8", "1", "6", "7", "5", "6", "1", "7", "4", "2", "5", "8", "9", "3", "5", "9", "8", "7", "3", "6", "2", "4", "1"],
            ["1", "6", "2", "3", "4", "9", "8", "7", "5", "9", "7", "4", "8", "2", "5", "1", "3", "6", "5", "8", "3", "1", "7", "6", "2", "4", "9",
                "8", "5", "7", "4", "9", "1", "3", "6", "2", "3", "4", "1", "5", "6", "2", "7", "9", "8", "2", "9", "6", "7", "8", "3", "5", "1", "4",
                "6", "3", "5", "2", "1", "4", "9", "8", "7", "4", "1", "8", "9", "5", "7", "6", "2", "3", "7", "2", "9", "6", "3", "8", "4", "5", "1"]
            ]
        let solutionStates = [solvingAlgo.solvedByCP, solvingAlgo.solvedByCP, solvingAlgo.solvedByCP, solvingAlgo.solvedByPairs, solvingAlgo.solvedByT1UR]
        
        var Ertn = PzlSet()
        let testPuzzle = Puzzle()
        for i in 0...givenSeeds.count-1 {
            Ertn.given = givenSeeds[i]
            Ertn.playerAnswered = givenSeeds[i]
            Ertn.solution = solutionSeeds[i]
            Ertn.state = states.valid
            Ertn.cLevel = i
            print("Before: given, solution, allCandidates, playerCandidates, playerAnswered, state = \(Ertn.state), solvedUnits = \(Ertn.solvedUnits), solvingAlgorithm = \(String(describing: Ertn.solvingAlgorithm)), challenge = \(Ertn.cLevel)")
            printPuzzle(Ertn.given)
            printPuzzle(Ertn.solution)
            printPuzzle(Ertn.allCandidates)
            printPuzzle(Ertn.playerCandidates)
            printPuzzle(Ertn.playerAnswered)
            let algoResult = testPuzzle.runAlgorithms(Ertn, DFGoal.proper)
            print("After: given, solution, allCandidates, playerCandidates, playerAnswered, state = \(algoResult.pzlset.state), solvedUnits = \(algoResult.pzlset.solvedUnits), solvingAlgorithm = \(String(describing: algoResult.pzlset.solvingAlgorithm)), challenge = \(algoResult.pzlset.cLevel)")
            printPuzzle(algoResult.pzlset.given)
            printPuzzle(algoResult.pzlset.solution)
            printPuzzle(algoResult.pzlset.allCandidates)
            printPuzzle(algoResult.pzlset.playerCandidates)
            printPuzzle(algoResult.pzlset.playerAnswered)
            XCTAssertEqual(solutionSeeds[i], algoResult.pzlset.playerAnswered, "testGenerateSeededPuzzles: Solved puzzle is as expected!")
            if let solvedAlgo = algoResult.pzlset.solvingAlgorithm {
                XCTAssertEqual(solutionStates[i], solvedAlgo, "testGenerateSeededPuzzles: Solved puzzle solutionState is as expected!")
            }
        }
        
    }
    
    func testSolveByConstraintPropagation() {
        
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
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = easyPuzzle
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        
        print("testSolveByConstraintPropagation: easy puzzle = ")
        printPuzzle(algoResults.playerAnswered)
        
        print("testSolveByConstraintPropagation: solved units count = \(algoResults.solvedUnits.count)")
        print("testSolveByConstraintPropagation: solved units = \(algoResults.solvedUnits)")
        
        XCTAssertEqual(easyPuzzleSolution, Artn.strategy.pzzlSet.playerAnswered, "testSolveByConstraintPropagation: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testSolveByConstraintPropagation: Solved puzzle state is solved!")
        
    }
        
    func testCPassignsOneUnansweredEdgeCase() {
        // Following Easy puzzle can be solved with constraint propagation (32 givens, 9 values)
        let veryEasyGiven =
            ["4","8","3","9","2","1","6","5","7",   // 8
                "9","6","7","3","4","5","8","2","1",   // 17
                "2","5","1","8","7","6","4","9","3",   // 26
                "5","4","8","1","3","2","9","7","6",   // 35
                "7","2","9","5","","4","1","3","8",   // 44 (cell 40 is the only one unanswered
                "1","3","6","7","9","8","2","4","5",   // 53
                "3","7","2","6","8","9","5","1","4",   // 62
                "8","1","4","2","5","3","7","6","9",   // 71
                "6","9","5","4","1","7","3","8","2"]
        let veryEasySolution =
            ["4","8","3","9","2","1","6","5","7",   // 8
                "9","6","7","3","4","5","8","2","1",   // 17
                "2","5","1","8","7","6","4","9","3",   // 26
                "5","4","8","1","3","2","9","7","6",   // 35
                "7","2","9","5","6","4","1","3","8",   // 44
                "1","3","6","7","9","8","2","4","5",   // 53
                "3","7","2","6","8","9","5","1","4",   // 62
                "8","1","4","2","5","3","7","6","9",   // 71
                "6","9","5","4","1","7","3","8","2"]
        let easyPuzzlecpAssigns = [Cell(i: 40, e: "6")]
        let easyPuzzlecpAlgoAssigns = [AlgoAssigns(aCell: Cell(i: 40, e: "6"), hhCells: [HelpCell(sq: 36, ans: "", del: "6", alg: ""), HelpCell(sq: 37, ans: "", del: "6", alg: ""), HelpCell(sq: 38, ans: "", del: "6", alg: ""), HelpCell(sq: 39, ans: "", del: "6", alg: ""), HelpCell(sq: 40, ans: "6", del: "", alg: ""), HelpCell(sq: 41, ans: "", del: "6", alg: ""), HelpCell(sq: 42, ans: "", del: "6", alg: ""), HelpCell(sq: 43, ans: "", del: "6", alg: ""), HelpCell(sq: 44, ans: "", del: "6", alg: "")], aAlgo: "One Rule")]
        
        var Ertn = PzlSet()
        Ertn.given = veryEasyGiven
        Ertn.playerAnswered = veryEasyGiven
        Ertn.solution = veryEasySolution
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.help, nil)
        
        print("testCPassignsOneUnansweredEdgeCase: solved units count = \(algoResults.solvedUnits.count)")
        print("testCPassignsOneUnansweredEdgeCase: solved units = \(algoResults.solvedUnits)")
        
        XCTAssertEqual(veryEasySolution, Artn.strategy.pzzlSet.playerAnswered, "testCPassignsOneUnansweredEdgeCase: Solved puzzle is NOT as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testCPassignsOneUnansweredEdgeCase: Solved puzzle state is NOT solved!")

        print("testCPassignsOneUnansweredEdgeCase: Artn.strategy.cpAssigns!.count = \(Artn.strategy.cpAssigns.count)")
        XCTAssertEqual(easyPuzzlecpAssigns, Artn.strategy.cpAssigns, "testCPassignsOneUnansweredEdgeCase: puzzle CP cpAssigns as expected!")
        //print(Artn.strategy.cpAssigns!)
        if Artn.strategy.algoAssigns != nil {
            print("testCPassignsOneUnansweredEdgeCase: cpAssignAlgo.count = \(easyPuzzlecpAlgoAssigns.count), Artn.strategy.algoAssigns!.count = \(Artn.strategy.algoAssigns!.count)")
            //            for anAssign in Artn.strategy.algoAssigns! {
            //                anAssign.printIt()
            //            }
            //            print(Artn.strategy.algoAssigns!)
            XCTAssertEqual(easyPuzzlecpAlgoAssigns.first, Artn.strategy.algoAssigns?.first, "testCPassignsOneUnansweredEdgeCase: puzzle CP cpAssigns as expected!")
        } else {
            XCTAssertEqual(0, 1, "testCPassignsOneUnansweredEdgeCase: puzzle Tuples algoAssigns is nil!")
        }
    }
    
    func testHandleValidSolvedPuzzleByCP() {
        
        // Following Easy puzzle can be solved with constraint propagation (32 givens, 9 values)
        let ValidSolvedPuzzle =
            ["4","8","3","9","2","1","6","5","7",
             "9","6","7","3","4","5","8","2","1",
             "2","5","1","8","7","6","4","9","3",
             "5","4","8","1","3","2","9","7","6",
             "7","2","9","5","6","4","1","3","8",
             "1","3","6","7","9","8","2","4","5",
             "3","7","2","6","8","9","5","1","4",
             "8","1","4","2","5","3","7","6","9",
             "6","9","5","4","1","7","3","8","2"]
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = ValidSolvedPuzzle
        Ertn.solution = ValidSolvedPuzzle
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        _ = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        
        XCTAssertEqual(ValidSolvedPuzzle, Artn.strategy.pzzlSet.playerAnswered, "testHandleValidSolvedPuzzleByCP: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testHandleValidSolvedPuzzleByCP: Solved puzzle state is solved!")
        
    }
    

    func testReduceArtoPuzzleByCP() {
        
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
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = ArtoPuzzle
        Ertn.state = states.valid
        let Artn = Solution(strategy: ConstraintPropagation())
        let algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        
        print("testReduceArtoPuzzleByCP: Arto puzzle = ")
        printPuzzle(algoResults.playerAnswered)
        
        XCTAssertEqual(ArtoPuzzleCPSolution, Artn.strategy.pzzlSet.playerAnswered, "testReduceArtoPuzzleByCP: Solved puzzle is as expected!")
        XCTAssertEqual(states.valid, Artn.strategy.pzzlSet.state, "testReduceArtoPuzzleByCP: Solved puzzle state is solved!")

    }
    

    func testFind1905SolutionsByDF() {
        
        // Following puzzle is the famous Sky TV puzzle competition with 1,905 solutions! It cannot be solved with constraint propagation (26 givens, 9 values)
        let SkySolutionsCount = 1905
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
        let SkyPuzzleCP =
            ["5","17","6","148","2","478","9","1478","3",
             "13479","12379","8","1346","1379","4679","5","12467","126",
             "13479","12379","2379","5","1379","46789","1478","124678","1268",
             "6","4","37","2","8","5","17","137","9",
             "17","1257","257","9","4","3","178","15678","1568",
             "8","359","359","7","6","1","2","35","4",
             "379","356789","3579","13468","1379","246789","148","124589","1258",
             "79","56789","4","168","179","26789","3","12589","1258",
             "2","389","1","348","5","489","6","489","7"]
        
        print("testFind1905SolutionsByDF: Sky puzzle = ")
        printPuzzle(SkyPuzzle)
        
        // First, reduce Sky puzzle by Contraint Propagation.  Otherwise, Depth First would run for a long time.
        var Ertn = PzlSet()
        Ertn.playerAnswered = SkyPuzzle
        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        
        print("testFind1905SolutionsByDF: Constraint Propagation of Sky puzzle = ")
        printPuzzle(algoResults.playerAnswered)
        
        XCTAssertEqual(SkyPuzzleCP, Artn.strategy.pzzlSet.playerAnswered, "testFind1905SolutionsByDF: Solved puzzle is as expected!")
        XCTAssertEqual(states.valid, Artn.strategy.pzzlSet.state, "testFind1905SolutionsByDF: Solved puzzle state is solved!")
        
        // Now set to the results from Constraint Propagation and run Depth First
        Ertn = algoResults
        Artn = Solution(strategy: DepthFirst())
        algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        
        XCTAssertEqual(SkySolutionsCount, Artn.strategy.uniqueSolutions.count, "testFind1905SolutionsByDF: Sky puzzle has 1905 unique solutions found!")
    }
    
    func testFind1619SolutionsByDF() {
        
        // Following puzzle is a randomly generated puzzle of mine with at least 2 solutions! (26 givens, 9 values)
        let randomPuzzle =
            ["","6","","","","","2","5","",
             "","","","","","","6","","9",
             "","","","2","5","","","3","4",
             "6","","","","","","9","","",
             "7","5","","3","","","","","",
             "","8","","","","","3","","",
             "","","8","","6","2","7","","",
             "","","","7","","5","8","","",
             "","","","","8","3","5","",""]
        let randomPuzzleCP =
            ["1349","6","13479","1489","13479","14789","2","5","78",
             "1234","12347","5","148","1347","1478","6","78","9",
             "8","79","79","2","5","6","1","3","4",
             "6","1234","1234","5","1247","1478","9","1278","1278",
             "7","5","129","3","129","189","4","1268","1268",
             "1249","8","1249","6","12479","1479","3","127","5",
             "5","1349","8","149","6","2","7","149","13",
             "12349","12349","123469","7","149","5","8","12469","1236",
             "1249","12479","124679","149","8","3","5","12469","126"]
        
        print("testFindAtLeastTwoSolutionsByDF: random puzzle = ")
        printPuzzle(randomPuzzle)
        
        // First, reduce Sky puzzle by Contraint Propagation.  Otherwise, Depth First would run for a long time.
        var Ertn = PzlSet()
        Ertn.playerAnswered = randomPuzzle
        //        print("Ertn before CP = ")
        //        print("\(Ertn)")
        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        //        print("Ertn After CP = ")
        //        print("\(Ertn)")
        
        print("testFindAtLeastTwoSolutionsByDF: Constraint Propagation results: state = \(Artn.strategy.pzzlSet.state), solvedUnits = \(Artn.strategy.pzzlSet.solvedUnits), solvingAlgorithm = \(String(describing: Artn.strategy.pzzlSet.solvingAlgorithm)), solutions.count = \(Artn.strategy.uniqueSolutions.count)")
        printPuzzle(algoResults.playerAnswered)
        
        XCTAssertEqual(randomPuzzleCP, Artn.strategy.pzzlSet.playerAnswered, "testFindAtLeastTwoSolutionsByDF: Solved puzzle is as expected!")
        XCTAssertEqual(states.valid, Artn.strategy.pzzlSet.state, "testFindAtLeastTwoSolutionsByDF: Solved puzzle state is solved!")
        
        // Now set to the results from Constraint Propagation and run Depth First
        Ertn = algoResults
        //        print("Ertn After set equal to algoResults = ")
        //        print("\(Ertn)")
        Artn = Solution(strategy: DepthFirst())
        algoResults = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        
        print("testFindAtLeastTwoSolutionsByDF: Depth First results: state = \(Artn.strategy.pzzlSet.state), solvedUnits = \(Artn.strategy.pzzlSet.solvedUnits), solvingAlgorithm = \(String(describing: Artn.strategy.pzzlSet.solvingAlgorithm)), solutions.count = \(Artn.strategy.uniqueSolutions.count)")
        printPuzzle(algoResults.playerAnswered)
        
        XCTAssertEqual(1619, Artn.strategy.uniqueSolutions.count, "testFindAtLeastTwoSolutionsByDF: Random puzzle has n unique solutions found!")
        
    }
    
    func testFindMultipleSolutionsByRunAlgorithms() {
        
        // These are randomly generated puzzles with at least 2 solutions!
        let randomPuzzle = [
            ["","6","","","","","2","5","",
                "","","","","","","6","","9",
                "","","","2","5","","","3","4",
                "6","","","","","","9","","",
                "7","5","","3","","","","","",
                "","8","","","","","3","","",
                "","","8","","6","2","7","","",
                "","","","7","","5","8","","",
                "","","","","8","3","5","",""],
            ["","","","","","2","4","1","",
                "8","","7","3","","","","","9",
                "","2","","1","","","","6","",
                "","","","8","6","5","7","9","",
                "","","","9","","7","1","","4",
                "","","","","","4","5","3","",
                "","4","","6","9","3","","","",
                "","","5","7","","8","","","1",
                "","7","8","","","1","9","","3"]
        ]
        
        var runPzl = PzlSet()
        let pzlObj = Puzzle()
        for i in 0...randomPuzzle.count-1 {
            runPzl.playerAnswered = randomPuzzle[i]
            runPzl.state = .valid
            runPzl.given = runPzl.playerAnswered
            runPzl.solvingAlgorithm = nil
            runPzl.solvedUnits.removeAll()
            runPzl = pzlObj.runAlgorithms(runPzl, DFGoal.improper).pzlset
            print("testFindMultipleSolutionsByRunAlgorithms: runAlgorithms results: state = \(runPzl.state), solvedUnits = \(runPzl.solvedUnits), solvingAlgorithm = \(String(describing: runPzl.solvingAlgorithm))")
            XCTAssertEqual(states.invalid, runPzl.state, "testFindMultipleSolutionsByRunAlgorithms: Solved puzzle state is solved!")
        }
        
        // uniqueSolutions is a property of Solution class, not PzlSet, so I don't actually know how many solutions there are.  
//        XCTAssertEqual(1619, Artn.strategy.uniqueSolutions.count, "testFind1619SolutionsByRunAlgorithms: Random puzzle has n unique solutions found!")
        
    }
    
     func testHandleValidSolvedPuzzleByDF() {
        
        let solvedArtoPuzzle =
            ["8", "5", "9", "6", "1", "2", "4", "3", "7",
             "7", "2", "3", "8", "5", "4", "1", "6", "9",
             "1", "6", "4", "3", "7", "9", "5", "2", "8",
             "9", "8", "6", "1", "4", "7", "3", "5", "2",
             "3", "7", "5", "2", "6", "8", "9", "1", "4",
             "2", "4", "1", "5", "9", "3", "7", "8", "6",
             "4", "3", "2", "9", "8", "1", "6", "7", "5",
             "6", "1", "7", "4", "2", "5", "8", "9", "3",
             "5", "9", "8", "7", "3", "6", "2", "4", "1"]
        
        var Ertn = PzlSet()
        Ertn.playerAnswered = solvedArtoPuzzle
        Ertn.solution = solvedArtoPuzzle
        Ertn.state = states.valid  // Superfluous, but important reminder of what is expected to change
        let Artn = Solution(strategy: DepthFirst())
        _ = Artn.strategy.tryAlgo(Ertn, DFGoal.proper, nil)
        
        XCTAssertEqual(solvedArtoPuzzle, Artn.strategy.pzzlSet.playerAnswered, "testHandleValidSolvedPuzzleByDF: Solved puzzle is as expected!")
        XCTAssertEqual(states.solved, Artn.strategy.pzzlSet.state, "testHandleValidSolvedPuzzleByDF: Solved puzzle state is solved!")
                
    }
    
    func testSolveByTuples() {
        
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
        let ArtoPuzzleTuplesEliminates =
            ["", "", "36", "", "6", "", "", "", "36",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "68", "68", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "256", "", "56",
             "", "", "", "", "", "", "", "", ""]

        print("testTuples: Arto puzzle = ")
        printPuzzle(ArtoPuzzle.playerAnswered)

        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(ArtoPuzzle, DFGoal.proper, nil)
        print("testTuples: Arto puzzle results from constraint propagation = ")
        printPuzzle(algoResults.playerAnswered)
        XCTAssertEqual(ArtoPuzzleCPSolution, algoResults.playerAnswered, "testTuples: puzzle solution as expected!")
        
        Artn = Solution(strategy: Tuples())
        algoResults = Artn.strategy.tryAlgo(algoResults, DFGoal.proper, nil)
        print("testTuples: Arto puzzle results from Tuples = ")
        printPuzzle(algoResults.playerAnswered)
        XCTAssertEqual(ArtoPuzzleTuplesSolution, Artn.strategy.pzzlSet.playerAnswered, "testDepthFirst: Arto puzzle NOT solved!")
        
        print("testTuples: Arto puzzle Eliminates from Tuples = ")
        printPuzzle(Artn.strategy.eliminates)
        XCTAssertEqual(ArtoPuzzleTuplesEliminates, Artn.strategy.eliminates, "testDepthFirst: Arto puzzle eliminates NOT found!")
        
    }
    
    func testFindUnitTuples2() {
        let tuple = Tuples()

        let hidden47naked69 = ["2345678", "12345789", "1238", "568", "1589", "69", "258", "1258", "69"]
        var allTuples = ["47", "47", "", "", "", "69", "", "", "69"]
        var reducibleHiddenTuples = ["47", "47", "", "", "", "", "", "", ""]
        var hiddenEliminates = ["23568", "123589", "", "", "", "", "", "", ""]
        var reducibleNakedTuples = ["", "", "", "", "", "69", "", "", "69"]
        var nakedEliminates = ["6", "9", "", "6", "9", "", "", "", ""]
        var netEliminates = ["23568", "123589", "", "6", "9", "", "", "", ""]
        
        var Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], hidden47naked69, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleHiddenTuples, Artn.reducibleHiddenTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(hiddenEliminates, Artn.hiddenEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleNakedTuples, Artn.reducibleNakedTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(nakedEliminates, Artn.nakedEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuples: eliminate array is as expected!")
        
        let naked24naked69 = ["24", "24", "1238", "4568", "1589", "69", "258", "1258", "69"]
        allTuples = ["24", "24", "", "", "", "69", "", "", "69"]
        reducibleHiddenTuples = [String]()  //(repeating: "", count: 9)
        hiddenEliminates = [String]()   //(repeating: "", count: 9)
        reducibleNakedTuples = ["24", "24", "", "", "", "69", "", "", "69"]
        nakedEliminates = ["", "", "2", "46", "9", "", "2", "2", ""]
        netEliminates = ["", "", "2", "46", "9", "", "2", "2", ""]
        
        Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], naked24naked69, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleHiddenTuples, Artn.reducibleHiddenTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(hiddenEliminates, Artn.hiddenEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleNakedTuples, Artn.reducibleNakedTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(nakedEliminates, Artn.nakedEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuples: eliminate array is as expected!")
        
        let naked36 = ["8", "5", "1369", "36", "1679", "2", "4", "36", "1367"]    // From Arto puzzle after CP - naked double
        allTuples = ["", "", "", "36", "", "", "", "36", ""]
        reducibleHiddenTuples = [String]()
        hiddenEliminates = [String]()
        reducibleNakedTuples = ["", "", "", "36", "", "", "", "36", ""]
        nakedEliminates = ["", "", "36", "", "6", "", "", "", "36"]
        netEliminates = ["", "", "36", "", "6", "", "", "", "36"]
        
        Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], naked36, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleHiddenTuples, Artn.reducibleHiddenTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(hiddenEliminates, Artn.hiddenEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleNakedTuples, Artn.reducibleNakedTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(nakedEliminates, Artn.nakedEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuples: eliminate array is as expected!")
        
        let hidden12 = ["3457", "4789", "1238", "568", "589", "3679", "58", "1258", "469"]
        allTuples = ["", "", "12", "", "", "", "", "12", ""]
        reducibleHiddenTuples = ["", "", "12", "", "", "", "", "12", ""]
        hiddenEliminates = ["", "", "38", "", "", "", "", "58", ""]
        reducibleNakedTuples = [String]()
        nakedEliminates = [String]()
        netEliminates = ["", "", "38", "", "", "", "", "58", ""]
        
        Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], hidden12, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleHiddenTuples, Artn.reducibleHiddenTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(hiddenEliminates, Artn.hiddenEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleNakedTuples, Artn.reducibleNakedTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(nakedEliminates, Artn.nakedEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuples: eliminate array is as expected!")
        
        let hidden46hidden12 = ["34567", "789", "1238", "578", "589", "379", "58", "1258", "469"]
        allTuples = ["46", "", "12", "", "", "", "", "12", "46"]
        reducibleHiddenTuples = ["46", "", "12", "", "", "", "", "12", "46"]
        hiddenEliminates = ["357", "", "38", "", "", "", "", "58", "9"]
        reducibleNakedTuples = [String]()
        nakedEliminates = [String]()
        netEliminates = ["357", "", "38", "", "", "", "", "58", "9"]
        
        Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], hidden46hidden12, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleHiddenTuples, Artn.reducibleHiddenTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(hiddenEliminates, Artn.hiddenEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleNakedTuples, Artn.reducibleNakedTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(nakedEliminates, Artn.nakedEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuples: eliminate array is as expected!")
        
        let none = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        allTuples = [String]()
        reducibleHiddenTuples = [String]()
        hiddenEliminates = [String]()
        reducibleNakedTuples = [String]()
        nakedEliminates = [String]()
        netEliminates = [String]()
        
        Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], none, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleHiddenTuples, Artn.reducibleHiddenTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(hiddenEliminates, Artn.hiddenEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleNakedTuples, Artn.reducibleNakedTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(nakedEliminates, Artn.nakedEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuples: eliminate array is as expected!")
        
        let irreducibleNaked36 = ["1", "2", "36", "4", "5", "36", "7", "8", "9"]
        allTuples = ["", "", "36", "", "", "36", "", "", ""]
        reducibleHiddenTuples = allTuples // Changed on 12/11/2016 from [String]() with findUnitTuples2
        hiddenEliminates = [String]()
        reducibleNakedTuples = allTuples // Changed on 12/11/2016 from [String]() with findUnitTuples2
        nakedEliminates = [String]()
        netEliminates = [String]()
        
        Artn = tuple.findUnitTuples2([0,1,2,3,4,5,6,7,8], irreducibleNaked36, tuple: 2)
        XCTAssertEqual(allTuples, Artn.allTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleHiddenTuples, Artn.reducibleHiddenTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(hiddenEliminates, Artn.hiddenEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(reducibleNakedTuples, Artn.reducibleNakedTuples, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(nakedEliminates, Artn.nakedEliminates, "testFindUnitTuples: eliminate array is as expected!")
        XCTAssertEqual(netEliminates, Artn.netEliminates, "testFindUnitTuples: eliminate array is as expected!")
        
    }
    
    func testSolveByT1UR() {        
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
        let deadlyPatternAllPairsResults = [(index: 45, element: "68"), (index: 53, element: "68"), (index: 58, element: "67"), (index: 76, element: "67"), (index: 44, element: "68")]
        
        type1URPuzzle.given = deadlyPatternGivenPuzzle
        type1URPuzzle.playerAnswered = deadlyPatternGivenPuzzle
        
        print("testSolveByT1UR: T1UR given puzzle = ")
        printPuzzle(type1URPuzzle.given)
        
        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(type1URPuzzle, DFGoal.proper, nil)
        print("testSolveByT1UR: DeadlyPattern puzzle results from constraint propagation = ")
        printPuzzle(algoResults.playerAnswered)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternCPResultsPuzzle, type1URPuzzle.allCandidates, "testSolveByT1UR: puzzle CP results as expected!")
        
        Artn = Solution(strategy: Tuples())
        algoResults = Artn.strategy.tryAlgo(algoResults, DFGoal.proper, nil)
        print("testSolveByT1UR: DeadlyPattern puzzle results from Tuples = ")
        printPuzzle(algoResults.playerAnswered)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternTuplesResultsPuzzle, type1URPuzzle.allCandidates, "testSolveByT1UR: puzzle Tuples results as expected!")
        XCTAssertEqual(deadlyPatternTuplesEliminates, Artn.strategy.eliminates, "testSolveByT1UR: puzzle Tuples Eliminates as expected!")
        XCTAssertEqual(deadlyPatternAllPairsResults.count, Artn.strategy.allPairs?.count, "testSolveByT1UR: puzzle Tuples results as expected!")
        
        print("testSolveByT1UR: Artn.strategy.eliminates = ")
        printPuzzle(Artn.strategy.eliminates)
        print("testSolveByT1UR: Artn.strategy.allPairs = \(String(describing: Artn.strategy.allPairs))")
        print("testSolveByT1UR: Artn.strategy.reducibleNakedPairs = \(String(describing: Artn.strategy.reducibleNakedPairs))")
        print("testSolveByT1UR: Artn.strategy.reducibleHiddenPairs = \(String(describing: Artn.strategy.reducibleHiddenPairs))")
        let tuplesAllPairs = Artn.strategy.allPairs
        
        Artn = Solution(strategy: UniqueRectangles())
        algoResults = Artn.strategy.tryAlgo(algoResults, DFGoal.proper, tuplesAllPairs)
        print("testSolveByT1UR: DeadlyPattern puzzle results from UniqueRectangles = ")
        printPuzzle(algoResults.playerAnswered)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternUniqueRectanglesResultsPuzzle, type1URPuzzle.allCandidates, "testSolveByT1UR: puzzle UniqueRectangles results as expected!")
        XCTAssertEqual(deadlyPatternUniqueRectanglesEliminates, Artn.strategy.eliminates, "testSolveByT1UR: puzzle UniqueRectangles Eliminates as expected!")
    }
    
    func testSolveByT1UREdgeCase() {
        //
        // Same puzzle as testSolveByT1UR(), but I switch up and send a different set of pairs to force checking combinations of possible rectangles
        //
        
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
        let deadlyPatternUniqueRectanglesNoEliminates =
            ["", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", "",
             "", "", "", "", "", "", "", "", ""]
        let deadlyPatternAllPairsResults = [Cell(i: 45, e: "68"), Cell(i: 53, e: "68"), Cell(i: 58, e: "67"), Cell(i: 76, e: "67"), Cell(i: 44, e: "68")]
        // The following pairs will force the algorithm to check combinations of possible rectangles but should still find the correct combintaion and solve
        let deadlyPatternAllPairsEdgeCase = [Cell(i: 45, e: "68"), Cell(i: 53, e: "68"), Cell(i: 58, e: "68"), Cell(i: 76, e: "68"), Cell(i: 44, e: "68")]
        // The following pairs will force the algorithm to return the the same puzzle it was given and not find any digits to eliminate
        let deadlyPatternAllPairsNoCase = [Cell(i: 45, e: "68"), Cell(i: 52, e: "68"), Cell(i: 58, e: "68"), Cell(i: 76, e: "68"), Cell(i: 44, e: "68")]
        
        type1URPuzzle.given = deadlyPatternGivenPuzzle
        type1URPuzzle.playerAnswered = deadlyPatternGivenPuzzle
        
        print("testSolveByT1UREdgeCase: T1UR given puzzle = ")
        printPuzzle(type1URPuzzle.given)
        
        var Artn = Solution(strategy: ConstraintPropagation())
        var algoResults = Artn.strategy.tryAlgo(type1URPuzzle, nil, nil)
        print("testSolveByT1UREdgeCase: DeadlyPattern puzzle results from constraint propagation = ")
        printPuzzle(algoResults.playerAnswered)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternCPResultsPuzzle, type1URPuzzle.allCandidates, "testSolveByT1UREdgeCase: puzzle CP results as expected!")
        
        Artn = Solution(strategy: Tuples())
        algoResults = Artn.strategy.tryAlgo(algoResults, nil, nil)
        print("testSolveByT1UR: DeadlyPattern puzzle results from Tuples = ")
        printPuzzle(algoResults.playerAnswered)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternTuplesResultsPuzzle, type1URPuzzle.allCandidates, "testSolveByT1UREdgeCase: puzzle Tuples results as expected!")
        XCTAssertEqual(deadlyPatternTuplesEliminates, Artn.strategy.eliminates, "testSolveByT1UREdgeCase: puzzle Tuples Eliminates as expected!")
        XCTAssertEqual(deadlyPatternAllPairsResults.count, Artn.strategy.allPairs?.count, "testSolveByT1UREdgeCase: puzzle Tuples results as expected!")
        
        print("testSolveByT1UREdgeCase: Artn.strategy.eliminates = ")
        printPuzzle(Artn.strategy.eliminates)
        print("testSolveByT1UREdgeCase: Artn.strategy.allPairs = \(String(describing: Artn.strategy.allPairs))")
        print("testSolveByT1UREdgeCase: Artn.strategy.reducibleNakedPairs = \(String(describing: Artn.strategy.reducibleNakedPairs))")
        print("testSolveByT1UREdgeCase: Artn.strategy.reducibleHiddenPairs = \(String(describing: Artn.strategy.reducibleHiddenPairs))")
//        let tuplesAllPairs = Artn.strategy.allPairs
        
        //
        // deadlyPatternAllPairsNoCase does not have any deadly patterns and will simply return the same puzzle it was given and no digits to eliminate
        //
        Artn = Solution(strategy: UniqueRectangles())
        algoResults = Artn.strategy.tryAlgo(algoResults, DFGoal.proper, deadlyPatternAllPairsNoCase)
        print("testSolveByT1UREdgeCase: DeadlyPattern puzzle results from UniqueRectangles = ")
        printPuzzle(algoResults.playerAnswered)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternTuplesResultsPuzzle, type1URPuzzle.allCandidates, "testSolveByT1UREdgeCase: puzzle UniqueRectangles results as expected!")
        XCTAssertEqual(deadlyPatternUniqueRectanglesNoEliminates, Artn.strategy.eliminates, "testSolveByT1UREdgeCase: puzzle UniqueRectangles Eliminates as expected!")

        //
        // deadlyPatternAllPairsEdgeCase includes 5 pairs including the deadly rectangle so it will check all ten combinations and find the solution
        //
        algoResults = Artn.strategy.tryAlgo(algoResults, DFGoal.proper, deadlyPatternAllPairsEdgeCase)
        print("testSolveByT1UREdgeCase: DeadlyPattern puzzle results from UniqueRectangles = ")
        printPuzzle(algoResults.playerAnswered)
        type1URPuzzle.allCandidates = algoResults.playerAnswered
        XCTAssertEqual(deadlyPatternUniqueRectanglesResultsPuzzle, type1URPuzzle.allCandidates, "testSolveByT1UREdgeCase: puzzle UniqueRectangles results as expected!")
        XCTAssertEqual(deadlyPatternUniqueRectanglesEliminates, Artn.strategy.eliminates, "testSolveByT1UREdgeCase: puzzle UniqueRectangles Eliminates as expected!")
}
    
    func testCreateUnitStats() {
        let tuple = Tuples()
        let pairs = ["2345678", "12345789", "1238", "568", "1589", "69", "258", "1258", "69"]
        let ErtnRowsTotals = [4, 5, 3, 2, 6, 4, 2, 7, 4]
        let ErtnColsTotals = [7, 8, 4, 3, 4, 2, 3, 4, 2]
        
        let Artn = tuple.createUnitStats(pairs)
        XCTAssertEqual(ErtnRowsTotals, Artn.rowsSums, "testCreateUnitStats: rowsSums are as expected!")
        XCTAssertEqual(ErtnColsTotals, Artn.colsSums, "testCreateUnitStats: colsSums are as expected!")
    }
        
}
