//
//  SettingsViewController.swift
//  tipsy
//
//  Created by Sahil Amoli on 9/4/14.
//  Copyright (c) 2014 box. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    // Constants
    let defaultTipIndexKey = "default_tip_index"

    // UI selectors
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    // Helpers
    // @TODO: Since both ViewControllers use similar helpers, ideally these would live in one place instead of repeated
    func saveDefaultTipIndex(indexValue: Int) -> () {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(indexValue, forKey: defaultTipIndexKey)
        defaults.synchronize()
    }

    func retrieveDefaultTipIndex() -> Int {
        var defaults = NSUserDefaults.standardUserDefaults()
        return defaults.integerForKey(defaultTipIndexKey)
    }

    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var defaultTipIndex = retrieveDefaultTipIndex()
        defaultTipControl.selectedSegmentIndex = defaultTipIndex
    }

    // Action handlers
    @IBAction func onDefaultTipValueChanged(sender: AnyObject) {
        var newDefaultTip = defaultTipControl.selectedSegmentIndex
        saveDefaultTipIndex(newDefaultTip);
    }
}
