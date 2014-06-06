//
//  swiftSorter.swift
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

import Foundation

struct swiftSorter {
    static func bubbleSort<T : Comparable>(arr : T[]) {
        var numSwaps = 0
        do {
            numSwaps = 0
            for i in 0..(arr.count - 1) {
                if arr[i] > arr[i + 1] {
                    var temp = arr[i]
                    arr[i] = arr[i + 1]
                    arr[i + 1] = temp
                    numSwaps++
                }
            }
        } while numSwaps != 0
    }
}