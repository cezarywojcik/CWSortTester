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
    
    var from = 1
    var to = 1000
    var step = 100
    
    @IBOutlet var graphView : GraphView
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func bubbleSortPressed(sender : UIBarButtonItem) {
        testSorts({swiftSorter.bubbleSort($0)}, objcSort: {objcSorter.bubbleSort($0)})
    }
    
    @IBAction func quickSortPressed(sender : UIBarButtonItem) {
        testSorts({swiftSorter.quickSort($0, left: 0, right: $0.count - 1)},
            objcSort:{objcSorter.quickSort($0, left: 0, right: $0.count - 1)})
    }
    
    @IBAction func nativeSortPressed(sender : UIBarButtonItem) {
        testSorts({swiftSorter.nativeSort($0)}, objcSort: {objcSorter.nativeSort($0)})
    }
    
    func testSorts(swiftSort: (Int[]) -> (), objcSort: (Int[]) -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            self.swiftResults = self.testSortRange(self.from, to: self.to, step: self.step) {
                swiftSort($0)
            }
            self.graphView.drawSwiftGraph(self.swiftResults)
            self.objcResults = self.testSortRange(self.from, to: self.to, step: self.step) {
                objcSort($0)
            }
            self.graphView.drawObjcGraph(self.objcResults)
        }
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

