//
//  CRVHeader.swift
//  Sudoku
//
//  Created by dave herbine on 3/12/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit

class CRVHeader: UICollectionReusableView {
        
    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var challengeLevel: UISegmentedControl!
    
    @IBOutlet weak var candidatesLabel: UILabel!
    @IBOutlet weak var candidateCntrl: UISegmentedControl!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var Timer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
