//
//  GameStack.swift
//  Sudoku
//
//  Created by dave herbine on 4/17/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

//
// GameStack enables the player to undo moves while playing
//
class GameStack {

    fileprivate var puzzleStack = [PzlSet]()
        
    func getPuzzlesStackDepth() -> Int {
        return puzzleStack.count
    }

    func pushPuzzlesOnStack(_ pStackset: PzlSet) -> Int {
        puzzleStack.append(pStackset)
        return puzzleStack.count
    }
    
    func replacePuzzlesOnStack(_ newPuzzleStack: PzlSet) -> Int {
        // remove last entry in stack - had to follow an "Answer"
        _ = popPuzzlesFromStack()
        puzzleStack.append(newPuzzleStack)        
        return puzzleStack.count
    }
    
    func popPuzzlesFromStack() -> PzlSet? {
        switch puzzleStack.count {
        case 0:
//            print("Pop: stack isEmpty, returning nil - stackDepth = \(puzzleStack.count)")
            return nil
        case 1:
//            print("Pop: stack contains only current puzzle, returning nil - stackDepth = \(puzzleStack.count)")
            return nil
        case 2...puzzleStack.count:
//            print("Pop: stack >= 2, removeLast and return Last - stackDepth = \(puzzleStack.count)")
            puzzleStack.removeLast()
            return puzzleStack.last
        default:
            print("Pop: unexpected stackDepth of: \(puzzleStack.count), returning nil")
            return nil
        }
    }
}
