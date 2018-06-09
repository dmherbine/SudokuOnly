//
//  GridSize.swift
//  Sudoku
//
//  Created by dave herbine on 3/28/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation
import UIKit

class GridSize: NSObject {

    var cellWidth: CGFloat = 0.0
    let cellBorderWidth: CGFloat = 0.5
    var indents: CGFloat = 0.0
    var lIndent: CGFloat = 0.0
    var rIndent: CGFloat = 0.0
    var cell40Center: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    var headerWidth: CGFloat = 0.0
    var headerHeight: CGFloat = 0.0
    var footerWidth: CGFloat = 0.0
    var footerHeight: CGFloat = 0.0
    
    override init() {
        //
        // Calculate the collection view's cell width, left indent, and right indent blocks
        //
        let deviceSize = UIScreen.main.bounds.size
        let widthSize = floor(Float(deviceSize.width/9))
        let heightSize = floor(Float(deviceSize.height/(9+4)))
        cell40Center = CGPoint(x: deviceSize.width, y: deviceSize.height)
        cellWidth = widthSize >= heightSize ? CGFloat(heightSize) : CGFloat(widthSize)
        indents = deviceSize.width - cellWidth*9
        lIndent = floor(indents/2)
        rIndent = floor(indents/2 + (indents.truncatingRemainder(dividingBy: 2)))
        print("SudokuGridSize: cellWidth = \(cellWidth), indents = \(indents), left = \(lIndent), right = \(rIndent), center = \(cell40Center)")

        //
        // Calculate the header and footer sizes for their UICollectionViewDelegateFlowLayout methods
        //
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.height, statusBarSize.width)
        print("SudokuGridSize: statusBarHeight = \(statusBarHeight)")
        headerHeight = cellWidth*2 + statusBarHeight*1.5
        headerWidth = cellWidth*9
        footerHeight = cellWidth*2
        footerWidth = headerWidth
        print("SudokuGridSize: headerHeight = \(headerHeight), headerWidth = \(headerWidth), footerHeight = \(footerHeight), footerWidth = \(footerWidth)")
    }

    //Create a class variable as a computed type property. The class variable can be called without having to instantiate the class GridSize
    class var sharedInstance: GridSize {

        //Nested within the class variable is a struct called "Singleton"
        struct Singleton {

            //Singleton wraps a static constant variable "instance". Declaring a property as static means this property only exists once. Also note that static properties in Swift are implicitly lazy, which means that Instance is not created until it’s needed.
            static let instance = GridSize()
        }
        
        return Singleton.instance
    }
    
}
