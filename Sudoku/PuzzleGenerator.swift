//
//  PuzzleGenerator.swift
//  Sudoku
//
//  Created by dave herbine on 7/31/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

// TODO: 4/9/2016 - Going to use the Arto seed puzzle as is for developing/testing out Hints development.
//  I'll need to come back and remove this once it's working or I have an alternate way.
let hintsDevelopment = true

extension Puzzle {

    func generateSeededPuzzleWithChallengeLevel(_ challengeLevel: Int) -> PzlSet {
        
        var pSet = PzlSet()
        
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
        let solvedBySeeds = [solvingAlgo.solvedByCP, solvingAlgo.solvedByCP, solvingAlgo.solvedByCP, solvingAlgo.solvedByPairs, solvingAlgo.solvedByT1UR]
        let cLevelSeeds = [0, 1, 2, 3, 4]
        
        (pSet.given, pSet.solution) = newPermutation(givenSeeds[challengeLevel], solutionPuzzle: solutionSeeds[challengeLevel])
        pSet.solvingAlgorithm = solvedBySeeds[challengeLevel]
        pSet.cLevel = cLevelSeeds[challengeLevel]
        pSet.type = "classic"
        pSet.playerAnswered = pSet.given
        pSet.allCandidates = generateAllCandidatesFromAnswered(pSet)
        
        return pSet
    }
    
    func generatePuzzleWithChallenge(_ challengeLevel: Int) -> PzlSet {
        return generateNewPzlSetWithChallenge(generateTerminalPuzzle(), challengeLevel: challengeLevel)
    }
    
    func generateTerminalPuzzle() -> [String] {
        
        var pSet = PzlSet()
        
        pSet.playerAnswered = createPuzzle()
        
        let preUniqueSolutionsCount = uniquePuzzleSolutions.count
        
        var algo = Solution(strategy: ConstraintPropagation())
        let solvePuzzleByCP = algo.strategy.tryAlgo(pSet, DFGoal.proper, nil)

        algo = Solution(strategy: DepthFirst())
        
        pSet = algo.strategy.tryAlgo(solvePuzzleByCP, DFGoal.terminal, nil)
        
        // Restore uniquePuzzleSolutions
        while uniquePuzzleSolutions.count-1 > preUniqueSolutionsCount {
            uniquePuzzleSolutions.removeLast()
        }
        
        // TODO:    I should ensure generateTerminalPuzzle() returns a valid terminal puzzle (perhaps a hard coded one, if needed).
        
        return pSet.playerAnswered
    }
    
    
    
