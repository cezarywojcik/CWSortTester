//
//  SettingsViewController.swift
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/6/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    weak var mainViewControler : ViewController!
    
    @IBOutlet var fromSlider : UISlider!
    @IBOutlet var toSlider : UISlider!
    @IBOutlet var stepSlider : UISlider!
    
    @IBOutlet var fromLabel : UILabel!
    @IBOutlet var toLabel : UILabel!
    @IBOutlet var stepLabel : UILabel!
    
    var from : Int!
    var to : Int!
    var step : Int!
    
    var selectedIndex : Int!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        var saveButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: "saveButtonPressed")
        self.navigationController!.topViewController.navigationItem.rightBarButtonItem = saveButton
        self.fromSlider.value = Float(from)
        self.toSlider.value = Float(to)
        self.stepSlider.value = Float(step)
        updateLabels()
        if self.selectedIndex != nil {
            var indexPath : NSIndexPath = NSIndexPath(forRow: self.selectedIndex!, inSection: 0)
            self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Top)
        }
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.selectedIndex = indexPath.row;
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.mainViewControler.from = self.from
        self.mainViewControler.to = self.to
        self.mainViewControler.step = self.step
        if self.selectedIndex != nil {
            self.mainViewControler.selectedSort = sortTypes.fromRaw(self.selectedIndex)!
        }
        self.mainViewControler.update()
    }
    
    func updateLabels() {
        self.from = Int(self.fromSlider.value)
        self.to = Int(self.toSlider.value)
        self.step = Int(self.stepSlider.value)
        self.fromLabel.text = "\(from)"
        self.toLabel.text = "\(to)"
        self.stepLabel.text = "\(step)"
    }
    
    func checkStepValue() {
        self.stepSlider.maximumValue = self.toSlider.value - self.fromSlider.value
    }

    @IBAction func fromSliderChanged(sender : UISlider) {
        self.toSlider.minimumValue = self.fromSlider.value + 1;
        checkStepValue()
        updateLabels()
    }
    
    @IBAction func toSliderChanged(sender : UISlider) {
        if self.toSlider.value == self.fromSlider.value {
            self.toSlider.value++
        }
        checkStepValue()
        updateLabels()
    }
    
    @IBAction func stepSliderChanged(sender : AnyObject) {
        checkStepValue()
        updateLabels()
    }
    
    func saveButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
