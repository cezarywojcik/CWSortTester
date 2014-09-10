//
//  swiftSorter.swift
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

import Foundation

struct swiftSorter {
    static func bubbleSort<T : Comparable>(inout arr : [T]) {
        var numSwaps = 0
        do {
            numSwaps = 0
            for i in 0..<(arr.count - 1) {
                if arr[i] > arr[i + 1] {
                    (arr[i], arr[i + 1]) = (arr[i + 1], arr[i])
                    numSwaps++
                }
            }
        } while numSwaps != 0
    }
    
    static func quickSort<T : Comparable>(inout arr : [T], left: Int, right: Int) {
        if right > left {
            var i = left
            for j in (left + 1)..<(right + 1) {
                if arr[j] < arr[left] {
                    i++
                    (arr[i], arr[j]) = (arr[j], arr[i])
                }
            }
            (arr[i], arr[left]) = (arr[left], arr[i])
            quickSort(&arr, left: left, right: i - 1)
            quickSort(&arr, left: i + 1, right: right)
        }
    }
    
    static func nativeSort<T : Comparable>(inout arr : [T]) {
        sort(&arr)
    }
}