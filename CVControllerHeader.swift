//
//  CVControllerHeader.swift
//  Sudoku
//
//  Created by dave herbine on 4/13/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation
import UIKit

extension CVController {

    @IBAction func challengeAction(_ sender: UISegmentedControl) {
        challengeLevel = sender.selectedSegmentIndex
    }
    
    @IBAction func candidateAction(_ sender: UISegmentedControl) {
        candidateCntrl = sender.selectedSegmentIndex
    }
    
}
