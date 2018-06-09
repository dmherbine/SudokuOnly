//
//  CVControllerMain.swift
//  Sudoku
//
//  Created by dave herbine on 2/22/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit

// Add for Twitter MoPub Framework
//import MoPub  // Temporarily commented out on 8/25/2017
//import Fabric
//import mopub_ios_sdk

var cvControllerCount = 0
var globalKPD: String? = nil
var globalSC: IndexPath? = nil

class CVController: UICollectionViewController, UIGestureRecognizerDelegate, UICollectionViewDelegateFlowLayout {//}, MPAdViewDelegate { // Temporarily commented out on 8/25/2017

    let reuseIdentifier = "GameCell"
    var header = CRVHeader()           // This is to access view objects in the supplementary header view !!
    var footer = CRVFooter()           // This is to access view objects in the supplementary footer view !!

    struct GameTimer {
        var timerCount = 0
        var timerCountMin = 0
        var timerCountSec = 0
        var timerOn = false
        var timer = Timer()
    }
    var gameTimer = GameTimer()        // Used for game timer
    
    let np = NPController()     // MARK: Number Pad
    let gr = GRController()     // MARK: UIGestureRecognizerDelegate
    let ds = DSController()     // MARK: UICollectionViewDataSource

    let transitionManager = PopAnimator()  // added to use PopAnimator instead of default transition
    var popReturnAction: String? = nil {
        didSet
        {
            if popReturnAction != nil {
                print("popReturnAction: didSet = \(popReturnAction!)")
                switch popReturnAction! {
                    case "playAnother": startNewGame(nil)
                    default: print("popReturnAction: didSet unrecognized value: \(popReturnAction!)")
                }
            }
        }
    }
    
    //  Pick up where player left off
    var game = savedGameArray != nil ? Game(savedGames: savedGameArray!) : Game(challenge: 2)
    var savedGame = savedGameArray != nil ? savedGameArray! : [SavedGame]()
    
