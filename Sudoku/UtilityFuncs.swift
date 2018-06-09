//
//  UtilityFuncs.swift
//  Sudoku
//
//  Created by dave herbine on 6/4/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import Foundation

func getTimeStamp() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    let date = Date()
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from: date)
}

//
// sliceArray() and combinations() effectively implement finding all the non repetitive k-combinations of an n-element set
//  The number of k-combinations is determined by the Binomial Coefficient C(n, k) = n!/((n-k)!k!)
//
func sliceArray<T>(_ arr: Array<T>, _ lower: Int, _ upper: Int) -> Array<T> {
    var subArr: Array<T> = []
    
    if lower > upper { return [] }
    
    for i in lower...upper {
        subArr.append(arr[i])
    }
    return subArr
}

func combinations<T>(_ arr: Array<T>, _ k: Int) -> Array<Array<T>> {
    var ret: Array<Array<T>> = []
    var sub: Array<Array<T>> = []
    var next: Array<T> = []
    
    for i in 0..<arr.count {
        
        if(k == 1){
            ret.append([arr[i]])
        } else {
            sub = combinations(sliceArray(arr, i+1, arr.count-1), k-1)
            
            for subI in 0..<sub.count {
                next = sub[subI]
                next.insert(arr[i], at: 0)
                ret.append(next)
            }
        }
    }
    return ret
}

//func getLastDigitOf(digits: String) -> String {
//    if digits.characters.count > 1 {
//        return digits.substringFromIndex(digits.startIndex.advancedBy(digits.characters.count-1))
//    } else {
//        return digits
//    }
//}


// uniq() filters an array to only those values that are unique.
//
// No longer used as of 4/8/2016, but I may need it so I'll leave it for now
//
//func uniq<S : SequenceType, T : Hashable where S.Generator.Element == T>(source: S) -> [T] {
//    var buffer = Array<T>()
//    var addedDict = [T: Bool]()
//    for elem in source {
//        if !(addedDict[elem]?.hashValue != nil) {
//            addedDict[elem] = true
//            buffer.append(elem)
//        }
//    }
//    return buffer
//}

