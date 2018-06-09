//
//  SavedGame.swift
//  Sudoku
//
//  Created by dave herbine on 6/29/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import Foundation

var savedGameArray = resumeGame()
func resumeGame() -> [SavedGame]? {
    if let savedGames = NSKeyedUnarchiver.unarchiveObject(withFile: SavedGame.ArchiveURL.path) as? [SavedGame] {
        if savedGames.isEmpty {
            return nil
        } else {
            return savedGames
        }
    }
    return nil
}

//
// Returns true if there is a player meaningful difference (Used to minimize data saved and Undo experience)
//
func meaningfulChange(_ sStruct: saveStruct, lastSavedGame: SavedGame) -> Bool {
    //if sStruct.pSet.allCandidates != lastSavedGame.pSet.allCandidates { return true }
    //if sStruct.pSet.cLevel != lastSavedGame.pSet.cLevel { return true }
    //if sStruct.pSet.given != lastSavedGame.pSet.given { return true }
    if sStruct.pSet.playerAnswered != lastSavedGame.pSet.playerAnswered { return true }
    if sStruct.pSet.playerCandidates != lastSavedGame.pSet.playerCandidates { return true }
    //if sStruct.pSet.solution != lastSavedGame.pSet.solution { return true }
    //if sStruct.pSet.solvedUnits != lastSavedGame.pSet.solvedUnits { return true }
    //if sStruct.pSet.solvingAlgorithm != lastSavedGame.pSet.solvingAlgorithm { return true }
    //if sStruct.sGameName != lastSavedGame.sGameName { return true }
    //if sStruct.sPlayableDigits != lastSavedGame.sPlayableDigits { return true }
    //if sStruct.sKeypadDigit != lastSavedGame.sKeypadDigit { return true }
    //if sStruct.sSolvedDigits != lastSavedGame.sSolvedDigits { return true }
    //if sStruct.sSelectedCellIndex != lastSavedGame.sSelectedCellIndex { return true }
    //if sStruct.sCandidateCntrl != lastSavedGame.sCandidateCntrl { return true }
    //if sStruct.sChallengeLevel != lastSavedGame.sChallengeLevel { return true }
    //if sStruct.sGameTimerCount != lastSavedGame.sGameTimerCount { return true }
    return false
}

struct saveStruct {
    var pSet = PzlSet()
    var sGameName: String? = nil
    var sPlayableDigits: String? = nil
    var sKeypadDigit: String? = nil
    var sSolvedDigits: String = ""
    var sSelectedCellIndex: Int? = nil
    var sCandidateCntrl: Int = 1
    var sChallengeLevel: Int = 0
    var sGameTimerCount: Int = 0
}

class SavedGame: NSObject, NSCoding {
    
    var pSet = PzlSet()
    var sGameName: String? = nil
    var sPlayableDigits: String? = nil
    var sKeypadDigit: String? = nil
    var sSolvedDigits: String
    var sSelectedCellIndex: Int? = nil
    var sCandidateCntrl: Int
    var sChallengeLevel: Int
    var sGameTimerCount: Int

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
        
