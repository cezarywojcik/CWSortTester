//
//  ViewController.swift
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var yMax : CGFloat = 0
    
    var swiftResults = Array<Double>()
    var objcResults = Array<Double>()
    
    @IBOutlet var graphView : GraphView
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        var arr = getRandomIntArray(500)
        var start = NSDate.date()
        swiftSorter.bubbleSort(arr)
        var timeInterval = -1 * start.timeIntervalSinceNow
        println("Swift Time: \(timeInterval)s")
        
        arr = getRandomIntArray(500)
        start = NSDate.date()
        objcSorter.bubbleSort(arr)
        timeInterval = -1 * start.timeIntervalSinceNow
        println("Objc Time: \(timeInterval)s")
    }
    
    @IBAction func bubbleSortPressed(sender : UIBarButtonItem) {
        swiftResults = testSortRange(1, to: 100, step: 10) {
            swiftSorter.bubbleSort($0)
        }
        self.graphView.drawSwiftGraph(swiftResults)
        objcResults = testSortRange(1, to: 100, step: 10) {
            objcSorter.bubbleSort($0)
        }
        self.graphView.drawObjcGraph(objcResults)

    }
    
    func testSortRange(from : Int, to: Int, step: Int, sortFunction: (Int[]) -> ()) ->
        Array<Double> {
        var result = Array<Double>()
        for var i = from; i < to ; i += step {
            var arr = getRandomIntArray(i)
            var start = NSDate.date()
            sortFunction(arr)
            var timeInterval = -1 * start.timeIntervalSinceNow
            result += timeInterval
        }
        return result
    }

    func getRandomIntArray(arraySize : Int) -> Int[] {
        var arr : Int[] = []
        for _ in 0..arraySize {
            arr += Int(arc4random())
        }
        return arr
    }
}

