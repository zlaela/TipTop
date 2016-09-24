//
//  SettingsViewController.swift
//  TipTop
//
//  Created by lmohamed on 9/22/16.
//  Copyright © 2016 mhmd. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipPercent: UISegmentedControl!
    @IBOutlet weak var defaultBillAmount: UITextField!
    @IBOutlet weak var defaultNumAttendees: UITextField!
    
    // create handle to control
    let defaultTip = NSUserDefaults.standardUserDefaults()
    let defaultBill = NSUserDefaults.standardUserDefaults()
    let defaultNum = NSUserDefaults.standardUserDefaults()
    let defaultIndex = NSUserDefaults.standardUserDefaults()
    
    // keys for laziness
    let tipPercent = "tipPercent"
    let billAmount = "billAmount"
    let numGuests = "numGuests"
    let tipIndex = "tipIndex"
    
    @IBAction func saveDefaults(sender: AnyObject) {
        
        //print(defaultTipPercent.selectedSegmentIndex)
        let tipPercentIndex = defaultTipPercent.selectedSegmentIndex
        let tipPercentages = [0.15, 0.20, 0.25]
        let tipPercentChosen = tipPercentages[defaultTipPercent.selectedSegmentIndex]
        
        // want to save value to NSUserDefaults property list
        defaultIndex.setFloat(Float(tipPercentIndex), forKey: tipIndex)
        defaultTip.setFloat(Float(tipPercentChosen), forKey: tipPercent)
        defaultBill.setFloat(Float(defaultBillAmount.text!)!, forKey: billAmount)
        defaultNum.setFloat(Float(defaultNumAttendees.text!)!, forKey: numGuests)
        
        defaultIndex.synchronize()
        defaultTip.synchronize()
        defaultBill.synchronize()
        defaultNum.synchronize()
    }
    
    func getDefaults() {
        let defaultSettings = NSUserDefaults.standardUserDefaults()
            
        let index = defaultSettings.floatForKey(tipIndex) as? Float ?? 0
        let bill = defaultSettings.floatForKey(billAmount) as? Float ?? 15.0
        let guests = defaultSettings.floatForKey(numGuests) as? Float ?? 1.0
            
        defaultTipPercent.selectedSegmentIndex = Int(index)
        defaultBillAmount.text = String(format: "%.2f", bill)
        defaultNumAttendees.text =  String(format: "%.2f", guests)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getDefaults()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        getDefaults()
        
    }
}