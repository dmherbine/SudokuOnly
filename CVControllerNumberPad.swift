//
//  CVControllerNumberPad.swift
//  Sudoku
//
//  Created by dave herbine on 4/11/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation
import UIKit

// define the structure for player help
struct PlayerHelp {
    var tupleIndex: Int
    var tupleElement: String
    var row: Int
    var square: Int
    
    init(fromTuple tuple: Cell) {
        tupleIndex = tuple.square
        tupleElement = tuple.value
        row = (tuple.square / 9) + 1
        square = (tuple.square % 9) + 1
        //print("PlayerHelp: init: index = \(tuple.square), row = \(row), square = \(square)")
    }
}

struct HelpHighlight {
    var highlightHelpCells = [HelpCell]()
    var displayHighlights = false
}
extension HelpHighlight: Equatable {
    static func ==(lhs: HelpHighlight, rhs: HelpHighlight) -> Bool {
        let areEqual = lhs.highlightHelpCells.sorted(by: {(cell1: HelpCell, cell2: HelpCell) -> Bool in return cell1.square < cell2.square }) == rhs.highlightHelpCells.sorted(by: {(cell1: HelpCell, cell2: HelpCell) -> Bool in return cell1.square < cell2.square })
        return areEqual
    }
}

//let onesColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1)  // pink
//let twosColor = UIColor(red: 186/255, green: 85/255, blue: 211/255, alpha: 1)   // medium orchid
//let threesColor = UIColor(red: 147/255, green: 112/255, blue: 219/255, alpha: 1)   // medium slate blue
//let foursColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)   // corn flower blue
//let fivesColor = UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1) // light sky blue
//let sixesColor = UIColor(red: 127/255, green: 255/255, blue: 212/255, alpha: 1)   // aquamarine
//let sevensColor = UIColor(red: 100/255, green: 238/255, blue: 100/255, alpha: 1)   // light green
//let eightsColor = UIColor(red: 255/255, green: 255/255, blue: 100/255, alpha: 1)   // medium yellow
//let ninesColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1)  // orange
let onesColor =   UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1)  // yellow
let twosColor =   UIColor(red: 0.5, green: 0.8, blue: 0.0, alpha: 1)   // yellow green
let threesColor = UIColor(red: 0.0, green: 0.8, blue: 0.6, alpha: 1)   // blue green
let foursColor =  UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1)   // green
let fivesColor =  UIColor(red: 0.6, green: 0.6, blue: 1.0, alpha: 1)   // blue violet
let sixesColor =  UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.6) // red violet
let sevensColor = UIColor(red: 0.7, green: 0.3, blue: 0.2, alpha: 0.8)   // red orange
let eightsColor = UIColor(red: 0.9, green: 0.5, blue: 0.0, alpha: 1)   // orange
let ninesColor =  UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 0.8)   // brown
let digitsColorsArray = [onesColor, twosColor, threesColor, foursColor, fivesColor, sixesColor, sevensColor, eightsColor, ninesColor]
var selectedCellColor = UIColor.lightGray
var playerHelpViewColor = UIColor.gray

class NPController {
    
    // MARK: UICollectionViewDataSource
    let ds = DSController()
    
    let wittyMessages = ["You Rock!", "Excellent!", "Sudoku Superstar!", "You are Awesome!"]

