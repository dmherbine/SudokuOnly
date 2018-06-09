//
//  PersistFavGames.swift
//  Sudoku
//
//  Created by dave herbine on 7/28/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import Foundation

var favGamesArray = getFavoriteGames()
func getFavoriteGames() -> [PersistFavGames]? {
    if let persistedFavGames = NSKeyedUnarchiver.unarchiveObject(withFile: PersistFavGames.FavoritesURL.path) as? [PersistFavGames] {
        for persistedFavGame in persistedFavGames {
            print("getFavoriteGames: persistedFavGame.sFavName = \(persistedFavGame.sFavName)")
        }
        return persistedFavGames
    }
    print("getFavoriteGames: NSKeyedUnarchiver.unarchiveObjectWithFile(PersistFavGames.FavoritesURL.path!) was nil")
    return nil
}

class PersistFavGames: NSObject, NSCoding {
    
    var pSet = PzlSet()
    var sFavName = ""
    
    struct PropertyKey {
        static let savedTypeKey = "savedTypeKey"
        static let savedCLevelKey = "savedCLevelKey"
        static let savedGivenKey = "savedGivenKey"
        static let savedSolutionKey = "savedSolutionKey"
        static let savedSolvingAlgorithmKey = "savedSolvingAlgorithmKey"
        static let savedAllCandidatesKey = "savedAllCandidatesKey"
        static let savedSolvedUnitsKey = "savedSolvedUnitsKey"
        static let savedStateKey = "savedStateKey"
        static let savedPlayerAnsweredKey = "savedPlayerAnsweredKey"
        static let savedPlayerCandidatesKey = "savedPlayerCandidatesKey"        
        static let savedFavNameKey = "savedFavNameKey"
    }
    
    // MARK: Archiving Path
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let FavoritesURL = DocumentsDirectory.appendingPathComponent("favoriteGames")
    
    // prepare the class’s information to be archived
    func encode(with aCoder: NSCoder) {
        aCoder.encode(pSet.type, forKey: PropertyKey.savedTypeKey)
        aCoder.encode(pSet.cLevel, forKey: PropertyKey.savedCLevelKey)
        aCoder.encode(pSet.given, forKey: PropertyKey.savedGivenKey)
        aCoder.encode(pSet.solution, forKey: PropertyKey.savedSolutionKey)
        
        let solvingAlgorithmString = pSet.solvingAlgorithm != nil ? String(describing: pSet.solvingAlgorithm!) : "nil"
        aCoder.encode(solvingAlgorithmString, forKey: PropertyKey.savedSolvingAlgorithmKey)
        
        aCoder.encode(pSet.allCandidates, forKey: PropertyKey.savedAllCandidatesKey)
        aCoder.encode(pSet.solvedUnits, forKey: PropertyKey.savedSolvedUnitsKey)
        
        aCoder.encode(String(describing: pSet.state), forKey: PropertyKey.savedStateKey)
        
        aCoder.encode(pSet.playerAnswered, forKey: PropertyKey.savedPlayerAnsweredKey)
        aCoder.encode(pSet.playerCandidates, forKey: PropertyKey.savedPlayerCandidatesKey)
        
        aCoder.encode(sFavName, forKey: PropertyKey.savedFavNameKey)
    }
    
    // unarchive the data when the class is created
    required convenience init?(coder aDecoder: NSCoder) {
        var pSet = PzlSet()
        pSet.type = aDecoder.decodeObject(forKey: PropertyKey.savedTypeKey) as! String
        pSet.cLevel = aDecoder.decodeObject(forKey: PropertyKey.savedCLevelKey) as! Int
        pSet.given = aDecoder.decodeObject(forKey: PropertyKey.savedGivenKey) as! [String]
        pSet.solution = aDecoder.decodeObject(forKey: PropertyKey.savedSolutionKey) as! [String]
        
        let solvingAlgorithmString = aDecoder.decodeObject(forKey: PropertyKey.savedSolvingAlgorithmKey) as! String
        switch solvingAlgorithmString {
        case "solvedByCP":
            pSet.solvingAlgorithm = solvingAlgo.solvedByCP
        case "solvedByPairs":
            pSet.solvingAlgorithm = solvingAlgo.solvedByPairs
        case "solvedByDF":
            pSet.solvingAlgorithm = solvingAlgo.solvedByDF
        case "solvedByT1UR":
            pSet.solvingAlgorithm = solvingAlgo.solvedByT1UR
        default:
            pSet.solvingAlgorithm = nil
        }
        
        pSet.allCandidates = aDecoder.decodeObject(forKey: PropertyKey.savedAllCandidatesKey) as! [String]
        pSet.solvedUnits = aDecoder.decodeObject(forKey: PropertyKey.savedSolvedUnitsKey) as! [Int]
        
        let stateString = aDecoder.decodeObject(forKey: PropertyKey.savedStateKey) as! String
        switch stateString {
        case "invalid":
            pSet.state = states.invalid
        case "solved":
            pSet.state = states.solved
        default:
            pSet.state = states.valid
        }
        
        pSet.playerAnswered = aDecoder.decodeObject(forKey: PropertyKey.savedPlayerAnsweredKey) as! [String]
        pSet.playerCandidates = aDecoder.decodeObject(forKey: PropertyKey.savedPlayerCandidatesKey) as! [String]
        
        let sFN = aDecoder.decodeObject(forKey: PropertyKey.savedFavNameKey) as! String
        
        // Must call designated initializer
        self.init(gStack: pSet, fn: sFN)
    }
    
    init(gStack: PzlSet, fn: String) {
        //Initialize Stored Properties
        //print("savedGame: init gStack = \(gStack)")
        self.pSet.type = gStack.type
        self.pSet.cLevel = gStack.cLevel
        self.pSet.given = gStack.given
        self.pSet.solution = gStack.solution
        //print("savedGame: init gStack.solvingAlgorithm = \(gStack.solvingAlgorithm)")
        self.pSet.solvingAlgorithm = gStack.solvingAlgorithm
        self.pSet.allCandidates = gStack.allCandidates
        self.pSet.solvedUnits = gStack.solvedUnits
        self.pSet.state = gStack.state
        self.pSet.playerAnswered = gStack.playerAnswered
        self.pSet.playerCandidates = gStack.playerCandidates
        self.sFavName = fn
    }

}