    func generateNewPzlSetWithChallenge(_ TerminalPuzzle: [String], challengeLevel: Int) -> PzlSet {
        
        var candidateHoles = [Int]()
        var runPzl = PzlSet()
        runPzl.solution = TerminalPuzzle
        runPzl.playerAnswered = TerminalPuzzle
        runPzl.cLevel = challengeLevel
        runPzl.given = runPzl.playerAnswered
        runPzl.state = .valid
        runPzl.solvingAlgorithm = nil
        
        // Setup for the start of digging by removing 9 cells - one from each unit (rows, cols, or blocks)
        for col in PuzzleLets.globalVar.unitsCols {
            let colHole = Int(arc4random_uniform(UInt32(col.count)))
            let colRemaining = col.filter() { $0 != colHole }
            candidateHoles = [candidateHoles, colRemaining].flatMap { $0 }
            runPzl.given[colHole] = ""
        }
        
        var lastPzl = PzlSet()
        lastPzl.solution = TerminalPuzzle
        lastPzl.playerAnswered = TerminalPuzzle
        lastPzl.cLevel = challengeLevel
        lastPzl.given = lastPzl.playerAnswered
        lastPzl.state = .valid
        lastPzl.solvingAlgorithm = nil

        var candidateHole = 0
        
        // Research suggests 17 <= givens <= 32, but I'll keep a 50 for now to help with testing
        var gTarget = 27
        switch challengeLevel
        {
        case 0:
            gTarget = 50
        case 1:
            gTarget = 35    // TODO:    Make it random among 35...38
        case 2:
            gTarget = 30    // TODO:    Make it random in 30...34
        case 3:
            gTarget = 28    // TODO:    Make it random in 26...29
        case 4:
            gTarget = 26    // TODO:    Make it random in 22...26
        default:
            gTarget = 32
        }
        var givenCount = 81 - 9
        var neededCount = gTarget - givenCount
        
        repeat {
            //let givenCount = runPzl.given.filter() { $0.characters.count == 1 }.count
            neededCount = gTarget - givenCount
            if candidateHoles.count < neededCount || candidateHoles.isEmpty {
                print("generateGivenPuzzleWithChallenge: remaining candidateHoles.count (\(candidateHoles.count)) insufficient to reach target (\(gTarget)) with \(givenCount) givens.  Need \(neededCount)")
                let seedPuzzle = generateSeededPuzzleWithChallengeLevel(challengeLevel)
                return seedPuzzle
            }
            
            candidateHole = Int(arc4random_uniform(UInt32(candidateHoles.count)))
            //print("generateGivenPuzzleWithChallenge: candidateHoles.count = \(candidateHoles.count), candidateHole = \(candidateHole), target = \(gTarget)")
            
            // remove the candidate hole from gPuzzle and set localPuzzle to gPuzzle ...
            //  ... remember, localPuzzle will be returned as a solved puzzle!  The Terminal puzzle.
            runPzl.given[candidateHoles[candidateHole]] = ""
            runPzl.playerAnswered = runPzl.given
            runPzl.state = .valid
            runPzl.solvingAlgorithm = nil
            if let threeIndexes = PuzzleLets.globalVar.indexesOfUnitsDict[candidateHoles[candidateHole]] {
                for index in threeIndexes {
                    for (indx, unit) in runPzl.solvedUnits.enumerated() {
                        if unit == index {
                            runPzl.solvedUnits.remove(at: indx)
                            continue
                        }
                    }
                }
            }
            candidateHoles.remove(at: candidateHole) // Always remove, it's cell will be restored or left as ""
            // Ensure it is a proper puzzle
            runPzl = candidateHoles.count == gTarget ? runAlgorithms(runPzl, DFGoal.proper).pzlset : validatePzlSet(runPzl, DFGoal.proper)
//            print("generateNewPzlSetWithChallenge: runAlgorithms results: state = \(runPzl.state), solvedUnits.count = \(runPzl.solvedUnits.count), solvingAlgorithm = \(runPzl.solvingAlgorithm)")
            
            // Only interested in a solved puzzle - meaning a successful dig
            if runPzl.state == states.solved {
                givenCount -= 1
                lastPzl.playerAnswered = runPzl.given
                lastPzl.given = runPzl.given
                lastPzl.solvingAlgorithm = runPzl.solvingAlgorithm
                if candidateHoles.count == gTarget {
                    break
                }
            } else {
                //bad guess so restore and keep trying
                runPzl.given = lastPzl.given
                runPzl.solvedUnits = lastPzl.solvedUnits
            }
        } while true
        
        lastPzl.type = "new"
        lastPzl.state = .valid
        lastPzl.allCandidates = generateAllCandidatesFromAnswered(lastPzl)

        return lastPzl
    }
    