        static let savedGameNameKey = "savedGameNameKey"    //String?
        static let savedPlayableDigitsKey = "savedPlayableDigitsKey"    //String?
        static let savedKeypadDigitKey = "savedKeypadDigitKey"  //String?
        static let savedSolvedDigitsKey = "savedSolvedDigitsKey"    //String
        static let savedSelectedCellIndexKey = "savedSelectedCellIndexKey"    //NSIndexPath?, but as Int?
        static let savedsCandidateCntrlKey = "savedsCandidateCntrlKey"     //Int
        static let savedChallengeLevelKey = "savedChallengeLevelKey"  //Int
        static let savedGameTimerCountKey = "savedGameTimerCountKey"  //Int
    }
    
    // MARK: Archiving Paths    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("gameData")

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
        
        aCoder.encode(sGameName, forKey: PropertyKey.savedGameNameKey)
        aCoder.encode(sPlayableDigits, forKey: PropertyKey.savedPlayableDigitsKey)
        aCoder.encode(sKeypadDigit, forKey: PropertyKey.savedKeypadDigitKey)
        aCoder.encode(sSolvedDigits, forKey: PropertyKey.savedSolvedDigitsKey)
        aCoder.encode(sSelectedCellIndex, forKey: PropertyKey.savedSelectedCellIndexKey)
        aCoder.encode(sCandidateCntrl, forKey: PropertyKey.savedsCandidateCntrlKey)
        aCoder.encode(sChallengeLevel, forKey: PropertyKey.savedChallengeLevelKey)
        aCoder.encode(sGameTimerCount, forKey: PropertyKey.savedGameTimerCountKey)
    }
    
    // unarchive the data when the class is created
    required convenience init?(coder aDecoder: NSCoder) {
        var sStruct = saveStruct()
        //var pSet = PzlSet()
        sStruct.pSet.type = aDecoder.decodeObject(forKey: PropertyKey.savedTypeKey) as! String
        //sStruct.pSet.cLevel = aDecoder.decodeInteger(forKey: PropertyKey.savedCLevelKey) //as! Int //NEW NEW 1/16/2017 got an exception trying to run/install first time on Lois's iPhone 7
        sStruct.pSet.given = aDecoder.decodeObject(forKey: PropertyKey.savedGivenKey) as! [String]
        sStruct.pSet.solution = aDecoder.decodeObject(forKey: PropertyKey.savedSolutionKey) as! [String]
        
        let solvingAlgorithmString = aDecoder.decodeObject(forKey: PropertyKey.savedSolvingAlgorithmKey) as! String
            switch solvingAlgorithmString {
            case "solvedByCP":
                sStruct.pSet.solvingAlgorithm = solvingAlgo.solvedByCP
            case "solvedByPairs":
                sStruct.pSet.solvingAlgorithm = solvingAlgo.solvedByPairs
            case "solvedByDF":
                sStruct.pSet.solvingAlgorithm = solvingAlgo.solvedByDF
            case "solvedByT1UR":
                sStruct.pSet.solvingAlgorithm = solvingAlgo.solvedByT1UR
            default:
                sStruct.pSet.solvingAlgorithm = nil
            }
        
        sStruct.pSet.allCandidates = aDecoder.decodeObject(forKey: PropertyKey.savedAllCandidatesKey) as! [String]
        sStruct.pSet.solvedUnits = aDecoder.decodeObject(forKey: PropertyKey.savedSolvedUnitsKey) as! [Int]
        
        let stateString = aDecoder.decodeObject(forKey: PropertyKey.savedStateKey) as! String
            switch stateString {
            case "invalid":
                sStruct.pSet.state = states.invalid
            case "solved":
                sStruct.pSet.state = states.solved
            default:
                sStruct.pSet.state = states.valid
            }
        
        sStruct.pSet.playerAnswered = aDecoder.decodeObject(forKey: PropertyKey.savedPlayerAnsweredKey) as! [String]
        sStruct.pSet.playerCandidates = aDecoder.decodeObject(forKey: PropertyKey.savedPlayerCandidatesKey) as! [String]
        
        //print("savedGame: pSet = \(pSet)")
        
        sStruct.sGameName = aDecoder.decodeObject(forKey: PropertyKey.savedGameNameKey) as? String
        sStruct.sPlayableDigits = aDecoder.decodeObject(forKey: PropertyKey.savedPlayableDigitsKey) as? String
        sStruct.sKeypadDigit = aDecoder.decodeObject(forKey: PropertyKey.savedKeypadDigitKey) as? String
        sStruct.sSolvedDigits = aDecoder.decodeObject(forKey: PropertyKey.savedSolvedDigitsKey) as! String
        sStruct.sSelectedCellIndex = aDecoder.decodeObject(forKey: PropertyKey.savedSelectedCellIndexKey) as? Int
        sStruct.sCandidateCntrl = aDecoder.decodeInteger(forKey: PropertyKey.savedsCandidateCntrlKey)
        //sStruct.sCandidateCntrl = aDecoder.decodeObject(forKey: PropertyKey.savedsCandidateCntrlKey) as! Int
        sStruct.sChallengeLevel = aDecoder.decodeInteger(forKey: PropertyKey.savedChallengeLevelKey)
        //sStruct.sChallengeLevel = aDecoder.decodeObject(forKey: PropertyKey.savedChallengeLevelKey) as! Int
        sStruct.sGameTimerCount = aDecoder.decodeInteger(forKey: PropertyKey.savedGameTimerCountKey)
        //sStruct.sGameTimerCount = aDecoder.decodeObject(forKey: PropertyKey.savedGameTimerCountKey) as! Int
        sStruct.pSet.cLevel = aDecoder.decodeInteger(forKey: PropertyKey.savedCLevelKey) 
        
        // Must call designated initializer
        self.init(sStruct: sStruct)
    }
    
//    init(gStack: PzlSet, gn: String?, pd: String?, kd: String?, sd: String, sc: Int?, al: Int, cl: Int, gt: Int) {
    init(sStruct: saveStruct) {
        //Initialize Stored Properties
        //print("savedGame: init gStack = \(gStack)")
        self.pSet.type = sStruct.pSet.type
        self.pSet.cLevel = sStruct.pSet.cLevel
        self.pSet.given = sStruct.pSet.given
        self.pSet.solution = sStruct.pSet.solution
        //print("savedGame: init gStack.solvingAlgorithm = \(gStack.solvingAlgorithm)")
        self.pSet.solvingAlgorithm = sStruct.pSet.solvingAlgorithm
        self.pSet.allCandidates = sStruct.pSet.allCandidates
        self.pSet.solvedUnits = sStruct.pSet.solvedUnits
        self.pSet.state = sStruct.pSet.state
        self.pSet.playerAnswered = sStruct.pSet.playerAnswered
        self.pSet.playerCandidates = sStruct.pSet.playerCandidates
        self.sGameName = sStruct.sGameName
        self.sPlayableDigits = sStruct.sPlayableDigits
        self.sKeypadDigit = sStruct.sKeypadDigit
        self.sSolvedDigits = sStruct.sSolvedDigits
        self.sSelectedCellIndex = sStruct.sSelectedCellIndex
        self.sCandidateCntrl = sStruct.sCandidateCntrl
        self.sChallengeLevel = sStruct.sChallengeLevel
        self.sGameTimerCount = sStruct.sGameTimerCount
        
        super.init()
    }
    
}

