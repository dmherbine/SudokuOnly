//
//  PuzzleGeneratorTests.swift
//  Sudoku
//
//  Created by dave herbine on 8/1/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit
import XCTest

class PuzzleGeneratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidatePzlSet() {
        let pzl = Puzzle()
        // The following puzzles were randomly generated and each has multiple solutions
        let theGivens = [
            ["1", "2", "", "", "4", "", "3", "", "", "4", "6", "", "3", "5", "", "", "", "", "", "", "", "", "", "", "", "6", "", "", "", "", "5", "8", "", "", "", "", "", "", "", "9", "", "", "", "1", "4", "", "", "", "", "1", "", "", "8", "", "7", "", "4", "6", "3", "", "", "5", "", "", "3", "", "8", "", "", "6", "4", "", "", "", "6", "4", "", "", "", "", ""],
            ["9", "", "", "", "", "", "5", "1", "", "", "4", "", "", "5", "7", "", "", "", "", "", "", "1", "", "", "", "6", "", "", "", "", "8", "1", "", "9", "", "6", "", "", "8", "", "9", "2", "4", "7", "", "", "", "", "", "", "3", "8", "", "5", "", "5", "", "", "2", "", "", "4", "", "4", "", "", "", "", "8", "", "9", "", "", "", "", "", "", "", "", "", "3"],
            ["7", "4", "", "", "", "", "", "", "5", "", "", "8", "", "4", "", "6", "7", "9", "", "", "", "1", "2", "", "", "", "8", "", "", "1", "", "", "8", "", "", "", "", "", "2", "", "9", "", "", "", "6", "", "", "", "", "", "4", "", "", "", "", "3", "", "9", "", "", "", "6", "4", "", "", "4", "7", "", "", "9", "8", "", "5", "", "", "", "", "", "", "2", ""],
            ["3", "5", "", "", "", "", "", "", "", "", "6", "", "", "", "", "", "", "7", "", "2", "", "", "", "", "3", "", "", "", "1", "2", "", "", "", "7", "6", "3", "", "7", "3", "", "", "", "", "", "1", "", "", "", "7", "1", "", "", "", "5", "", "", "9", "", "", "", "", "7", "", "", "4", "", "", "", "1", "", "8", "", "", "", "6", "5", "9", "", "", "3", ""],
            ["", "", "", "", "2", "6", "", "", "", "6", "", "", "1", "", "", "", "", "", "", "", "", "5", "", "", "1", "", "6", "", "", "", "", "", "4", "6", "", "", "", "", "4", "", "", "3", "8", "", "1", "", "7", "6", "", "", "", "", "5", "", "2", "3", "", "", "", "5", "7", "", "4", "", "", "", "", "", "", "5", "1", "", "5", "", "", "", "", "", "", "8", "2"]
        ]
        var Ertn = PzlSet()
        
