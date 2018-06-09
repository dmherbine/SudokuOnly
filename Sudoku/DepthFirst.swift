//
//  DepthFirst.swift
//  Sudoku
//
//  Created by dave herbine on 3/20/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import Foundation

//
// DepthFirst essentially feeds assign() which performs constraint propagation.
//

// define the intended exit criteria for the Depth First algorithm
enum DFGoal: CustomStringConvertible {
    case help
    case terminal
    case improper
    case proper
    
    var description: String {
        get {
            switch self {
            case .help:
                return "help"
            case .terminal:
                return "terminal"
            case .improper:
                return "improper"
            case .proper:
                return "proper"
            }
        }
    }
}

class DepthFirst: SolutionStrategy {
    
    // define the return structure for finding minimun remaining values of a puzzle
    struct GridMRV {
        var square: Int?
        var values: String?
    }
    
    var uniqueSolutions = [[String]]()    // array of arrays and has to be a class property
    
    var algorithm: String? = "Depth First Guess"
    var eliminates = [String](repeating: "", count: 81)
    var allPairs: [Cell]? = nil
    var reducibleNakedPairs: [Cell]? = nil
    var reducibleHiddenPairs: [Cell]? = nil
    var cpAssigns = [Cell]()
    var algoEliminates: [AlgoEliminates]? = nil
    var algoAssigns: [AlgoAssigns]? = nil
    var pzzlSet = PzlSet()
    
    func  tryAlgo(_ pzl: PzlSet, _ dfGoal: DFGoal?, _ pairs: [Cell]?) -> PzlSet {
        pzzlSet = pzl
        
        // Check if the puzzle actually needs to be solved
        if pzzlSet.playerAnswered == pzzlSet.solution {
            pzzlSet.state = .solved
            uniqueSolutions.append(pzzlSet.playerAnswered)
            return pzzlSet
        }
        if pzzlSet.state == .invalid {
            return pzzlSet
        }
        
        let howManySolutions = dfGoal != nil ? dfGoal! : DFGoal.proper
        pzzlSet = solve(pzl, howManySolutions)
        if pzzlSet.state == .solved {
            pzzlSet.solvingAlgorithm = .solvedByDF
        }
        return pzzlSet
    }
    
    //
    // solve() calls search() to find all solutions to a puzzle.
    //
    func solve(_ pString: PzlSet, _ dfGoal: DFGoal) -> PzlSet {

        var solvePuzzle = pString
        
        solvePuzzle = search(solvePuzzle, dfGoal)
        
        if uniqueSolutions.count == 1 {
            solvePuzzle.playerAnswered = uniqueSolutions[0]
            solvePuzzle.state = .solved
        } else if uniqueSolutions.isEmpty {
            solvePuzzle.state = .invalid
            solvePuzzle.solvingAlgorithm = nil
        } else {
            let lastSolution = uniqueSolutions.count-1
            solvePuzzle.playerAnswered = uniqueSolutions[lastSolution]  // use the last solution since algoAssigns will be set based on the last solution
            solvePuzzle.state = .invalid
            solvePuzzle.solvingAlgorithm = nil
        }

        return solvePuzzle
    }


    //
    // search() controls the depth-first search and passes to some() which recursively calls search().
    //
    func search(_ searchPuzzle: PzlSet, _ dfGoal: DFGoal) -> PzlSet {

        switch searchPuzzle.state {

        case .solved:
            //print("search: returning because puzzle is solved")
            return searchPuzzle

        case .invalid:
            //print("search: returning because of invalid input")
            return searchPuzzle

        case .valid:
            if dfGoal == .proper || (uniqueSolutions.count <= 2 && dfGoal == .improper) || (uniqueSolutions.count <= 1 && dfGoal == .terminal) || (dfGoal == .help && cpAssigns.isEmpty) {
                // get square with minimimu remaining values
                let mrv = getMRV(searchPuzzle.playerAnswered)
                //print("search: getMRV() returned index: \(mrv.square!) and value: \(mrv.values!)")
                if mrv.square != nil && mrv.values != nil {
                    return some(searchPuzzle, mrv.square!, mrv.values!, dfGoal)
                } else {
                    print("search: getMRV() returned nil")
                }
            }

        }
        return searchPuzzle
    }