    //
    // runAlgorithms() has two use cases:  First is during puzzle creation where it ensures it is a proper puzzle, so it must run as many algorithms as needed
    //  to ensure a single solution or possibly an invalid puzzle.
    //  Second use case is for Player Help where I am also checking each algorithm, but will return if an algorithm determines the puzzle
    //  is valid but has an assigned cell that is not already ansered by the player.
    //
    func runAlgorithms(_ pzl: PzlSet, _ untilSolutions: DFGoal) -> (pzlset: PzlSet, solution: Solution) {
        let pzlIn = pzl
        
        let algoCP = Solution(strategy: ConstraintPropagation())
        let algoPairs = Solution(strategy: Tuples())
        let algoUR = Solution(strategy: UniqueRectangles())
        let algoDF = Solution(strategy: DepthFirst())
        
        //
        // Always start with ConstraintPropagation
        //
        let pzlCP = algoCP.strategy.tryAlgo(pzlIn, nil, nil)
        switch pzlCP.state {
        case .invalid:
            //print("runAlgorithms: puzzle determined invalid by ConstraintPropagation")
            return (pzlCP, algoCP)
        case .solved:
            //print("runAlgorithms: puzzle solved by ConstraintPropagation")
            //print("\(pzlCP)")
            if let unitSolvingAssign = getUnitSolvingAssign(algoCP, pzl, pzlCP) {
                //print("runAlgorithms: unitSolvingAssign = \(unitSolvingAssign)")
                algoCP.strategy.cpAssigns = unitSolvingAssign
            }
            return (pzlCP, algoCP)
        case .valid:
            //print("runAlgorithms: CP valid: cpAssigns.count: \(algoCP.strategy.cpAssigns?.count)")
            //print("runAlgorithms: CP valid: cpAssigns: \(algoCP.strategy.cpAssigns)")
            let cpAssignsLessAnswered = algoCP.strategy.cpAssigns.filter({ $0.value != pzlIn.playerAnswered[$0.square] })
            if !algoCP.strategy.cpAssigns.isEmpty && cpAssignsLessAnswered.count > 1 && untilSolutions == .help {
                if let unitSolvingAssign = getUnitSolvingAssign(algoCP, pzl, pzlCP) {
                    algoCP.strategy.cpAssigns = unitSolvingAssign
                }
                return (pzlCP, algoCP)
            }
            break
        }
        
        //
        // Should be valid by ConstraintPropagation so lets try to solve by Pairs
        //
        let pzlPairs = algoPairs.strategy.tryAlgo(pzlCP, nil, nil)
        switch pzlPairs.state {
        case .invalid:
            //print("runAlgorithms: puzzle determined valid by ConstraintPropagation but invalid by Pairs")
            return (pzlPairs, algoPairs)
        case .solved:
            //print("runAlgorithms: puzzle determined valid by ConstraintPropagation but solved by Pairs")
            //print("\(pzlPairs)")
            //print("runAlgorithms: Pairs: algorithm: \(algoPairs.strategy.algorithm)")
            //print("runAlgorithms: Pairs: cpAssigns: \(algoPairs.strategy.cpAssigns)")
            if let unitSolvingAssign = getUnitSolvingAssign(algoPairs, pzlCP, pzlPairs) {
                algoPairs.strategy.cpAssigns = unitSolvingAssign
            }
            return (pzlPairs, algoPairs)
        case .valid:
            //print("runAlgorithms: puzzle determined valid by ConstraintPropagation but solved by Pairs")
            let cpAssignsLessAnswered = algoPairs.strategy.cpAssigns.filter({ $0.value != pzlIn.playerAnswered[$0.square] })
            if !algoPairs.strategy.cpAssigns.isEmpty && cpAssignsLessAnswered.count > 1 && untilSolutions == .help {
                if let unitSolvingAssign = getUnitSolvingAssign(algoPairs, pzlCP, pzlPairs) {
                    algoPairs.strategy.cpAssigns = unitSolvingAssign
                }
                return (pzlPairs, algoPairs)
            }
            break
        }
        
        //
        // Should be valid first by ConstraintPropagation and then Pairs so lets try UniqueRectangles
        //
        let pzlUR = algoUR.strategy.tryAlgo(pzlPairs, nil, algoPairs.strategy.allPairs)
        switch pzlUR.state {
        case .invalid:
            //print("runAlgorithms: puzzle determined valid by Pairs but invalid by UniqueRectangles")
            return (pzlUR, algoUR)
        case .solved:
            //print("runAlgorithms: puzzle determined valid by Pairs but solved by UniqueRectangles")
            //print("\(pzlUR)")
            if let unitSolvingAssign = getUnitSolvingAssign(algoUR, pzlPairs, pzlUR) {
                algoUR.strategy.cpAssigns = unitSolvingAssign
            }
            return (pzlUR, algoUR)
        case .valid:
            //print("runAlgorithms: puzzle determined valid by Pairs and valid by UniqueRectangles")
            let cpAssignsLessAnswered = algoPairs.strategy.cpAssigns.filter({ $0.value != pzlIn.playerAnswered[$0.square] })
            if !algoUR.strategy.cpAssigns.isEmpty && cpAssignsLessAnswered.count > 1 && untilSolutions == .help {
                if let unitSolvingAssign = getUnitSolvingAssign(algoUR, pzlPairs, pzlUR) {
                    algoUR.strategy.cpAssigns = unitSolvingAssign
                }
                return (pzlUR, algoUR)
            }
            break
        }

        //
        // Should be valid first by ConstraintPropagation, then Pairs, and then UniqueRectangles so lets try DepthFirst
        //
        // help == true implies a proper puzzle so the algorithm need only find atLeast one solution.  Otherwise I need to ensure only one solution.
//        let pzlDF = help ? algoDF.strategy.tryAlgo(pzlUR, Found.terminal, nil) : algoDF.strategy.tryAlgo(pzlUR, Found.improper, nil)
        let pzlDF = algoDF.strategy.tryAlgo(pzlUR, untilSolutions, nil)
        switch pzlDF.state {
        case .invalid:
            //print("runAlgorithms: puzzle determined valid by UniqueRectangles but invalid by DepthFirst")
            return (pzlDF, algoDF)
        case .solved:
            //print("runAlgorithms: puzzle determined valid by UniqueRectangles but solved by DepthFirst")
            //print("\(pzlDF)")
            if let unitSolvingAssign = getUnitSolvingAssign(algoDF, pzlUR, pzlDF) {
                algoDF.strategy.cpAssigns = unitSolvingAssign
            }
            return (pzlDF, algoDF)
        case .valid:
            print("runAlgorithms: puzzle determined valid by Depth First!  This should never happen!!")
            break
        }
        return (pzlDF, algoDF)
    }
    