    var favGames = favGamesArray != nil ? favGamesArray! : [PersistFavGames]() {
        didSet
        {
            print("favGames: didSet: Got Here!  favGames.isEmpty = \(favGames.isEmpty)")
            if header.favoriteButton != nil {
                if favGames.isEmpty {
                    let favBtnTitle = "💔"
                    let disabledAttributedString = NSAttributedString(string: favBtnTitle,
                                                                      attributes: [
                                                                        NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)
                        ])
                    header.favoriteButton.setAttributedTitle(disabledAttributedString, for: UIControlState.disabled)
                } else {
                    let favBtnTitle = "❤️"
                    let normalAttributedString = NSAttributedString(string: favBtnTitle,
                                                                    attributes: [
                                                                        NSAttributedStringKey.foregroundColor: UIColor.red
                        ])
                    header.favoriteButton.setAttributedTitle(normalAttributedString, for: UIControlState())
                }
            }
        }
    }


    //
    //  Case        keypadDigit     oldValue            selectedCell    "Answer" button
    //  0           "n"             nil                 nil -> disable  "Answer: n" enabled/disabled (accentuate keypadDigit)
    //  1           "n"             "m"                 nil -> disable  "Answer: n" enabled/disabled (accentuate keypadDigit, deaccentuate oldValue)
    //  2           "n"             "n"                                 "Answer" disabled (deaccentuate keypadDigit)
    //  3           nil             "m"                                 "Answer" disabled (deaccentuate oldValue)
    //  4           nil             nil                                 "Answer" disabled
    //
    var keypadDigit: String? = nil {
        didSet
        {
            saveGameStack()
            globalKPD = keypadDigit
                
            var answerScenario: Int?
            if keypadDigit != nil {
                answerScenario = 0
                if oldValue != nil {
                    answerScenario = 1
                    if keypadDigit! == oldValue! {
                        answerScenario = 2
                    }
                }
            } else { answerScenario = oldValue != nil ? 3 : 4 }
            
            if answerScenario != nil {
                switch answerScenario!
                {
                case 0:
                    enableAnswerButton(keypadDigit!)
                    accentuateButton(keypadDigit!)
                    playableDigits = keypadDigit
                    np.highlightCells(self)
                case 1:
                    enableAnswerButton(keypadDigit!)
                    accentuateButton(keypadDigit!)
                    deaccentuateButton(oldValue!)
                    playableDigits = keypadDigit
                    np.highlightCells(self)
                case 2:
                    disableAnswerButton("")
                    deaccentuateButton(keypadDigit!)
                    np.highlightCells(self)
                    if keypadDigit != nil { keypadDigit = nil }
                    if keypadDigit != nil { playableDigits = nil }
                    if keypadDigit != nil { selectedCell = nil }
                    np.highlightCells(self)
                case 3:
                    disableAnswerButton("")
                    deaccentuateButton(oldValue!)
                    if keypadDigit != nil { keypadDigit = nil }
                    if keypadDigit != nil { playableDigits = nil }
                    np.highlightCells(self)
                default:
                    disableAnswerButton("")
                    if keypadDigit != nil { playableDigits = nil }
                    }
            } else {
                print("keypadDigit: didSet: somehow answerScenario was not set!")
            }
        }
    }

    func enableAnswerButton(_ ansDigit: String) {
        if let btn = ds.getButtonWithTitle("Answer", buttonArray: buttonArray) {
            if !btn.isEnabled { btn.isEnabled = true }
            let btnTitles = ds.getAttributedTitlesOf("Answer: \(ansDigit)")
            btn.setAttributedTitle(btnTitles.normalTitle, for: UIControlState())
            btn.setAttributedTitle(btnTitles.disabledTitle, for: UIControlState.disabled)
        }
    }

    func disableAnswerButton(_ ansDigit: String) {
        if let btn = ds.getButtonWithTitle("Answer", buttonArray: buttonArray) {
            if btn.isEnabled { btn.isEnabled = false }
            var btnTitles = ds.getAttributedTitlesOf("Answer: \(ansDigit)")
            if ansDigit == "" {
                btnTitles = ds.getAttributedTitlesOf("Answer")
            } else {
                print("disableAnswerButton: not sure what to do here...")
            }
            btn.setAttributedTitle(btnTitles.normalTitle, for: UIControlState())
            btn.setAttributedTitle(btnTitles.disabledTitle, for: UIControlState.disabled)
        }
    }

    func accentuateButton(_ btnDigit: String) {
        if let keypadDigitBtn = ds.getButtonWithTitle(btnDigit, buttonArray: buttonArray) {
            keypadDigitBtn.layer.borderColor = defaultColor.cgColor
            keypadDigitBtn.layer.borderWidth = GridSize.sharedInstance.cellBorderWidth*6
        }
    }

    func deaccentuateButton(_ btnDigit: String) {
        if let oldValueBtn = ds.getButtonWithTitle(btnDigit, buttonArray: buttonArray) {
            oldValueBtn.layer.borderColor = UIColor.black.cgColor
            oldValueBtn.layer.borderWidth = GridSize.sharedInstance.cellBorderWidth*0
        }
    }
    
    var playableDigits: String? = nil {
        didSet {
            saveGameStack()
        }
    }
        
    var solvedDigits = "" {
        didSet
        {
            saveGameStack()
            np.highlightSolvedDigitButtons(self, solvedDigits)
        }
    }
    
    // Handle the scenario where keypadDigit is nil but a possibly populated cell of candidates is selected
    var selectedCell: IndexPath? = nil {
        didSet
        {
            saveGameStack()
            globalSC = selectedCell
            if selectedCell != oldValue {
                if selectedCell != nil && keypadDigit == nil {
                    playableDigits = game.getCellWithIndex(selectedCell!.row, candidateCntrl: candidateCntrl)
                    //print("selectedCell: didSet: calling clearHelpHighlights()")
                    np.clearHelpHighlights(self)
                }
                np.highlightCells(self)
            }
        }
    }

    var helpView = HelpHighlight()
    
    var candidateCntrl = 1 {
        didSet
        {
            saveGameStack()
            if candidateCntrl != oldValue {
                switch candidateCntrl
                {
                case 0:
                    // since player has changed view, I need to force a reload of all cells corresponding to unpopulated answers
                    let unansweredIndexes = game.getIndexesOfUnanswered()
                    reloadChangedCells(unansweredIndexes)
                    np.highlightCells(self)     //np.unHighlightCells(self)
                    np.unHighlightSolvedDigitButtons()
                case 1:
                    // since player has changed view, I need to force a reload of all cells corresponding to populated playerCandidates
                    let unansweredIndexes = game.getIndexesOfUnanswered()
                    reloadChangedCells(unansweredIndexes)
                    np.highlightCells(self)
                    solvedDigits = game.getSolvedDigits()
                    np.highlightSolvedDigitButtons(self, solvedDigits)
                case 2:
                    // since player never enters a candidate I need to force a reload of all cells corresponding to populated candidates
                    let unansweredIndexes = game.getIndexesOfUnanswered()
                    reloadChangedCells(unansweredIndexes)
                    np.highlightCells(self)
                    solvedDigits = game.getSolvedDigits()
                    np.highlightSolvedDigitButtons(self, solvedDigits)
                default:
                    print("CVControllerMain.swift: candidateCntrl: didSet: changed to unexpected value: \(candidateCntrl)")
                    break
                }
            }
        }
    }
    
    var challengeLevel = 2 {
        didSet
        {
            saveGameStack()
            if challengeLevel != oldValue {
                switch challengeLevel
                {
                case 0...4:
                    if savedGameArray == nil { startNewGame(nil) }
                default:
                    print("Challenge Level changed to unexpected value: \(challengeLevel)")
                    break
                }
            }
        }
    }
        
    var favoriteGame: PersistFavGames? = nil {
        didSet
        {
            if favoriteGame != nil {
                print("favoriteGame: didSet: player selected to play a favorite game")
                challengeLevel = favoriteGame!.pSet.cLevel
                startNewGame(Game(favoriteGame: favoriteGame!))
                favoriteGame = nil
            } else {
                print("favoriteGame: didSet: it's nil!")
            }
        }
    }
    
    var gameStackDepth = 0 {
        didSet
        {
            if let btn = ds.getButtonWithTitle("Undo", buttonArray: buttonArray) {
                if gameStackDepth < 2 {
                    if btn.isEnabled { btn.isEnabled = false }  // disable Undo
                } else {
                    if !btn.isEnabled { btn.isEnabled = true }  // enable Undo
                }
            } else {
                print("gameStackDepth: didSet: getButton returned nil though buttonArray.count = \(buttonArray.count)")
            }
        }
    }
    
    func saveGameStack() {
        if game.gamePuzzles.isPuzzleSolved() {
            if FileManager.default.fileExists(atPath: SavedGame.ArchiveURL.path) {
                do { let remove = try FileManager.default.removeItem(atPath: SavedGame.ArchiveURL.path)
                    print("saveGameStack: remove = \(remove)")
                } catch let error as NSError {
                    print("saveGameStack: error: \(error.localizedDescription)")
                }
                savedGame.removeAll()
            }
        } else {
            var sStruct = saveStruct()
            if game.savedName == nil { game.savedName = getTimeStamp() }
            sStruct.pSet = game.gamePuzzles
            sStruct.sGameName = game.savedName
            sStruct.sPlayableDigits = playableDigits
            sStruct.sKeypadDigit = keypadDigit
            sStruct.sSolvedDigits = solvedDigits
            sStruct.sSelectedCellIndex = selectedCell?.row
            sStruct.sGameTimerCount = gameTimer.timerCount
            if let lastSave = savedGame.last {
                if !meaningfulChange(sStruct, lastSavedGame: lastSave) {
                    savedGame.removeLast()      // This will effectively replace the last game to ensure the latest time
                }
            }
            savedGame.append(SavedGame(sStruct: sStruct))
        }
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
        queue.async { () -> Void in
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.savedGame, toFile: SavedGame.ArchiveURL.path)
            if !isSuccessfulSave {
                print("saveGameStack: Failed to save games...")
            }
        }
    }
    
    func saveAsFavorite(_ favoriteName: String) {
        var favPzl = PzlSet()
        favPzl.type = game.gamePuzzles.type
        favPzl.given = game.gamePuzzles.given
        favPzl.solution = game.gamePuzzles.solution
        favPzl.cLevel = game.gamePuzzles.cLevel
        favPzl.solvingAlgorithm = game.gamePuzzles.solvingAlgorithm
        favPzl.playerAnswered = game.gamePuzzles.given
        favPzl.allCandidates = game.getAllCandidates(favPzl)
        favGames.append(PersistFavGames(gStack: favPzl, fn: favoriteName))
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
        queue.async { () -> Void in
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.favGames, toFile: PersistFavGames.FavoritesURL.path)
            if !isSuccessfulSave {
                print("saveAsFavorite: Failed to save games...")
            }
        }        
    }
    
    func updateFavorites() {
        if FileManager.default.fileExists(atPath: PersistFavGames.FavoritesURL.path) {
            let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
            queue.async { () -> Void in
                let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.favGames, toFile: PersistFavGames.FavoritesURL.path)
                if !isSuccessfulSave {
                    print("saveAsFavorite: Failed to save games...")
                }
            }
        }
    }
    
    func startNewGame(_ aGame: Game?) {
        savedGame.removeAll()
        if aGame != nil {
            game = aGame!
        } else {
            game = Game(challenge: challengeLevel)
        }
        resetAndReload()
    }
    
    func startPoppedGame() {
        savedGame.removeAll()
        if let lastGame = game.popFromGameStack() {
            game.gamePuzzles = lastGame
        } else {
            game = Game(challenge: challengeLevel)
        }
        resetAndReload()
    }
    
    func resetAndReload() {
        gameStackDepth = game.getStackDepth()
        keypadDigit = nil
        playableDigits = nil
        selectedCell = nil
        solvedDigits = game.getSolvedDigits()
        reloadAllCells()
        np.highlightCells(self)
        gameTimer.timer.invalidate()
        gameTimer.timerCount = 0
        gameTimer.timerOn = false
        if !gameTimer.timerOn {
            gameTimer.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CVController.incrementTimerCount), userInfo: nil, repeats: true)
            gameTimer.timerOn = true
        }
    }
    
    @objc func incrementTimerCount() {
        gameTimer.timerCount += 1
        gameTimer.timerCountMin = gameTimer.timerCount/60
        gameTimer.timerCountSec = gameTimer.timerCount % 60
        header.Timer.text = (gameTimer.timerCountSec > 9) ? "\(gameTimer.timerCountMin):\(gameTimer.timerCountSec)" : "\(gameTimer.timerCountMin):0\(gameTimer.timerCountSec)"
    }
    
    // TODO: Replace this Twitter MoPub test id with your personal ad unit id
    //var adView: MPAdView = MPAdView(adUnitId: "0fd404de447942edb7610228cb412614", size: MOPUB_BANNER_SIZE) // Temporarily commented out on 8/25/2017
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculate the frame dimensions for the pairs of horizontal and vertical lines to outline the 3x3 blocks
        let hLineHigh = UIView(frame: CGRect(x: GridSize.sharedInstance.lIndent,
            y: GridSize.sharedInstance.cellWidth*3+GridSize.sharedInstance.headerHeight-1.5,
            width: GridSize.sharedInstance.cellWidth*9, height: 3))
        hLineHigh.backgroundColor = UIColor.black
        self.collectionView!.addSubview(hLineHigh)
        
        let hLineLow = UIView(frame: CGRect(x: GridSize.sharedInstance.lIndent,
            y: GridSize.sharedInstance.cellWidth*6+GridSize.sharedInstance.headerHeight-1.5,
            width: GridSize.sharedInstance.cellWidth*9, height: 3))
        hLineLow.backgroundColor = UIColor.black
        self.collectionView!.addSubview(hLineLow)
        
        let vLineLeft = UIView(frame: CGRect(x: GridSize.sharedInstance.lIndent+GridSize.sharedInstance.cellWidth*3-1.5,
            y: GridSize.sharedInstance.headerHeight, width: 3, height: GridSize.sharedInstance.cellWidth*9))
        vLineLeft.backgroundColor = UIColor.black
        self.collectionView!.addSubview(vLineLeft)
        
        let vLineRight = UIView(frame: CGRect(x: GridSize.sharedInstance.lIndent+GridSize.sharedInstance.cellWidth*6-1.5,
            y: GridSize.sharedInstance.headerHeight, width: 3, height: GridSize.sharedInstance.cellWidth*9))
        vLineRight.backgroundColor = UIColor.black
        self.collectionView!.addSubview(vLineRight)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(CVController.handleLongPress(_:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.collectionView!.addGestureRecognizer(lpgr)
        
        let dtgr = UITapGestureRecognizer(target: self, action: #selector(CVController.handleDoubleTap(_:)))
        dtgr.numberOfTapsRequired = 2
        dtgr.delaysTouchesBegan = true
        dtgr.delegate = self
        self.collectionView!.addGestureRecognizer(dtgr)
        
        let stgr = UITapGestureRecognizer(target: self, action: #selector(CVController.handleSingleTap(_:)))
        stgr.numberOfTapsRequired = 1
        stgr.require(toFail: dtgr)
        stgr.delaysTouchesBegan = true
        stgr.delegate = self
        self.collectionView!.addGestureRecognizer(stgr)
        
        // Start the game timer here ... for now ...
        if !gameTimer.timerOn {
            gameTimer.timer = Timer.scheduledTimer(timeInterval: 1,
                                                                     target: self,
                                                                     selector: #selector(CVController.incrementTimerCount),
                                                                     userInfo: nil,
                                                                     repeats: true)
            gameTimer.timerOn = true
        }
        
        // Resume game by setting variables to saved values
        if savedGameArray != nil {
            if let lastSave = savedGameArray?.last {
                let range = NSRange(location: 0, length: 1)         // Gotta do this first
                let reloadRange = IndexSet(integersIn: range.toRange() ?? 0..<0) //  so solved digits buttons show, and, so
                self.collectionView!.reloadSections(reloadRange)    //  {header|footer}.candidateCntrl.selectedSegmentIndex != nil!
                header.candidateCntrl.selectedSegmentIndex = candidateCntrl
                header.challengeLevel.selectedSegmentIndex = challengeLevel
                gameTimer.timerCount = lastSave.sGameTimerCount
                candidateCntrl = lastSave.sCandidateCntrl
                challengeLevel = lastSave.sChallengeLevel
                keypadDigit = lastSave.sKeypadDigit
                //print("viewDidLoad: keypadDigit = \(keypadDigit)")
                solvedDigits = lastSave.sSolvedDigits
                playableDigits = lastSave.sPlayableDigits
                if lastSave.sSelectedCellIndex != nil {
                    selectedCell = np.getIndexPathAtRow(self, row: lastSave.sSelectedCellIndex!)
                }
                np.highlightCells(self)
                gameStackDepth = game.getStackDepth()
                savedGameArray = nil    // I only want to use savedGameArray once
            }
        }

        favGames = favGamesArray != nil ? favGamesArray! : [PersistFavGames]()
        
        cvControllerCount += 1
        print("CVContoller: viewDidLoad: cvControllerCount = \(cvControllerCount)")
        
        // Add for Twitter MoPub Framework
/*        self.adView.delegate = self
        
        // Positions the ad at the bottom, with the correct size
        self.adView.frame = CGRect(x: 0, y: self.view.bounds.size.height - MOPUB_BANNER_SIZE.height,
                                       width: MOPUB_BANNER_SIZE.width, height: MOPUB_BANNER_SIZE.height)
        self.view.addSubview(self.adView)
        
        // Loads the ad over the network
        self.adView.loadAd()
 */ // Temporarily commented out on 8/25/2017

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if gameTimer.timerOn {
            saveGameStack() //catch the last gameTimer.timerCount
        }
    }
    
    deinit {
        cvControllerCount -= 1
        print("CVContoller: deinit: cvControllerCount = \(cvControllerCount)")
    }
    
    // Add for Twitter MoPub Framework
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GridSize.sharedInstance.cellWidth, height: GridSize.sharedInstance.cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: GridSize.sharedInstance.lIndent, bottom: 0.0, right: GridSize.sharedInstance.rIndent)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: GridSize.sharedInstance.headerWidth, height: GridSize.sharedInstance.headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: GridSize.sharedInstance.footerWidth, height: GridSize.sharedInstance.footerHeight)
    }

    
    // MARK: Number Pad
    
    //
    // Called when numberPadDigits = ["1","2","3","4","5","6","7","8","9"] or
    //    actionButtons = ["Undo", "Help", "Answer"] button is pressed
    //
    @objc func numberPadProcess(_ sender: UIButton) {
        if let buttonLabel = sender.titleLabel?.text {
            
            // b/c Answer's title could be either of two forms: "Answer" or "Answer: n"
            let switchLabel = buttonLabel.hasPrefix("Answer") ? "Answer" : buttonLabel
            
            // print("titleLabel of button is \(buttonLabel), switchLabel is \(switchLabel)")
            
            switch switchLabel {
            case "1"..."9":
                // always set keypadDigit - didSet will highlight or unhighlight buttons appropriately
                keypadDigit = buttonLabel
                
            case "Answer":
                if selectedCell != nil {    // selectedCell should always be set if Answer is enabled
                    if !game.isCellGiven(selectedCell!.row) {
                        
                        if keypadDigit == nil {
                            print("Answer: keypadDigit is nil!")
                            break
                        } else {
                            np.setAnswerAtCell(self, answer: keypadDigit!, answerCell: selectedCell!)
                        }
                        break
                    }
                    print("Answer: selectedCell is a given")
                } else {
                    print("Answer: selectedCell is nil")
                }
                
            case "Help":
                if let badAnswers = game.getBadAnswers() {
                    np.badAnswersHelp(self, badAnswers)
                    break
                }
                
                if let badPlayerCandidates = game.getBadPlayerCandidates() {
                    np.badPlayerCandidatesHelp(self, badPlayerCandidates)
                    break
                }
                
                print("HELP STEP 1: numberPadProcess: about to call getAlgoAssigns()")
                if let assignments = game.getAlgoAssigns() {
                    print("HELP STEP 21: numberPadProcess: getAlgoAssigns() returned a result, so calling np.showAssignCell()")
                    //assignments.printIt()
                    np.showAssignCell(self, assignments)
                    break
                }
                
                // Shouldn't ever get here, but in case I do ...
                let helpTitle = "Whoa! I got nothin'!"
                let helpMessage = "You are on your own!"
                print("\(helpTitle)\n\(helpMessage)")
                let alertController = UIAlertController(title: helpTitle, message: helpMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
                
            case "Undo":
                startPoppedGame()
                
            default:
                print("unrecognized button label: \(buttonLabel)!")
            }
        } else {
            print("titleLabel of button is nil!")
        }
    }
    
    
    // MARK: UIGestureRecognizerDelegate
    
    // Single Tap adds a candidate
    @objc func handleSingleTap(_ gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView!.indexPathForItem(at: p)
        
        if let index = indexPath {
            selectedCell = index    // very important to set selectedCell
            let cell = game.getCellInfo(index.row)
            switch cell.type {
            case cellContent.given:
                selectedCell = nil      // order matters!  selectedCell must be set before keypadDigit
                if solvedDigits.range(of: cell.contents) == nil { keypadDigit = cell.contents }
            case cellContent.answered:
                if solvedDigits.range(of: cell.contents) == nil { keypadDigit = cell.contents }
            case cellContent.playerCandidate:
                if keypadDigit != nil {
                    np.addPlayerCandidate(self, keypadDigit!)
                }
            case cellContent.allCandidate:
                if keypadDigit != nil {
                    np.addPlayerCandidate(self, keypadDigit!)
                }
            }
        } else {
            let timerLabel = gestureReconizer.location(in: self.header.Timer)
            if self.header.Timer.bounds.contains(timerLabel) {
                gr.timerAction(self, "Single Tap")
                gameTimer.timer.invalidate()
                gameTimer.timerOn = false
                if !gameTimer.timerOn {
                    gameTimer.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CVController.incrementTimerCount), userInfo: nil, repeats: true)
                    gameTimer.timerOn = true
                }

            } else {
                gr.noIndexPath(self, "Single Tap")
            }
        }
    }
    
    
    // Long Press adds an Answer
    @objc func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView!.indexPathForItem(at: p)
        
        if let index = indexPath {
            selectedCell = index    // very important to set selectedCell
            let cell = game.getCellInfo(index.row)
            switch cell.type {
            case cellContent.given:
                if solvedDigits.range(of: cell.contents) == nil { keypadDigit = cell.contents }
            case cellContent.answered:
                if solvedDigits.range(of: cell.contents) == nil { keypadDigit = cell.contents }
            case cellContent.playerCandidate, cellContent.allCandidate:
                if keypadDigit != nil {
                    if solvedDigits.range(of: cell.contents) == nil {
                        np.setAnswerAtCell(self, answer: keypadDigit!, answerCell: selectedCell!)
                    }
                }
            }
        } else {
            let timerLabel = gestureReconizer.location(in: self.header.Timer)
            if self.header.Timer.bounds.contains(timerLabel) {
                gr.timerAction(self, "Long Press")
                header.Timer.text = "Timer"
                gameTimer.timer.invalidate()
                gameTimer.timerOn = false
            } else {
                gr.noIndexPath(self, "Long Press")
            }
        }
    }
    
    // Double Tap provides help and the ability to clear cell contents
    @objc func handleDoubleTap(_ gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView!.indexPathForItem(at: p)
        
        if let index = indexPath {
            selectedCell = index    // very important to set selectedCell
            let cell = game.getCellInfo(index.row)
            switch cell.type {
            case cellContent.given:
                gr.dtGiven(self, index.row, cell.contents)
            case cellContent.answered:
                gr.dtAnswered(self, index.row, cell.contents)
            case cellContent.playerCandidate:
                gr.dtPlayerCandidate(self, index.row, cell.contents)
            case cellContent.allCandidate:
                if keypadDigit != nil {
                    gr.dtPossible(self, index.row, keypadDigit!)
                } else {
                    gr.dtPossible(self, index.row, cell.contents)
                }
            }
        } else {
            let timerLabel = gestureReconizer.location(in: self.header.Timer)
            if self.header.Timer.bounds.contains(timerLabel) {
                gr.timerAction(self, "Double Tap")
                gameTimer.timer.invalidate()
                gameTimer.timerOn = false
                if !gameTimer.timerOn {
                    gameTimer.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CVController.incrementTimerCount), userInfo: nil, repeats: false)
                    gameTimer.timerOn = true
                }
            } else {
                gr.noIndexPath(self, "Double Tap")
            }
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CVCell
        
        //print("collectionView:cellForItemAt:indexPath.row = \(indexPath.row)")
        
        var labelArray = [UILabel]()
        
        // Clear out any existing label content
        _ = cell.square.map { $0.text = "" }
                
        if helpView.displayHighlights {
            if let allCandidateDigits = game.getCellWithIndex(indexPath.row, candidateCntrl: 2) {
                //print("collectionView: readyToDisplay: indexPath.row = \(indexPath.row), candidateCntrl = \(candidateCntrl), digits = \(allCandidateDigits)")
                if let squareAtRow = helpView.highlightHelpCells.filter({ $0.square == indexPath.row }).first {
                    labelArray = ds.createHighlightLabelArray(self, indexPath.row, allCandidateDigits, squareAtRow)
                } else {
                    print("collectionView: readyToDisplay: Could not find indexPath.row = \(indexPath.row) in helpView.highlightHelpCells:")
                    for hCell in helpView.highlightHelpCells { hCell.printIt() }
                }
            }
        } else {
            let digits = game.getCellWithIndex(indexPath.row, candidateCntrl: candidateCntrl)
            //print("collectionView: indexPath.row = \(indexPath.row), candidateCntrl = \(candidateCntrl), digits = \(digits)")
            labelArray = ds.createLabelArray(self, digits: digits, indexPath.row, candidateCntrl)
        }
        cell.square = labelArray
        
        for label in labelArray { cell.addSubview(label) }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = GridSize.sharedInstance.cellBorderWidth
        
        return cell
    }
    
    func reloadAllCells() {
        print("reloadAllCells: calling clearHelpHighlightedCells()")
        np.clearHelpHighlights(self)
        var allVisibleCells = [IndexPath]()
        for cell in self.collectionView!.visibleCells {
            if let idxPath = self.collectionView!.indexPath(for: cell) {
                    allVisibleCells.append(idxPath)
            }
        }
        UIView.performWithoutAnimation {
            self.collectionView!.reloadItems(at: allVisibleCells)
        }
    }
    
    func reloadChangedCells(_ changedCells: [Int]) {
        //let allChangedCells = changedCells + helpView.highlightHelpCells.map(){ $0.square }  // include highlightedSquares even if empty it doesn't hurt
        let allChangedCells = helpView.displayHighlights ? changedCells + helpView.highlightHelpCells.map(){ $0.square } : changedCells
        var playableCellArray = [IndexPath]()
        for cell in self.collectionView!.visibleCells {
            if let idxPath = self.collectionView!.indexPath(for: cell) {
                if allChangedCells.contains(idxPath.row) {
                    playableCellArray.append(idxPath)
                }
                if playableCellArray.count == allChangedCells.count { break }
            }
        }
        
        UIView.performWithoutAnimation {
            self.collectionView!.reloadItems(at: playableCellArray)
        }
        
    }
    
    func reloadIncorrectCells(_ index: Int) {
        for cell in self.collectionView!.visibleCells {
            if let idxPath = self.collectionView!.indexPath(for: cell) {
                if idxPath.row == index {
                    var playableCellArray = [IndexPath]()
                    playableCellArray.append(idxPath)
                    UIView.performWithoutAnimation {
                        self.collectionView!.reloadItems(at: playableCellArray)
                    }
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                                                   at indexPath: IndexPath) -> UICollectionReusableView {
        
        // The kind parameter is supplied by the layout object and indicates which sort of supplementary view is being asked for.
        switch kind {
            
        //By checking that box in the storyboard to add a section header, you told the flow layout that it needs to start asking for these views.
        case UICollectionElementKindSectionHeader:
            //The header view is dequeued using the identifier added in the storyboard. This works just like cell dequeuing.
            header =
                collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: "GameHeader",
                                                                      for: indexPath)
                as! CRVHeader
            
            header.Timer.text = "0:00"  //initial display of timer label
            header.Timer.font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth*0.6)
            
            header.favoriteButton.titleLabel?.font = UIFont(name: "Apple Color Emoji", size: (GridSize.sharedInstance.cellWidth*0.6))
            
            header.candidatesLabel.font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth*0.6)
            header.challengeLabel.font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth*0.6)
            
            // initialize segmented controls
            let candidateCntrlSize = CGSize(width: 3*GridSize.sharedInstance.cellWidth, height: GridSize.sharedInstance.cellWidth)
            header.candidateCntrl.sizeThatFits(candidateCntrlSize)
            header.candidateCntrl.selectedSegmentIndex = candidateCntrl
            header.challengeLevel.selectedSegmentIndex = challengeLevel
            
            return header
            
        //By checking that box in the storyboard to add a section footer, you told the flow layout that it needs to start asking for these views.
        case UICollectionElementKindSectionFooter:
            //The footer view is dequeued using the identifier added in the storyboard. This works just like cell dequeuing.
            footer =
                collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: "GameFooter",
                                                                      for: indexPath)
                as! CRVFooter
            
            ds.createButtonArray(self)
            
            return footer
            
        //Switch needs to be all inclusive, so just some protection if somehow a kind other than header or footer is encountered.
        default:
            assert(false, "Unexpected element kind of \(kind)")
        }
    }
    
    
    // MARK: Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "FavGamesMgr" {
            //print("shouldPerformSegueWithIdentifier: identifier is \(identifier) as expected!")
            if !favGames.isEmpty {
                return true
            } else {
                let alertTitle = "You Don't Have Any Favorites ..."
                let alertMessage = "You can name any puzzle you enjoyed solving which will change the button from 💔 to ❤️.  Playing a Favorite will look new yet retain the essence of the original game"
                print("\(alertTitle)\n\(alertMessage)")
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navcon = segue.destination as? UINavigationController {
            destinationVC = navcon.visibleViewController ?? destinationVC
        }
        if let favGamesMgrVC = destinationVC as? FavGamesManager {
            favGamesMgrVC.favGames = favGames
        }
    }
    
    @IBAction func unwindWithSelectedFav(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is FavGamesManager {
            //print("CVController: unwindWithSelectedFav: Player selected a favorite game from FavGamesManager")
            updateFavorites()
        }
    }
    
    @IBAction func returnToCurrentGame(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is FavGamesManager {
            //print("CVController: returnToCurrentGame: Player canceled from FavGamesManager")
            updateFavorites()
        }
    }

}