    //
    // getMRV returns the square and it's values representing the minimum remaining values
    //
    func getMRV(_ grid: [String]) -> GridMRV {

        // initialize mrv.values to something that will ensure replacement or indicate no values of 2...9 were found
        var mrv = GridMRV(square: nil, values: nil)

        // cycle through the puzzle
        for (idx, values) in grid.enumerated() {
            switch values.count {
            case 1:
                continue
            case 2:
                mrv = GridMRV(square: idx, values: values)
                return mrv
            case 3...9:
                if mrv.values == nil {
                    mrv = GridMRV(square: idx, values: values)
                } else {
                    if values.count < mrv.values!.count {
                        mrv = GridMRV(square: idx, values: values)
                    }
                }
            default:
                print("getMRV: unexpected count of \(values.count) in switch statement for value: \(values) in square: \(idx)")
                printPuzzle(grid)
                mrv = GridMRV(square: idx, values: values)
                return mrv
            }
        }
        return mrv

    }

    //
    // some() calls search() for each of the minimum remaining values of a square.
    //
    func some(_ somePuzzle: PzlSet, _ s: Int, _ vals: String, _ dfGoal: DFGoal) -> PzlSet {

        for digit in vals {
            //println("some: trying digit: \(digit)")
            let cp = ConstraintPropagation()
            var cpPuzzle = somePuzzle
            cpPuzzle = search(cp.assign(&cpPuzzle, key: s, digit: String(digit), nil), dfGoal)

            switch cpPuzzle.state {
            case .invalid:
                //print("some: got a DF search invalid solution!")
                //return cpPuzzle     // returning the bad puzzle prevents the solution from being found!
                break

            case .valid:
                //print("some: got a DF search valid solution:")
                //return cpPuzzle     // returning the valid puzzle prevents ALL solutions from being found!
                if !cp.cpAssigns.isEmpty && dfGoal == .help {
                    cpAssigns = cp.cpAssigns
                    algoAssigns = [AlgoAssigns]()
                    populateDFAssigns(digit, vals, s)
                    return cpPuzzle
                }

            case .solved:
                //print("some: got a DF search solution:")
                //printPuzzle(copyPuzzle.puzzle)
                // check to see if it is a unique solution and, if so, add to the array of solutions
                if !cp.cpAssigns.isEmpty {
                    cpAssigns = cp.cpAssigns
                    algoAssigns = [AlgoAssigns]()
                    populateDFAssigns(digit, vals, s)
                }
                if uniqueSolutions.isEmpty {
                    uniqueSolutions.append(cpPuzzle.playerAnswered)
                } else {
                    var doesSolutionAlreadyExist = false
                    for solvedPuzzle in uniqueSolutions {
                        // check to see if it is a different solution and, if so, add it to the collection
                        if solvedPuzzle == cpPuzzle.playerAnswered {
                            doesSolutionAlreadyExist = true
                            break
                        }
                    }
                    if !doesSolutionAlreadyExist {
                        uniqueSolutions.append(cpPuzzle.playerAnswered)
                    }
                }
                //print("some: DF search found \(uniqueSolutions.count) unique solution(s)")
                if dfGoal == .help || (uniqueSolutions.count >= 2 && dfGoal == .improper) || (uniqueSolutions.count >= 1 && dfGoal == .terminal) { return cpPuzzle }
                
            }
        }
        
        return somePuzzle
    }

    func populateDFAssigns(_ digit: Character, _ vals: String, _ square: Int) {
        // create array of highlight Help Cells
        let delArray = vals.characters.filter { String($0) != String(digit) }
        let delString = delArray.reduce("", {String($0) + String($1)})
        var highlightHelpCells = [HelpCell]()
        highlightHelpCells.append(HelpCell(sq: square, ans: String(digit), del: delString, alg: ""))

        algoAssigns?.append(AlgoAssigns(aCell: Cell(i: square, e: String(digit)), hhCells: highlightHelpCells, aAlgo: algorithm!))
    }
    
}

