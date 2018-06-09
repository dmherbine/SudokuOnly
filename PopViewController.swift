//
//  PopViewController.swift
//  Sudoku
//
//  Created by dave herbine on 4/24/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit
//import MoPub // Temporarily commented out on 8/25/2017

class PopViewController: UIViewController, UITextFieldDelegate { //}, MPInterstitialAdControllerDelegate { // Temporarily commented out on 8/25/2017
    
    var gameVC: CVController? = nil
    var popWittyMessage: String? = nil
    var popReturnAction: String? = nil
    var showAd = false

    @IBOutlet weak var wittyMessage: UILabel!
    @IBOutlet weak var playAnother: UIButton!   // needed to animate in PopAnimator
    @IBOutlet weak var saveAsFav: UITextField!     // needed to animate in PopAnimator

    // TODO: Replace this test id with my personal ad unit id
    /*var interstitial: MPInterstitialAdController =
        MPInterstitialAdController(forAdUnitId: "77ce0b65cf81438eb255695afe3b1904")*/ // Temporarily commented out on 8/25/2017

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        saveAsFav.delegate = self

        //self.interstitial.delegate = self // Temporarily commented out on 8/25/2017
        // Pre-fetch the ad up front
        //self.interstitial.loadAd() // Temporarily commented out on 8/25/2017
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if popWittyMessage != nil {
            wittyMessage.text = popWittyMessage
        }
    }
    
/*
    func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController) {
        // This sample automatically shows the ad as soon as it's loaded, but
        // you can move this showFromViewController call to a time more
        // appropriate for your app.
        if (interstitial.ready && showAd) {
            interstitial.show(from: self)
            showAd = false
        }
    }
    
    func interstitialWillDisappear(_ interstitial: MPInterstitialAdController!) {
        print("Ad will disappear")
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
 */ // Temporarily commented out on 8/25/2017

    @IBAction func popDismiss(_ sender: UIButton) {
        showAd = true
        //interstitialDidLoadAd(interstitial) // Temporarily commented out on 8/25/2017
        if gameVC != nil {
            print("popDismiss: gameVC != nil")
            gameVC!.popReturnAction = "playAnother" //sender.titleLabel?.text
        } else {
            print("popDismiss: gameVC == nil")
        }
//        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
        
// UITextFieldDelegate Functions
    
    // This is to capture the text entered in the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let fName = textField.text {
            // trim leading and trailing whitespace (but embedded whitespace remains)
            let trimmedfName = fName.trimmingCharacters(in: CharacterSet.whitespaces)
            if trimmedfName.count > 0 {  // Also need to make sure it's unique or force it to be unique with a time stamp
                print("textFieldDidEndEditing: textField.text = \"\(fName)\", trimmed = \"\(trimmedfName)\"")
                if gameVC != nil {
                    // I do have access to gameVC.game
                    print("textFieldDidEndEditing: gameVC != nil")
                    gameVC!.saveAsFavorite(trimmedfName)
                    gameVC!.startNewGame(nil)
                } else {
                    print("textFieldDidEndEditing: gameVC == nil")
                }
                showAd = true
                //interstitialDidLoadAd(interstitial) // Temporarily commented out on 8/25/2017
//                presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print("textFieldDidEndEditing: textField.text = \"\(String(describing: textField.text))\", trimmed = \"\(trimmedfName)\"")
            }
        }
        return
    }
    
    // This is to dismiss the keyboard on the "Return" key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