    func badAnswersHelp(_ cvc: CVController, _ badAnswers: [Cell]) {
        let prefix = "There "
        let singular = "is an incorrect answer!"
        let plural = "are \(badAnswers.count) incorrect answers!"
        let helpTitle = badAnswers.count > 1 ? prefix + "\(plural)" : prefix + "\(singular)"
        let alertController = UIAlertController(title: helpTitle, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        for badAns in badAnswers {
            let ph = PlayerHelp(fromTuple: badAns)
            let helpMessage = "Clear \"\(ph.tupleElement)\" in row: \(ph.row), square: \(ph.square)"
            if let clearIndexPath = getIndexPathAtRow(cvc, row: ph.tupleIndex) {
                print("\(helpTitle)\n\(helpMessage)")
                let clearAction = UIAlertAction(title: helpMessage, style: .default) { (action) in self.clearAnswer(cvc, clearCell: clearIndexPath) }
                alertController.addAction(clearAction)
            } else {
                print("\(helpTitle)\n\(helpMessage) - could not find IndexPath of \(ph.tupleIndex)")
            }
        }
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
     func badPlayerCandidatesHelp(_ cvc: CVController, _ badPlayerCandidates: [Cell]) {
        let prefix = "There "
        let singular = "is an incorrect candidate!"
        let plural = "are \(badPlayerCandidates.count) incorrect candidates!"
        let helpTitle = badPlayerCandidates.count > 1 ? prefix + "\(plural)" : prefix + "\(singular)"
        let alertController = UIAlertController(title: helpTitle, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        for badPlayerCandidate in badPlayerCandidates {
            let ph = PlayerHelp(fromTuple: badPlayerCandidate)
            let helpMessage = "Clear \"\(ph.tupleElement)\" in row: \(ph.row), square: \(ph.square)"
            if let clearIndexPath = getIndexPathAtRow(cvc, row: ph.tupleIndex) {
                print("\(helpTitle)\n\(helpMessage)")
                let clearAction = UIAlertAction(title: helpMessage, style: .default) { (action) in self.clearPlayerCandidateFromCell(cvc, candidateDigit: ph.tupleElement, clearCell:clearIndexPath) }
                alertController.addAction(clearAction)
            } else {
                print("\(helpTitle)\n\(helpMessage) - could not find IndexPath of \(ph.tupleIndex)")
            }
        }
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
    func showAssignCell(_ cvc: CVController, _ assigned: AlgoAssigns) {
        let helpTitle = assigned.assignAlgo + " Strategy"
        let alertController = UIAlertController(title: helpTitle, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
                print("HELP STEP 22: showAssignCell: creating actionSheet from getAlgoAssigns() result of:")
                assigned.printIt()
        let ph = PlayerHelp(fromTuple: assigned.assignCell)
        if let setIndexPath = getIndexPathAtRow(cvc, row: ph.tupleIndex) {
            let highlightCellMsg = "Highlight the cell"
            let selectCellAction = UIAlertAction(title: highlightCellMsg, style: .default) { (action) in cvc.selectedCell = setIndexPath }
            alertController.addAction(selectCellAction)
        } else {
            print("showAssignCell: Couldn't find indexPath of tupleIndex = \(ph.tupleIndex)")
        }
        let revealDigitMsg = "Select the digit"
        let revealDigitAction = UIAlertAction(title: revealDigitMsg, style: .default)
        { (action) in if cvc.keypadDigit != ph.tupleElement { cvc.keypadDigit = ph.tupleElement } }
        alertController.addAction(revealDigitAction)
        
        var highlightCellsMsg = ""
        var addAction = true
        switch assigned.assignAlgo {
            case "One Rule":
                highlightCellsMsg = "Show the unit and digit"
            case "Hidden Pair", "Naked Pair":
                highlightCellsMsg = "Show the unit and pair"
            case "Deadly Pattern":
                highlightCellsMsg = "Show the Rectangle"
            case "Depth First Guess":
                addAction = false
            default:
                addAction = false
                print("showAssignCell: unrecognized algo: \"\(assigned.assignAlgo)\"")
        }
        if addAction {
            let highlightCellsAction = UIAlertAction(title: highlightCellsMsg, style: .default)
            { (action) in self.setHelpViewProperty(cvc, assigned.highlightHelpCells) }
            alertController.addAction(highlightCellsAction)
        }
        
        let defaultAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        cvc.present(alertController, animated: true, completion: nil)
    }

    func setHelpViewProperty(_ cvc: CVController, _ hCells: [HelpCell]) {
        let highlightSquares = hCells.map({ $0.square })
        if !highlightSquares.isEmpty {
            //cvc.helpView = HelpHighlight(hhCells: hCells)
            cvc.helpView.highlightHelpCells = hCells
            displayHelpHighlights(cvc)
        } else {
            print("Error: setHelpViewProperty: highlightSquares array is empty!")
        }
    }
    
    func displayHelpHighlights(_ cvc: CVController) {
        let helpViewSquares = cvc.helpView.highlightHelpCells.map(){ $0.square }
        print("displayHelpHighlights: reloadChangedCells(\(helpViewSquares))")
        cvc.helpView.displayHighlights = true
        cvc.reloadChangedCells(helpViewSquares)
        highlightCells(cvc)
        cvc.helpView.displayHighlights = false
    }
    
    func clearHelpHighlights(_ cvc: CVController) {
        if !cvc.helpView.highlightHelpCells.isEmpty {
            for (idx, _) in cvc.helpView.highlightHelpCells.enumerated() {
                cvc.helpView.highlightHelpCells[idx].ansDigit = ""
                cvc.helpView.highlightHelpCells[idx].delDigit = ""
                cvc.helpView.highlightHelpCells[idx].algDigit = ""
            }
            let helpViewSquares = cvc.helpView.highlightHelpCells.map(){ $0.square }
            print("clearHelpHiglights: reloadChangedCells(\(helpViewSquares))")
            cvc.reloadChangedCells(helpViewSquares)
            highlightCells(cvc)
            cvc.helpView.highlightHelpCells = [HelpCell]()
            highlightCells(cvc)
        }
        cvc.helpView.displayHighlights = false
    }

    func createGridFromCollectionView(_ cvc: CVController) -> [String] {
        var cvGrid = [String](repeating: "", count: 81)
        for cell in cvc.collectionView!.visibleCells as! [CVCell] {
            if let idxPath = cvc.collectionView!.indexPath(for: cell) {
                var sqString = ""
                for sq in cell.square { sqString = sq.text == nil ? sqString : sqString + sq.text! }
                cvGrid[idxPath.row] = sqString
            }
        }
        return cvGrid
    }
    
    func addPlayerCandidate(_ cvc: CVController, _ candidateDigit: String) {
        var candidatesStr = ""
        if let candidateDigits = cvc.game.getCellWithIndex(cvc.selectedCell!.row, candidateCntrl: cvc.candidateCntrl) {
            //print("addPlayerCandidate: candidateDigits = \(candidateDigits)")
            let existingIndex = candidateDigits.range(of: candidateDigit)
            if existingIndex == nil {
                candidatesStr = candidateDigits + candidateDigit
            } else {
                //print("addPlayerCandidate: candidateDigit \"\(candidateDigit)\" found in \"\(candidateDigits)\", so nothing to do")
                return
            }
        } else {
            //print("addPlayerCandidate: candidateDigit = \(candidateDigit), candidatesStr = \(candidatesStr)")
            candidatesStr = candidateDigit
        }
        //print("addPlayerCandidate: candidatesStr = \(candidatesStr)")
        
        // update Puzzle and put it on the stack
        cvc.gameStackDepth = cvc.game.setPlayerCandidatesWithDigits(cvc.selectedCell!.row, digits: candidatesStr)
        
        let addedIndex = [Int](repeating: cvc.selectedCell!.row, count: 1)
        cvc.reloadChangedCells(addedIndex)
        
        highlightCells(cvc)
        cvc.saveGameStack()
        
        // Clear any help highlighted squares
        clearHelpHighlights(cvc)
    }
    
    func clearPlayerCandidateFromCell(_ cvc: CVController, candidateDigit: String, clearCell: IndexPath) {
        if let candidateDigits = cvc.game.getCellWithIndex(clearCell.row, candidateCntrl: cvc.candidateCntrl) {
            let existingIndex = candidateDigits.range(of: candidateDigit)
            if existingIndex == nil {
                print("clearPlayerCandidateFromCell: candidateDigit \"\(candidateDigit)\" expected, but not found in \"\(candidateDigits)\"")
                return
            } else {
                var candidateDigitsLessCandidateDigit = candidateDigits
                candidateDigitsLessCandidateDigit.removeSubrange(existingIndex!)
        
                // update Puzzle and put it on the stack
                cvc.gameStackDepth = cvc.game.setPlayerCandidatesWithDigits(clearCell.row, digits: candidateDigitsLessCandidateDigit)
                
                let clearedIndex = [Int](repeating: clearCell.row, count: 1)
                cvc.reloadChangedCells(clearedIndex)
                
                highlightCells(cvc)
                cvc.saveGameStack()
            }
        }
        // Clear any help highlighted squares
        clearHelpHighlights(cvc)
    }
    
    
    func setAnswerAtCell(_ cvc: CVController, answer: String, answerCell: IndexPath) {
        var changedCells = [Int]()
        cvc.game.setCellAnswered(answerCell.row, answerDigit: answer)
        
        // Update both player and puzzle candidates, but only reload the appropriate view
        switch cvc.candidateCntrl {
        case 0:
            changedCells = [Int](repeating: answerCell.row, count: 1)
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(answerCell.row)
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(answerCell.row)
        case 1:
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(answerCell.row)
            print("setAnswerAtCell: reloadChangedCells(\(changedCells))")
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(answerCell.row)
        case 2:
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(answerCell.row)
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(answerCell.row)
        default:
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(answerCell.row)
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(answerCell.row)
            print("processAnswer: unexpected candidateCntrl of \(cvc.candidateCntrl)!")
        }
        
        // enable or disable the "Undo" button
        cvc.gameStackDepth = cvc.game.getStackDepth()
        
        // update solvedDigits
        cvc.solvedDigits = cvc.game.getSolvedDigits()
        
        // reset keypadDigit but only if it's value is solved - this will unHighlight all buttons
        if cvc.keypadDigit != nil {
            if cvc.solvedDigits.range(of: cvc.keypadDigit!) != nil {
                print("setAnswerAtCell: keypadDigit set to nil")
                cvc.keypadDigit = nil   // didSet will disable the "Answer" button
            }
            highlightCells(cvc)
        }
        
        // reset selectedCell to nil if appropriate
        if cvc.selectedCell != nil {
            if cvc.selectedCell == answerCell {
                print("setAnswerAtCell: selectedCell set to nil")
                cvc.selectedCell = nil
            }
        }
        cvc.saveGameStack()

        // Stop the game timer and pop the game over screen if the Puzzle is solved
        if cvc.game.gamePuzzles.isPuzzleSolved() {
            cvc.gameTimer.timerCount = 0
            cvc.gameTimer.timer.invalidate()
            //present details view controller
            let popDetails = cvc.storyboard!.instantiateViewController(withIdentifier: "PopDetailsViewController") as! PopViewController
            popDetails.transitioningDelegate = cvc.transitionManager    // added to use PopAnimator instead of default transition
            let randomIndex = Int(arc4random_uniform(UInt32(wittyMessages.count)))
            popDetails.popWittyMessage = wittyMessages[randomIndex]
            popDetails.gameVC = cvc
            
            // Add a delay before presenting popDetails
            let triggerTime = (Int64(NSEC_PER_SEC) * 2)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                cvc.present(popDetails, animated: true, completion: nil)
            })
        }
        // Clear any help highlighted squares
        clearHelpHighlights(cvc)
    }
    
    func clearAnswer(_ cvc: CVController, clearCell: IndexPath) {
        var changedCells = [Int]()
        
        if cvc.selectedCell == nil {
            cvc.selectedCell = clearCell
        }
        
        cvc.game.setCellUnanswered(clearCell.row)
        
        // Update both player and puzzle candidates, but only reload the appropriate view
        switch cvc.candidateCntrl {
        case 0:
            changedCells = [Int](repeating: clearCell.row, count: 1)
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(clearCell.row)
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(clearCell.row)
        case 1:
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(clearCell.row)
            changedCells.append(clearCell.row)
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(clearCell.row)
        case 2:
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(clearCell.row)
            changedCells.append(clearCell.row)
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(clearCell.row)
        default:
            changedCells = cvc.game.getUpdatedPlayerCandidatesIndexes(clearCell.row)
            cvc.reloadChangedCells(changedCells)
            changedCells = cvc.game.getUpdatedAllCandidatesIndexes(clearCell.row)
            print("clearAnswer: unexpected candidateCntrl of \(cvc.candidateCntrl)!")
        }
        
        // enable or disable the "Undo" button
        cvc.gameStackDepth = cvc.game.getStackDepth()
                
        // update solvedDigits
        cvc.solvedDigits = cvc.game.getSolvedDigits()
        
        // Clear any help highlighted squares
        clearHelpHighlights(cvc)
    }

    func getIndexPathAtRow(_ cvc: CVController, row: Int) -> IndexPath? {
        // Check if the row is already the selectedCell.  If so, simply return it
        if cvc.selectedCell != nil {
            if cvc.selectedCell!.row == row {
                return cvc.selectedCell!
            }
        }
        // Now, get the indexPath corresponding to row and return it
        for cell in cvc.collectionView!.visibleCells {
            if let idxPath = cvc.collectionView!.indexPath(for: cell) {
                if idxPath.row == row {
                    return idxPath
                }
            }
        }
        // Didn't find row so return nil
        print("getIndexPathAtRow: Couldn't find \(row) in visibleCells, so returning nil")
        return nil
    }
    
    func highlightSolvedDigitButtons(_ cvc: CVController, _ solvedDigits: String) {
        if cvc.candidateCntrl < 1 {
            return
        }
        
        unHighlightSolvedDigitButtons()
        
        for digit in solvedDigits {
            if let btn = ds.getButtonWithTitle("\(digit)", buttonArray: buttonArray) {
                let btnTitles = ds.getAttributedTitlesOf("\(digit)")
                //btn.setAttributedTitle(btnTitles.solvedTitle, forState: UIControlState.Normal)
                btn.setAttributedTitle(btnTitles.disabledTitle, for: UIControlState())
                if btn.isEnabled { btn.isEnabled = false }
            }
        }
    }
    
    func unHighlightSolvedDigitButtons() {
        for digit in "123456789" {
            if let btn = ds.getButtonWithTitle("\(digit)", buttonArray: buttonArray) {
                let btnTitles = ds.getAttributedTitlesOf("\(digit)")
                btn.setAttributedTitle(btnTitles.normalTitle, for: UIControlState())
                if !btn.isEnabled { btn.isEnabled = true }
            }
        }
    }
    
    func getBackgroundColorsForCellAtIndex(_ cvc: CVController, _ idx: Int, _ selectedCell: IndexPath?, _ keypadDigit: String?, _ candidateCntrl: Int) -> [UIColor] {
        var colors = [UIColor]()
        
        if selectedCell != nil {
            if idx == selectedCell?.row {
                colors.append(selectedCellColor)
                colors.append(selectedCellColor)
                return colors
            }
        }
        if !cvc.helpView.highlightHelpCells.isEmpty {
            let squares = cvc.helpView.highlightHelpCells.map(){ $0.square }
            if squares.contains(idx) {
                colors.append(playerHelpViewColor)
                colors.append(playerHelpViewColor)
                return colors
            }
        }
        // good test block to see all colors
//        if cvc.game.isCellAnswered(idx) {
//            if let ansDigit = cvc.game.getCellWithIndex(idx, candidateCntrl: cvc.candidateCntrl) {
//                colors.append(digitsColorsArray[Int(ansDigit)!-1])
//                colors.append(digitsColorsArray[Int(ansDigit)!-1])
//            }
//        }
        if let playerDigits = getPlayerSelectedDigits(cvc) {
            if let cellDigits = cvc.game.getCellWithIndex(idx, candidateCntrl: cvc.candidateCntrl) {
                let cellDigitsInPlayerDigitsArray = cellDigits.filter() { playerDigits.range(of: String($0)) != nil }
                let firstColor = cvc.game.isCellAnswered(idx) ? digitsColorsArray[Int(cellDigits)!-1] : UIColor.white
                colors.append(firstColor)   // if the cell is answered, then firstColor is the color of the answer digit, else it's white
                for cellDigit in cellDigitsInPlayerDigitsArray {
                    colors.append(digitsColorsArray[Int(String(cellDigit))!-1])
                }
                if colors.count > 2 {
                    colors.remove(at: 0)    // remove UIColor.white if there are at least two other colors (digits)
                }
            }
            return colors
        }
        if colors.isEmpty { colors.append(UIColor.white) }
        return colors
    }
    
    func getPlayerSelectedDigits(_ cvc: CVController) -> String? {
        // create a string of keypadDigit and playableDigits, or return
        var highlightDigits: String? = nil
        if cvc.playableDigits != nil && cvc.keypadDigit != nil {
            if cvc.playableDigits!.range(of: cvc.keypadDigit!) != nil {
                highlightDigits = cvc.playableDigits!
            } else {
                highlightDigits = cvc.playableDigits! + cvc.keypadDigit!
            }
        } else if cvc.playableDigits != nil && cvc.keypadDigit == nil {
            highlightDigits = cvc.playableDigits!
        } else if cvc.playableDigits == nil && cvc.keypadDigit != nil {
            highlightDigits = cvc.keypadDigit!
        } else {        // playableDigits == nil && keypadDigit == nil
            //print("highlightCells: playableDigits == nil && keypadDigit == nil && highlightDigits == \"\"")
            highlightDigits = nil
        }
        return highlightDigits
    }
    
    func highlightCells(_ cvc: CVController) {
        
        if cvc.candidateCntrl < 1 { return }
        
        for cell in cvc.collectionView!.visibleCells as! [CVCell] {
            if let idxPath = cvc.collectionView!.indexPath(for: cell) {
                let colors = getBackgroundColorsForCellAtIndex(cvc, idxPath.row, cvc.selectedCell, cvc.keypadDigit, cvc.candidateCntrl)
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = cell.bounds
                if colors.first == UIColor.white {  // single playersDigits
                    gradientLayer.locations = cvc.game.isCellAnswered(idxPath.row) ? [1.0,1.0] : [0.25,0.75]
                    gradientLayer.colors = colors.map(){ $0.cgColor }
                    if cell.gradientLayer == nil {
                        cell.gradientLayer = gradientLayer
                        cell.layer.insertSublayer(gradientLayer, at: 0)
                    } else {
                        cell.layer.replaceSublayer(cell.gradientLayer!, with: gradientLayer)
                        cell.gradientLayer = gradientLayer
                    }
                } else if colors.first == selectedCellColor || colors.first == playerHelpViewColor {
                    gradientLayer.locations = [1.0,1.0]
                    gradientLayer.colors = colors.map(){ $0.cgColor }
                    if cell.gradientLayer == nil {
                        cell.gradientLayer = gradientLayer
                        cell.layer.insertSublayer(gradientLayer, at: 0)
                    } else {
                        cell.layer.replaceSublayer(cell.gradientLayer!, with: gradientLayer)
                        cell.gradientLayer = gradientLayer
                    }
                } else {    // must be multi playersDigits
                    gradientLayer.locations = [0.0,1.0]
                    gradientLayer.colors = colors.map(){ $0.cgColor }
                    if cell.gradientLayer == nil {
                        cell.gradientLayer = gradientLayer
                        cell.layer.insertSublayer(gradientLayer, at: 0)
                    } else {
                        cell.layer.replaceSublayer(cell.gradientLayer!, with: gradientLayer)
                        cell.gradientLayer = gradientLayer
                    }
                }
            }
        }
    }

}

