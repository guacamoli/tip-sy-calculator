//
//  ViewController.swift
//  tipsy
//
//  Created by Sahil Amoli on 9/3/14.
//  Copyright (c) 2014 box. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Constants
    let defaultTipIndexKey = "default_tip_index"
    let tipPercentages = [0.18, 0.20, 0.25]

    // Member Vars
    var currentKnownDefaultTipIndex = Int()

    // UI selectors
    @IBOutlet weak var tipAmountControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    // Helpers
    func getReadableDollarAmountFromDouble(value: Double) -> String {
        return String(format: "$%.2f", value)
    }

    func retrieveDefaultTipIndex() -> Int {
        var defaults = NSUserDefaults.standardUserDefaults()
        return defaults.integerForKey(defaultTipIndexKey)
    }

    func setDefaultTipPercentageState(value: Int) -> () {
        tipAmountControl.selectedSegmentIndex = value;
        currentKnownDefaultTipIndex = value
    }

    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        var defaultTipPercentageIndex = retrieveDefaultTipIndex()

        // Set correct state for the segmented control on initial load
        setDefaultTipPercentageState(defaultTipPercentageIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var defaultTipPercentageIndex = retrieveDefaultTipIndex()
        
        // Only update the state if the user has changed the the default tip percentage (when coming back to the main view)
        // This allows for better user experience since the user could be in the middle of a calculation, then decides to go to the settings page but ends up not making a change -- when they come back to the main view, their transaction should not be modified!
        if currentKnownDefaultTipIndex != defaultTipPercentageIndex {
            setDefaultTipPercentageState(defaultTipPercentageIndex)
        }

    }

    // Action handlers
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentage = tipPercentages[tipAmountControl.selectedSegmentIndex]
        var billAmount = NSString(string: billField.text).doubleValue

        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = getReadableDollarAmountFromDouble(tip)
        totalLabel.text = getReadableDollarAmountFromDouble(total)
    }

    @IBAction func onTap(sender: AnyObject) {
         view.endEditing(true)
    }
}
