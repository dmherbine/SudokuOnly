//
//  CVControllerGesture.swift
//  Sudoku
//
//  Created by dave herbine on 5/5/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import Foundation
import UIKit

 class GRController {

    var np = NPController()
    
    func dtGiven(_ cvc: CVController, _ cell: Int, _ content: String) {
        let alertTitle = "This given square (\(cell+1)) has a value of \"\(content)\""
        let alertMessage = "do you want to make it the Answer digit?"
        print("\(alertTitle)\n\(alertMessage)")
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
        let setAnsAction = UIAlertAction(title: "Set \"\(content)\" as the \"Answer\" digit", style: .default) { (action) in cvc.keypadDigit = content }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(setAnsAction)
        alertController.addAction(cancelAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
    func dtAnswered(_ cvc: CVController, _ cell: Int, _ content: String) {
        let alertTitle = "This Answered square (\(cell+1)) has a value of \"\(content)\""
        let alertMessage = "What do you want to do with it?"
        print("\(alertTitle)\n\(alertMessage)")
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
        let clearAction = UIAlertAction(title: "Clear \"\(content)\"", style: .default) { (action) in self.np.clearAnswer(cvc, clearCell: cvc.selectedCell!) }
        let changeAction = UIAlertAction(title: "Change \"\(content)\" from Answer to Candidate", style: .default) { (action) in
            self.np.clearAnswer(cvc, clearCell: cvc.selectedCell!)
            self.np.addPlayerCandidate(cvc, content)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(clearAction)
        alertController.addAction(changeAction)
        alertController.addAction(cancelAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
    func dtPlayerCandidate(_ cvc: CVController, _ cell: Int, _ content: String) {
        let alertTitle = "This square (\(cell+1)) has a value of \"\(content)\""
        let alertMessage = "do you want to clear it?"
        print("\(alertTitle)\n\(alertMessage)")
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
        let clearAction = UIAlertAction(title: "Clear \"\(content)\"", style: .default) { (action) in self.np.clearPlayerCandidateFromCell(cvc, candidateDigit: content, clearCell: cvc.selectedCell!) }
        alertController.addAction(clearAction)
        if content.count > 1 {
            for mDigit in content {
                let clearAction = UIAlertAction(title: "Clear \"\(mDigit)\"", style: .default) { (action) in self.np.clearPlayerCandidateFromCell(cvc, candidateDigit: String(mDigit), clearCell: cvc.selectedCell!) }
                alertController.addAction(clearAction)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
    func dtPossible(_ cvc: CVController, _ cell: Int, _ content: String) {
        let alertTitle = "This square (\(cell+1))'s answer could be any of these digits: \"\(content)\"..."
        let alertMessage = "do you want to select one?"
        print("\(alertTitle)\n\(alertMessage)")
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
    func noIndexPath(_ cvc: CVController, _ gesture: String) {
        var alertTitle = "Your \(gesture) wasn't on a cell, so here's some info:"
        if cvc.game.savedName != nil {
            alertTitle = "Here's info on this saved puzzle from " + cvc.game.savedName!
        }
        alertTitle = "Here's info on this favorite puzzle: " + cvc.game.favName
        var alertMessage = "Odd, but I don't know how to solve this one"
        if let solvedAlgo = cvc.game.gamePuzzles.solvingAlgorithm {
            switch solvedAlgo {
            case .solvedByCP:
                alertMessage = "You can solve this \(cvc.game.gamePuzzles.type) puzzle by simply applying the One Rule"
            case .solvedByDF:
                alertMessage = "You may need to solve this \(cvc.game.gamePuzzles.type) puzzle by trial and error"
            case .solvedByT1UR:
                alertMessage = "You can solve this \(cvc.game.gamePuzzles.type) puzzle by finding a Type 1 Unique Rectangle"
            case .solvedByPairs:
                alertMessage = "You can solve this \(cvc.game.gamePuzzles.type) puzzle by finding a Naked or Hidden Pair"
            }
        }
        print("\(alertTitle)\n\(alertMessage)")
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
    func timerAction(_ cvc: CVController, _ gesture: String) {
        let alertTitle = "Your \(gesture) was on the Timer ..."
        let alertMessage = "A single tap starts the timer.  A double tap stops the timer.  A long press blanks the timer."
        print("\(alertTitle)\n\(alertMessage)")
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        cvc.present(alertController, animated: true, completion: nil)
    }
    
}
