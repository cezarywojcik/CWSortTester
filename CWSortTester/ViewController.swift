//
//  ViewController.swift
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

import UIKit

enum sortTypes: Int {
    case bubbleSort = 0
    case quickSort = 1
    case nativeSort = 2
}

class ViewController: UIViewController {
    
    var yMax : CGFloat = 0
    
    var swiftResults = Array<Double>()
    var objcResults = Array<Double>()
    
    var from = 1
    var to = 100
    var step = 10
    
    var selectedSort : sortTypes = .quickSort
    
    var sortLog : [String] = []
    
    @IBOutlet var testSortButton : UIBarButtonItem!
    @IBOutlet var sortSelectionButton : UIBarButtonItem!
    @IBOutlet var sortLogButton : UIBarButtonItem!
    @IBOutlet var graphView : GraphView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.graphView.drawSwiftGraph(self.swiftResults)
        self.graphView.drawObjcGraph(self.objcResults)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var navigationViewController = segue.destinationViewController as UINavigationController
        if sender as UIBarButtonItem == self.sortSelectionButton {
            var settingsViewController = navigationViewController.topViewController as SettingsViewController
            settingsViewController.from = self.from
            settingsViewController.to = self.to
            settingsViewController.step = self.step
            settingsViewController.selectedIndex = self.selectedSort.toRaw()
            settingsViewController.mainViewControler = self
        } else if sender as UIBarButtonItem == self.sortLogButton {
            var logViewController = navigationViewController.topViewController as LogViewController
            logViewController.sortLog = self.sortLog
        }
    }
    
    @IBAction func testSortPressed(sender : UIBarButtonItem) {
        self.sortLog.append("\(getSortName()) for \(self.to) random integers:")
        switch self.selectedSort {
        case .bubbleSort:
            self.testSorts(swiftSort: {(var arr: [Int]) -> () in swiftSorter.bubbleSort(&arr)},
                objcSort: {objcSorter.bubbleSort($0)})
        case .quickSort:
            self.testSorts(swiftSort: {(var arr: [Int]) -> () in swiftSorter.quickSort(&arr, left: 0, right: arr.count - 1)},
                objcSort:{objcSorter.quickSort($0, left: 0, right: $0.count - 1)})
        case .nativeSort:
            self.testSorts(swiftSort: {(var arr: [Int]) -> () in swiftSorter.nativeSort(&arr)},
                objcSort: {objcSorter.nativeSort($0)})
        }
    }
    
    func getSortName() -> String {
        switch self.selectedSort {
        case .bubbleSort:
            return "Bubble Sort"
        case .quickSort:
            return "Quick Sort"
        case .nativeSort:
            return "Native Sort"
        default:
            return "No Sort Selected"
        }
    }
    
    func update() {
        self.sortSelectionButton.title = getSortName()
    }
    
    func testSorts(#swiftSort: ([Int]) -> (), objcSort: ([Int]) -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            self.swiftResults = self.testSortRange(self.from, to: self.to, step: self.step) {
                swiftSort($0)
            }
            let swiftTime = self.swiftResults[self.swiftResults.count - 1]
            self.sortLog.append("Swift Time: \(swiftTime)s")
            self.graphView.drawSwiftGraph(self.swiftResults)
            self.objcResults = self.testSortRange(self.from, to: self.to, step: self.step) {
                objcSort($0)
            }
            let objcTime = self.objcResults[self.objcResults.count - 1]
            self.sortLog.append("Obj-C Time: \(objcTime)s")
            self.graphView.drawObjcGraph(self.objcResults)
            self.sortLog.append("Obj-C was \(swiftTime / objcTime)x faster")
        }
    }
    
    func testSortRange(from : Int, to: Int, step: Int, sortFunction: ([Int]) -> ()) ->
        Array<Double> {
        var result = Array<Double>()
        for var i = from; i < to ; i += step {
            var arr = self.getRandomIntArray(i)
            var start = NSDate.date()
            sortFunction(arr)
            var timeInterval = -1 * start.timeIntervalSinceNow
            result.append(timeInterval)
        }
        return result
    }

    func getRandomIntArray(arraySize : Int) -> [Int] {
        var arr : [Int] = []
        for _ in 0..<arraySize {
            arr.append(Int(arc4random()))
        }
        return arr
    }
}