        for i in 0...theGivens.count-1 {
            Ertn.given = theGivens[i]
            Ertn.playerAnswered = theGivens[i]
            Ertn.state = states.valid
            let validateResults = pzl.validatePzlSet(Ertn, DFGoal.proper)
            XCTAssertEqual(states.invalid, validateResults.state, "testValidatePzlSet: puzzle state is invalid as expected!")
        }
        
    }

    func testGeneratePuzzleWithChallenge() {
        let pzl = Puzzle()
        let cLevels = 4
        let iterations = 2
        var seedCnt = [Int](repeating: 0, count: cLevels+1)
        var newCnt = [Int](repeating: 0, count: cLevels+1)
        var emptyCnt = [Int](repeating: 0, count: cLevels+1)
        
        for i in 0...iterations {
            print("testGeneratePuzzleWithChallenge: iteration \(i) of \(iterations)")
            for j in 0...cLevels {
                let pSet = pzl.generatePuzzleWithChallenge(j)
                    if pSet.type == "classic" {
                        seedCnt[j] += 1
                    } else if pSet.type == "new" {
                        newCnt[j] += 1
                    } else {
                        emptyCnt[j] += 1
                    }
                //print("testGeneratePuzzleWithChallenge(\(i)): got a randomly generated puzzle...that I have to figure out how to test")
                //printPuzzle(Artn)
            }
        }
        let seedCntTotal = seedCnt.reduce(0, { $0 + $1 })
        let newCntTotal = newCnt.reduce(0, { $0 + $1 })
        let emptyCntTotal = emptyCnt.reduce(0, { $0 + $1 })
        print("testGeneratePuzzleWithChallenge: seeded, new, unknown, of challenge of \((iterations+1)*(cLevels+1)) total runs ")
        print("\(seedCnt) seeded total = \(seedCntTotal)")
        print("\(newCnt) new total = \(newCntTotal)")
        print("\(emptyCnt) unknown total = \(emptyCntTotal)")
        XCTAssertTrue(emptyCntTotal == 0, "testGeneratePuzzleWithChallenge: emptyCntTotal not 0 as expected!")
        XCTAssertTrue(seedCntTotal != 0, "testGeneratePuzzleWithChallenge: seedCntTotal is 0 which is unexpected!")
    }
    
    func testGenerateTerminalPuzzle() {
        let pzl = Puzzle()
        let terminalPuzzle = pzl.generateTerminalPuzzle()
        print("testGenerateTerminalPuzzle: terminal puzzle...")
        printPuzzle(terminalPuzzle)
    }
    
    func testGeneratedPuzzle() {
        let pzl = Puzzle()
        let randomPuzzle = pzl.generatePuzzleWithChallenge(0)
        print("testGeneratedPuzzle: random puzzle...")
        printPuzzle(randomPuzzle.playerAnswered)
    }
    
    func testGenerateGivenPzlSetWithChallenge() {
        let pzl = Puzzle()
        let Ertn = pzl.generateTerminalPuzzle()
        
        for cLevel in 0...4 {
            //let Artn = pzl.generateGivenPzlSetWithChallenge(Ertn, challengeLevel: cLevel)
            let Artn = pzl.generateNewPzlSetWithChallenge(Ertn, challengeLevel: cLevel)
            let givenCount = Artn.given.filter( { $0.characters.count == 1 } ).count
            print("testGenerateGivenPzlSetWithChallenge: challengeLevel = \(cLevel), # of givens = \(givenCount)")
            printPuzzle(Artn.given)
        }
    }
    
    func testGenerateAllCandidatesFromGiven() {
        let pzl = Puzzle()
        var pSet = PzlSet()
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
        let ArtoCandidates =
            ["", "", "1369", "3679", "1679", "", "", "136", "1367",
             "", "", "136", "34568", "1456", "13458", "13568", "13568", "",
             "169", "369", "", "356789", "15679", "13589", "1235678", "123568", "135678",
             "69", "689", "689", "", "4569", "", "3568", "3568", "",
             "", "678", "", "2468", "246", "48", "", "168", "14678",
             "1269", "", "12689", "235689", "2569", "3589", "135678", "13568", "135678",
             "24569", "369", "2369", "2459", "", "1459", "12356", "", "1356",
             "24569", "", "", "2459", "2459", "459", "23568", "235689", "3568",
             "259", "89", "289", "2579", "", "", "1258", "", "158"]
        pSet.given = ArtoPuzzle
        pSet.playerAnswered = ArtoPuzzle
        pSet.solvingAlgorithm = solvingAlgo.solvedByCP
        
        let Artn = pzl.generateAllCandidatesFromAnswered(pSet)
        XCTAssertEqual(ArtoCandidates, Artn, "testGenerateAllCandidatesFromGiven: Candidates aren't as expected!")
        
    }
    
    func testUpdateFromAnswered() {
        let pzl = Puzzle()
        let ArtoPuzzleWithE2Answered =
            ["8", "5", "", "", "", "2", "4", "", "",
             "7", "2", "", "", "", "", "", "", "9",
             "", "", "4", "", "", "", "", "", "",
             "", "", "", "1", "", "7", "", "", "2",
             "3", "7", "5", "", "", "", "9", "", "",
             "", "4", "", "", "", "", "", "", "",
             "", "", "", "", "8", "", "", "7", "",
             "", "1", "7", "", "", "", "", "", "",
             "", "", "", "", "3", "6", "", "4", ""]
        var ArtoCandidatesWithoutE2Answered =
            ["", "", "1369", "3679", "1679", "", "", "136", "1367",
             "", "", "136", "34568", "1456", "13458", "13568", "13568", "",
             "169", "369", "", "356789", "15679", "13589", "1235678", "123568", "135678",
             "69", "689", "689", "", "4569", "", "3568", "3568", "",
             "", "678", "", "2468", "246", "48", "", "168", "14678",
             "1269", "", "12689", "235689", "2569", "3589", "135678", "13568", "135678",
             "24569", "369", "2369", "2459", "", "1459", "12356", "", "1356",
             "24569", "", "", "2459", "2459", "459", "23568", "235689", "3568",
             "259", "89", "289", "2579", "", "", "1258", "", "158"]
        
//        print("testUpdateFromAnswered: Candidates before update")
//        printPuzzle(ArtoCandidatesWithoutE2Answered)
        let changedIndexes = pzl.updateAllCandidatesFromAnswered(&ArtoCandidatesWithoutE2Answered, answered: ArtoPuzzleWithE2Answered, selectedCell: nil)
//        print("testUpdateFromAnswered: Candidates after update")
//        printPuzzle(ArtoCandidatesWithoutE2Answered)
//        print("testUpdateFromAnswered: \(changedIndexes)")
        XCTAssertEqual([37, 44], changedIndexes, "testUpdateFromAnswered: Changed indexes aren't as expected!")
        
    }
    
    func testRandomFill() {
        let pzl = Puzzle()
        var Ertn: states = .solved
        var Artn: states = .solved
        
        let solvedUnit = ["1","2","3","4","5","6","7","8","9"]
        var randomUnit = pzl.randomFill(solvedUnit)
        Artn = checkUnit(randomUnit)
        XCTAssertEqual(Ertn, Artn, "testRandomFill: unit is solved!")
        
        let invalidUnit = ["1","2","3","4","5","6","7","8"]
        Ertn = .invalid
        randomUnit = pzl.randomFill(invalidUnit)
        Artn = checkUnit(randomUnit)
        XCTAssertEqual(Ertn, Artn, "testRandomFill: unit is invalid!")
    }

    func testShiftRight() {
        let pzl = Puzzle()
        var Artn = ["1","2","3","4","5","6","7","8","9"]
        var shiftArray = ["1","2","3"]
        var Ertn = ["4","5","6","1","2","3","7","8","9"]
        pzl.shiftRight(&Artn, shifters: shiftArray)
        XCTAssertEqual(Ertn, Artn, "testShiftRight: shifted as expected!")
        
        Artn = ["1","2","3","4","5","6","7","8","9"]
        shiftArray = ["4","5","6"]
        Ertn = ["1","2","3","4","5","6","7","8","9"]
        pzl.shiftRight(&Artn, shifters: shiftArray)
        XCTAssertEqual(Ertn, Artn, "testShiftRight: shifted as expected!")
        
        Artn = ["1","2","3","4","5","6","7","8","9"]
        shiftArray = ["1","4","5"]
        Ertn = ["6","2","3","4","5","1","7","8","9"]
        pzl.shiftRight(&Artn, shifters: shiftArray)
        XCTAssertEqual(Ertn, Artn, "testShiftRight: shifted as expected!")
    }


}
