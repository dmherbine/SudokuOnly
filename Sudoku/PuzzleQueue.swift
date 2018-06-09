//
//  PuzzleQueue.swift
//  Sudoku
//
//  Created by dave herbine on 8/12/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

class PuzzleQueue: NSObject {
    
    // Queue of PzlSets
    var pzlQueue = [PzlSet]()

    var puzzle = Puzzle()
    
    override init() {
        // Initialize the puzzle queue with seeded puzzles for a quick start        
        for i in 0...4 {
            pzlQueue.append(puzzle.generateSeededPuzzleWithChallengeLevel(i))
        }
    }
        
    func popPuzzleQueueWithChallengeLevel(_ challengeLevel: Int) -> PzlSet {
        var returnPset = PzlSet()
        
        let pSetsOfChallengeLevel = pzlQueue.enumerated().filter() { $0.element.cLevel == challengeLevel }
        if pSetsOfChallengeLevel.count < 1 {
            print("popPuzzleQueueWithChallengeLevel: no puzzles in the queue for challenge of \(challengeLevel)")
            returnPset = puzzle.generateSeededPuzzleWithChallengeLevel(challengeLevel)
            //returnPset = puzzle.generatePuzzleWithChallenge(challengeLevel)
        } else {
//            returnPset = pzlQueue.remove(at: pSetsOfChallengeLevel[0].index)
            returnPset = pzlQueue.remove(at: pSetsOfChallengeLevel[0].offset)
//            returnPset = pzlQueue.removeAtIndex(pSetsOfChallengeLevel[0].index)   // swift 2.2
        }
        
        // Generate another puzzle off the main queue so the player is not blocked
        //  Tasks in concurrent queues are guaranteed to start in the order they were added… and that’s about all you’re guaranteed
        //  Items can finish in any order and you have no knowledge of the time it will take for the next task to start,
        //  nor the number of tasks that are running at any given time. Again, this is entirely up to Grand Central Dispatch (GCD).
        //
        //  QOS_CLASS_UTILITY: The utility class represents long-running tasks, typically with a user-visible progress indicator.
        //  Use it for computations, I/O, networking, continous data feeds and similar tasks. This class is designed to be energy efficient.
        //
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
        queue.async { () -> Void in
            self.pzlQueue.append(self.puzzle.generatePuzzleWithChallenge(challengeLevel))
        }
//        pzlQueue.append(puzzle.generatePuzzleWithChallenge(challengeLevel))
    
        return returnPset
    }
    
    func pushSeedPuzzleOnPuzzleQueueWithChallengeLevel(_ challengeLevel: Int) {
        pzlQueue.append(puzzle.generateSeededPuzzleWithChallengeLevel(challengeLevel))
    }
    
    func pushPzlSetOnPuzzleQueueWithChallengeLevel(_ pSet: PzlSet, challengeLevel: Int) {
        pzlQueue.append(pSet)
    }
    
    //Create a class variable as a computed type property. The class variable can be called without having to instantiate the class PuzzleQueue
    class var globalVar: PuzzleQueue {
        
        //Nested within the class variable is a struct called "Singleton"
        struct Singleton {
            
            //Singleton wraps a static constant variable "instance". Declaring a property as static means this property only exists once. Also note that static properties in Swift are implicitly lazy, which means that Instance is not created until it’s needed.
            static let instance = PuzzleQueue()
        }
        
        return Singleton.instance
    }
}

