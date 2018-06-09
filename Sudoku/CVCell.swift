//
//  CVCell.swift
//  Sudoku
//
//  Created by dave herbine on 2/23/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit

class CVCell: UICollectionViewCell {

    //    @IBOutlet weak var square: UILabel!
    var square = [UILabel]()
    
    var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSelected = false
    }
     
}