    //
    // getUnitSolvingAssign(algo, prePzl, postPzl) returns an assigned digit that matches a singular candidate, solves a unit or nil.
    //  algo is the Solution to algortihm and contains the array of assigned digits
    //  prePzl is the input puzzle to the algo algorithm.
    //  postPzl is the output puzzle of the algo algorithm.
    //
    func getUnitSolvingAssign(_ algo: Solution, _ prePzl: PzlSet, _ postPzl: PzlSet) -> [Cell]? {
        if !algo.strategy.cpAssigns.isEmpty { // otherwise return nil
            
            // First, see if there are any singular candidates
            let singularAllCandidatesTuples = postPzl.allCandidates.enumerated().map({Cell(i: $0.offset, e: $0.element)}).filter() { $0.value.count == 1 }
            if singularAllCandidatesTuples.count > 0 {
                for assigned in algo.strategy.cpAssigns {
                    for singular in singularAllCandidatesTuples {
                        if assigned == singular {
                            return algo.strategy.cpAssigns.filter() { $0 == assigned }
                        }
                    }
                }
            }
            
            // Second, see if there are newly solved units
            // 1) Filter the assigns array [(index: Int, element: String)] to the subset that are newly answered
            let cpAssignsLessAnswered = algo.strategy.cpAssigns.filter() { $0.value != prePzl.playerAnswered[$0.square] }
            if cpAssignsLessAnswered.count > 0 {
                
                // 2) Ensure their is at least one newly solved unit as a result of the algorithm
                if postPzl.solvedUnits.count > prePzl.solvedUnits.count {
                    
                    // 3) Get the array [Int] of new solved units by filtering the postPzl solvedUnits to those units not in prePzl's solvedUnits
                    let newSolvedUnits = postPzl.solvedUnits.filter() { !prePzl.solvedUnits.contains($0) }
                    if !newSolvedUnits.isEmpty {
                        
                        // 4) Get the indexes [Int] from the subset of assigns [(index: Int, element: String)] from step 1)
                        //if let cpAssignsLessAnsweredIndexes = cpAssignsLessAnswered?.enumerated().map({$0.offset}) {
                            let cpAssignsLessAnsweredIndexes = cpAssignsLessAnswered.map({$0.square})
                            if !cpAssignsLessAnsweredIndexes.isEmpty {
                            
                            // 5) Cycle through each newly solved unit found in step 3)
                            for newSolvedUnit in newSolvedUnits {
                                
                                // 6) Filter the indexes found in step 4) to those found in the units of the curren newSolvedUnit
                                let cpAssignsLessAnsweredIndexesInNewSolvedUnit = cpAssignsLessAnsweredIndexes.filter({ PuzzleLets.globalVar.unitsArray[newSolvedUnit].contains($0) })
                                if !cpAssignsLessAnsweredIndexesInNewSolvedUnit.isEmpty {
                                    
                                    // 7) Filter the algorithm's assigns array to those with an index that matches a newly solved unit and return if found
                                    let unitSolvingAssign = cpAssignsLessAnswered.filter({ cpAssignsLessAnsweredIndexesInNewSolvedUnit.contains($0.square)})
                                    if !unitSolvingAssign.isEmpty {
                                        return unitSolvingAssign
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
    
    //
    // validatePzlSet() runs an incoming puzzle against only CP and, if needed, DF algorithms.  Intended use is for performance improvement of hole digging.
    //
    func validatePzlSet(_ pzl: PzlSet, _ untilSolutions: DFGoal) -> PzlSet {
        let pzlIn = pzl
        
        let algoCP = Solution(strategy: ConstraintPropagation())
        let algoDF = Solution(strategy: DepthFirst())
        
        //
        // Always start with ConstraintPropagation
        //
        let pzlCP = algoCP.strategy.tryAlgo(pzlIn, nil, nil)
        switch pzlCP.state {
        case .invalid:
            return pzlCP
        case .solved:
            return pzlCP
        case .valid:
            break
        }
        
        //
        // Should be valid by ConstraintPropagation so lets try DepthFirst
        //
        let pzlDF = algoDF.strategy.tryAlgo(pzlCP, DFGoal.improper, nil)
        switch pzlDF.state {
        case .invalid:
            return pzlDF
        case .solved:
            return pzlDF
        case .valid:
            break
        }
        return pzlDF
    }
    
    
    //
    // generateAllCandidatesFromAnswered() takes an input puzzle and returns a puzzle where the cells that correspond to holes in the playerAnswered puzzle
    //  are filled with all candidate digits not found in the three peer units of the given puzzle
    //
    //  If the input puzzle was solved by ConstraintPropagation, I return a simple version of AllCandidates.
    //  Otherwise, I return the result of the ConstraintPropagation Algorithm
    //
    func generateAllCandidatesFromAnswered(_ pSet: PzlSet) -> [String] {
        var allCandidates = [String](repeating: "", count: 81)
        
        for (idx, value) in pSet.playerAnswered.enumerated() {
            // if the given puzzle's value is "", then the corresponding candidates value should be set
            if value == "" {
                var answered = ""
                if let peersIndexes = PuzzleLets.globalVar.peersDict[idx] {
                    for peer in peersIndexes {
                        answered += pSet.playerAnswered[peer]
                    }
                    let candidatesArray = ["1","2","3","4","5","6","7","8","9"].filter { answered.range(of: $0) == nil }
                    allCandidates[idx] = candidatesArray.reduce("", {$0 + $1})  // combines the array of candidate digits into a string
                } else {
                    print("generateAllCandidatesFromGiven: could not find key = \(idx) in peersDict!")
                }
            }
        }
        
        return allCandidates
    }
    
    //
    // createPuzzle() randomly fills the three peer units of A1 as follows:
    //  three random arrays are used to fill the three peer units
    //  the first unit is easy - it simply fills the values of units with random digits
    //  the second unit needs to ensure that the value of "A1" is maintained and that the first 3 values of the first unit are shifted to avoid
    //  a constraint violation.  The third unit needs to remove the five random digits from its random array to avoid a constraint violation
    //
    func createPuzzle() -> [String] {
        
        // Start with each square having all possible values
        var cGrid = [String](repeating: "123456789", count: 81)
        
        // get the peer units of square A1
        if let peerUnitsOfA1 = PuzzleLets.globalVar.indexesOfUnitsDict[0] {
            
            // get three random arrays
            let unitArray = [String](repeating: "", count: 9)
            var randomArray1 = randomFill(unitArray)
            var randomArray2 = randomFill(unitArray)
            var randomArray3 = randomFill(unitArray)
            
            //print("createPuzzle: randomArray1 = \(randomArray1)")
            //print("createPuzzle: randomArray2 = \(randomArray2)")
            //print("createPuzzle: randomArray3 = \(randomArray3)")
            
            // replace the first unit's squares in cGrid with random digits
            let firstUnitIndexes = PuzzleLets.globalVar.unitsArray[peerUnitsOfA1[0]]
            for (idx, key) in firstUnitIndexes.enumerated() {
                cGrid[key] = randomArray1[idx]
            }
            
            // create the shift array
            var shiftArray = [String](repeating: "", count: 3)
            for i in 0...2 {
                shiftArray[i] = randomArray1[i]
            }
            
            // shift the array to avoid a possible constraint violation:
            //  the first 3 (gridRank) values of randomArray1 will not be in randomArray2
            shiftRight(&randomArray2, shifters: shiftArray)
            //print("createPuzzle: randomArray2 = \(randomArray2)")
            
            // restore A1 of randomArray2 to A1 of randomArray1
            //  the same value used for the top row by swapping A1's value in this new array.
            let A1 = cGrid[0]
            if let index = randomArray2.index(of: A1) {
                //print("createPuzzle: index = \(index) for \(A1) in \(randomArray)")
                randomArray2[index] = randomArray2[0]
                randomArray2[0] = A1
            } else {
                print("createPuzzle: grid[\"A1\"]! not found")
            }
            //print("createPuzzle: randomArray2 = \(randomArray2)")
            
            // replace the second unit with random values
            let secondUnitIndexes = PuzzleLets.globalVar.unitsArray[peerUnitsOfA1[1]]
            for (idx, key) in secondUnitIndexes.enumerated() {
                cGrid[key] = randomArray2[idx]
            }
            
            //print("createPuzzle: randomArray3 = \(randomArray3)")
            // create the white list by removing accounted for values from randomArray3
            let thirdUnitIndexes = PuzzleLets.globalVar.unitsArray[peerUnitsOfA1[2]]
            for key in thirdUnitIndexes {
                if let idx = randomArray3.index(of: cGrid[key]) {
                    randomArray3.remove(at: idx)
                }
            }
            //print("createPuzzle: randomArray3 = \(randomArray3)")
            
            // replace third unit values of "123456789" with remaining randomArray3 values
            for key in thirdUnitIndexes {
                let values = cGrid[key]
                if values == "123456789" {
                    cGrid[key] = randomArray3[0]
                    randomArray3.remove(at: 0)
                }
            }
        }
        return cGrid        
    }

    //
    // randomFill() returns an array of random and unique values of the length of the input array.
    //
    func randomFill(_ strArray: [String]) -> [String] {
        
        let cnt = strArray.count
        var randArray = [String]()
        
        while randArray.count < cnt {
            let r = Int(arc4random_uniform(UInt32(cnt))) + 1
            if !randArray.contains(String(r)) {
                randArray.append(String(r))
            }
        }
        return randArray
    }

    //
    // shiftRight() returns the array with the shifters members shifted to the right
    //
    func shiftRight(_ unit: inout [String], shifters: [String]) {
        
        for shifter in shifters {
            if let unitVal = unit.index(of: shifter) {    //find(unit, shifter) {
                if unitVal < shifters.count {
                    for idx in shifters.count...unit.count {
                        if (shifters.index(of: unit[idx]) != nil) {    // _ was unitIdx but never used 11/1/2015 Xcode upgrade
                            continue
                        } else {
                            let swapString = unit[idx]
                            unit[idx] = unit[unitVal]
                            unit[unitVal] = swapString
                            break
                        }
                    }
                }
            }
        }
        return
    }
    
}
