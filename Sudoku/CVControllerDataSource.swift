//
//  CVControllerDataSource.swift
//  Sudoku
//
//  Created by dave herbine on 2/28/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation
import UIKit

var buttonArray = [UIButton]()                // Keypad buttons
//var defaultColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1, alpha: 1)
var defaultColor = UIColor.blue

class DSController {
    
    // MARK: UICollectionViewDataSource
    
    // "MarkerFelt-Thin", "BradleyHandITCTT-Bold", "ChalkboardSE-Regular", "ChalkboardSE-Light", "Chalkduster", "Noteworthy-Light"
    let fontName = "Noteworthy-Light"
    let fontNameScale: CGFloat = 0.8
    let numberPadDigits = ["1","2","3","4","5","6","7","8","9"]
    let actionButtons = ["Undo", "Help", "Answer"]
    
    func createLabelArray(_ cvc: CVController, digits: String?, _ cellIndex: Int, _ candidateCntrl: Int) -> [UILabel] {
        var labelArray = [UILabel]()
        
        let labelDigits = digits != nil ? digits : ""
        //        print("createLabelArray: labelDigits = \(labelDigits!)")
        
        let pStyle = NSMutableParagraphStyle()
        pStyle.alignment = NSTextAlignment.center
        var font: UIFont
        var fontColor = UIColor.black
        
        // Only blue if player entered answer or player entered candidate, otherwise givens and allCandidates are black
        if !cvc.game.isCellGiven(cellIndex) {
            if cvc.game.isCellAnswered(cellIndex) || (!cvc.game.isCellAnswered(cellIndex) && candidateCntrl == 1) {
                fontColor = UIColor.blue
            }
        }
        
        if labelDigits!.count > 1 || !cvc.game.isCellAnswered(cellIndex) {
            font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth/3)
            
            // Only change from systemFont if player entered answer or player entered candidate
            if !cvc.game.isCellGiven(cellIndex) && candidateCntrl != 2 {
                if let mfont = UIFont(name: fontName, size: (GridSize.sharedInstance.cellWidth/3)) {    // Don't multiply the hints by fontNameScale
                    font = mfont
                }
            }
        } else {
            font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth)
            if !cvc.game.isCellGiven(cellIndex) {
                if let mfont = UIFont(name: fontName, size: GridSize.sharedInstance.cellWidth*fontNameScale) {
                    font = mfont
                }
                if !cvc.game.isAnswerCorrect(cellIndex) && candidateCntrl > 0 {
                    fontColor = UIColor.red
                }
            }
        }
        //print("font.pointSize = \(font.pointSize)")
        
        if labelDigits!.count > 1 || !cvc.game.isCellAnswered(cellIndex) {
            for digit in labelDigits! {
                let digitInt = Int(String(digit))!           // if digits = 1,2,3,4,5,6,7,8,9
                let yOffset = (digitInt-1) / 3                  // ..yOffset = 0,0,0,1,1,1,2,2,2
                let xOffset = (digitInt+3 % 3) - 3*yOffset - 1  // ..xOffset = 0,1,2,0,1,2,0,1,2
                //print("digitInt = \(digitInt), xOffset = \(xOffset), yOffset = \(yOffset)")
                let labelFrame = CGRect(x: CGFloat(xOffset)*GridSize.sharedInstance.cellWidth/3,
                                        y: CGFloat(yOffset)*GridSize.sharedInstance.cellWidth/3,
                                        width: GridSize.sharedInstance.cellWidth/3,
                                        height: GridSize.sharedInstance.cellWidth/3)
                let label = UILabel(frame: labelFrame)
                let digitColor = (cvc.game.isValidCandidate(String(digit), cellIndex) || candidateCntrl == 2) ? fontColor : UIColor.red
                let attributedString = NSAttributedString(string: String(digit),
                                                          attributes: [
                                                            NSAttributedStringKey.paragraphStyle: pStyle,
                                                            NSAttributedStringKey.baselineOffset: NSNumber(value: 0 as Float),
                                                            NSAttributedStringKey.font: font,
                                                            NSAttributedStringKey.foregroundColor: digitColor,
                                                            ])
                label.attributedText = attributedString
                labelArray.append(label)
            }
        } else {
            let labelFrame = CGRect(x: 0, y: 0, width: GridSize.sharedInstance.cellWidth, height: GridSize.sharedInstance.cellWidth)
            let label = UILabel(frame: labelFrame)
            let attributedString = NSAttributedString(string: labelDigits!,
                                                      attributes: [
                                                        NSAttributedStringKey.paragraphStyle: pStyle,
                                                        NSAttributedStringKey.baselineOffset: NSNumber(value: 0 as Float),
                                                        NSAttributedStringKey.font: font,
                                                        NSAttributedStringKey.foregroundColor: fontColor,
                                                        ])
            label.attributedText = attributedString
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = GridSize.sharedInstance.cellBorderWidth
            labelArray.append(label)
        }
        
        return labelArray
    }
    
    func getDigitColor(_ digit: String, _ hCell: HelpCell) -> UIColor {
        let candidateFontColor = UIColor.black
        let ansDigitFontColor = UIColor.green
        let delDigitFontColor = UIColor.red
        let algDigitFontColor = UIColor.blue
        
        if hCell.ansDigit.contains(digit) {
            return ansDigitFontColor
        } else if hCell.delDigit.contains(digit) {
            return delDigitFontColor
        } else if hCell.algDigit.contains(digit) {
            return algDigitFontColor
        }
        return candidateFontColor
    }
    
    func createHighlightLabelArray(_ cvc: CVController, _ cellIndex: Int, _ allDigits: String, _ highlightDigits: HelpCell) -> [UILabel] {
        var labelArray = [UILabel]()
        
        let pStyle = NSMutableParagraphStyle()
        pStyle.alignment = NSTextAlignment.center
        var font: UIFont
        
        //if allDigits.characters.count > 1 {
        if !cvc.game.isCellAnswered(cellIndex) {
            font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth/3)
            for digit in allDigits {
                let digitInt = Int(String(digit))!           // if digits = 1,2,3,4,5,6,7,8,9
                let yOffset = (digitInt-1) / 3                  // ..yOffset = 0,0,0,1,1,1,2,2,2
                let xOffset = (digitInt+3 % 3) - 3*yOffset - 1  // ..xOffset = 0,1,2,0,1,2,0,1,2
                //print("digitInt = \(digitInt), xOffset = \(xOffset), yOffset = \(yOffset)")
                let labelFrame = CGRect(x: CGFloat(xOffset)*GridSize.sharedInstance.cellWidth/3,
                                        y: CGFloat(yOffset)*GridSize.sharedInstance.cellWidth/3,
                                        width: GridSize.sharedInstance.cellWidth/3,
                                        height: GridSize.sharedInstance.cellWidth/3)
                let label = UILabel(frame: labelFrame)
                let digitColor = getDigitColor(String(digit), highlightDigits)
                let attributedString = NSAttributedString(string: String(digit),
                                                          attributes: [
                                                            NSAttributedStringKey.paragraphStyle: pStyle,
                                                            NSAttributedStringKey.baselineOffset: NSNumber(value: 0 as Float),
                                                            NSAttributedStringKey.font: font,
                                                            NSAttributedStringKey.foregroundColor: digitColor,
                                                            ])
                label.attributedText = attributedString
                labelArray.append(label)
            }
        } else {    // It's Answered!
            let digitColor = cvc.game.isCellGiven(cellIndex) ? UIColor.black : UIColor.blue
            // Only change from systemFont if player entered answer
            var font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth)
            if !cvc.game.isCellGiven(cellIndex) {
                if let mfont = UIFont(name: fontName, size: (GridSize.sharedInstance.cellWidth*fontNameScale)) {
                    font = mfont
                }
            }
            let labelFrame = CGRect(x: 0, y: 0, width: GridSize.sharedInstance.cellWidth, height: GridSize.sharedInstance.cellWidth)
            let label = UILabel(frame: labelFrame)
            let attributedString = NSAttributedString(string: allDigits,
                                                      attributes: [
                                                        NSAttributedStringKey.paragraphStyle: pStyle,
                                                        NSAttributedStringKey.baselineOffset: NSNumber(value: 0 as Float),
                                                        NSAttributedStringKey.font: font,
                                                        NSAttributedStringKey.foregroundColor: digitColor,
                                                        ])
            label.attributedText = attributedString
            labelArray.append(label)
        }
        
        return labelArray
    }
    
    func createButtonArray(_ cvc: CVController) {
        
        removeButtons()
        
        // add numberPad Digit buttons
        
        var yOffset:Float = 0.0
        var xOffset:Float = 0.0
        for digit in numberPadDigits {
            let digitInt = Int(digit)       // if digits = 1,2,3,4,5,6,7,8,9

            // Here are the formulas to create a 3x3 keypad layout (used this before I switched to the linear layoout) 
            //yOffset = (digitInt-1) / 3                  // ..yOffset = 0,0,0,1,1,1,2,2,2
            //xOffset = (digitInt+3 % 3) - 3*yOffset - 1  // ..xOffset = 0,1,2,0,1,2,0,1,2

            // Here are the formulas to create a linear keypad layout
            yOffset = 0                             // ..yOffset = 0,0,0,0,0,0,0,0,0
            xOffset = Float(digitInt! - 1)          // ..xOffset = 0,1,2,3,4,5,6,7,8
            //print("digitInt = \(digitInt), xOffset = \(xOffset), yOffset = \(yOffset)")
            
            let digitButton = UIButton(type: UIButtonType.system)
            digitButton.frame = CGRect(x: CGFloat(xOffset)*GridSize.sharedInstance.cellWidth+GridSize.sharedInstance.lIndent,
                                  y: CGFloat(yOffset)*GridSize.sharedInstance.cellWidth+2*GridSize.sharedInstance.cellBorderWidth,
                                  width: GridSize.sharedInstance.cellWidth,
                                  height: GridSize.sharedInstance.cellWidth)
            let digitButtonTitles = getAttributedTitlesOf(digit)
            
            digitButton.setAttributedTitle(digitButtonTitles.normalTitle, for: UIControlState())
            digitButton.setAttributedTitle(digitButtonTitles.disabledTitle, for: UIControlState.disabled)
            digitButton.addTarget(cvc, action: #selector(CVController.numberPadProcess), for: UIControlEvents.touchUpInside)
            cvc.footer.addSubview(digitButton)
            
            buttonArray.append(digitButton)
        }
        
        // add numberPad Action buttons

        yOffset = 1
        xOffset = 0
        let actionButtonWidth = CGFloat(numberPadDigits.count) / CGFloat(actionButtons.count)
        
        for label in actionButtons {
            let actionButton = UIButton(type: UIButtonType.system)
            actionButton.frame = CGRect(x: CGFloat(xOffset)*GridSize.sharedInstance.cellWidth+GridSize.sharedInstance.lIndent,
                                  y: CGFloat(yOffset)*GridSize.sharedInstance.cellWidth+2*GridSize.sharedInstance.cellBorderWidth,
                                  width: GridSize.sharedInstance.cellWidth*actionButtonWidth,
                                  height: GridSize.sharedInstance.cellWidth)

            let btnTitles = getAttributedTitlesOf(label)

            actionButton.isEnabled = false
            
            buttonArray.append(actionButton)
            if label == "Undo" && cvc.gameStackDepth > 1 {
                actionButton.isEnabled = true
            }
            if label == "Help" {
                actionButton.isEnabled = true
            }
            
            actionButton.setAttributedTitle(btnTitles.normalTitle, for: UIControlState())
            actionButton.setAttributedTitle(btnTitles.disabledTitle, for: UIControlState.disabled)
            actionButton.addTarget(cvc, action: #selector(CVController.numberPadProcess), for: UIControlEvents.touchUpInside)
            cvc.self.footer.addSubview(actionButton)

            xOffset += Float(actionButtonWidth)    // Update the xOffset so they next button's CGRect is properly positioned
        }
        
    }
    
    func getAttributedTitlesOf(_ title: String) -> (normalTitle: NSAttributedString, disabledTitle: NSAttributedString, solvedTitle: NSAttributedString) {
        
        let pStyle = NSMutableParagraphStyle()
        pStyle.alignment = NSTextAlignment.center
        var font = UIFont.systemFont(ofSize: GridSize.sharedInstance.cellWidth)
        if let mfont = UIFont(name: fontName, size: GridSize.sharedInstance.cellWidth*fontNameScale) {
            font = mfont
        }
        
        // adjust the font size if it's an action button
        let rtnArray = actionButtons.filter { title.hasPrefix($0) == true }
        if !rtnArray.isEmpty {
            let currentFontSize = font.pointSize
            if let longestString = getLongestString(actionButtons) {
                font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: longestString))
            } else {
                font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "somethingLong"))
            }
            let preferredFontSize = font.pointSize
            let happyFontSize = floor((currentFontSize + preferredFontSize)/2)
            //            print("fontSizes current = \(currentFontSize), preferred = \(preferredFontSize), happy = \(happyFontSize)")
            if let mfont = UIFont(name: fontName, size: happyFontSize) {
                font = mfont
            }
        }
        
        let normalAttributedString = NSAttributedString(string: title,
            attributes: [
                NSAttributedStringKey.paragraphStyle: pStyle,
                NSAttributedStringKey.baselineOffset: NSNumber(value: 0 as Float),
                NSAttributedStringKey.font: font,
                NSAttributedStringKey.foregroundColor: defaultColor    //UIColor.blueColor()
            ])
        
        let disabledAttributedString = NSAttributedString(string: title,
            attributes: [
                NSAttributedStringKey.paragraphStyle: pStyle,
                NSAttributedStringKey.baselineOffset: NSNumber(value: 0 as Float),
                NSAttributedStringKey.font: font,
                NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)
            ])
        
        let solvedAttributedString = NSAttributedString(string: title,
            attributes: [
                NSAttributedStringKey.paragraphStyle: pStyle,
                NSAttributedStringKey.baselineOffset: NSNumber(value: 0 as Float),
                NSAttributedStringKey.font: font,
                NSAttributedStringKey.foregroundColor: UIColor.green
            ])
        
        return (normalAttributedString, disabledAttributedString, solvedAttributedString)
        
    }
    
    func getButtonWithTitle(_ title: String, buttonArray: [UIButton]) -> UIButton? {
        let rtnArray = buttonArray.filter { $0.titleLabel?.text?.hasPrefix(title) == true }
        return rtnArray.first
    }
    
    func getLongestString(_ strArray: [String]) -> String? {
        let countsOfstrArray = strArray.map { $0.count }
        let sortedcountsOfstrArray = countsOfstrArray.sorted() // sorts smallest to largest
        let largestOfstrArray = strArray.filter { $0.count == sortedcountsOfstrArray.last }
        return largestOfstrArray.first
    }
    
    func removeButtons() {
        let numberPadButtons = numberPadDigits + actionButtons
        
        for button in numberPadButtons {
            if let btn = getButtonWithTitle(button, buttonArray: buttonArray) {
                btn.removeFromSuperview()
            }
        }
        buttonArray = [UIButton]()                // reset Keypad buttons array
    }

}

