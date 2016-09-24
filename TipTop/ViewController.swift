//
//  ViewController.swift
//  TipTop
//
//  Created by lmohamed on 9/21/16.
//  Copyright © 2016 mhmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate { // View Controller is delegeat of text field

    // MARK:- IBoutlet
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var quickTipControl: UISegmentedControl!
    @IBOutlet weak var attendeeStepper: UIStepper!
    @IBOutlet weak var attendeeStepperLabel: UILabel!
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var tipPercentSliderLabel: UILabel!
    @IBOutlet weak var totalAmountPerPersonLabel: UILabel!
    
    // MARK:- Properties
    // initial values for tip calculator
    var tipCalculator = TipCalc(tipPercent: 18, billAmount: 25.0, numAttendees: 1, totalAmount: 29.5)

    //MARK:- View Controller
    func claculateControlTip(){
        let tipPercentages = [0.15, 0.20, 0.25]
        let tipPercentChosen = tipPercentages[quickTipControl.selectedSegmentIndex]
        
        // Move the slider to match the selection
        tipPercentSliderLabel.text = String(format: "%.0f%%", tipPercentChosen * 100)
        tipPercentSlider.value = Float(tipPercentChosen) ?? 0
        
        tipCalculator.tipPercent = Float(tipPercentChosen) ?? 0
        tipCalculator.billAmount = Float(billAmountField.text!) ?? 0
        tipCalculator.calculateTheTip()
        splitBill()
        updateUI()
    }
    func calculateSliderTip(){
        tipCalculator.tipPercent = tipPercentSlider.value ?? 0
        tipCalculator.billAmount = Float(billAmountField.text!) ?? 0
        tipCalculator.calculateTheTip()
        splitBill()
        updateUI()
    }
    func splitBill(){
        tipCalculator.numAttendees = Float(attendeeStepper.value)
        tipCalculator.splitTheBill()
        updateUI()
    }
    func roundTheTotal(){
        tipCalculator.totalAmount = round(tipCalculator.totalAmount)
        splitBill()
        updateUI()
    }
    func updateUI(){
        // update our fields
        tipAmountLabel.text = String(format: "$%.2f", arguments: [tipCalculator.tipAmount])
        totalAmountLabel.text = String(format: "$%.2f", arguments: [tipCalculator.totalAmount])
        if tipCalculator.numAttendees > 1 {
            attendeeStepperLabel.text = String(format: "%2.0f people:", arguments: [tipCalculator.numAttendees])
            totalAmountPerPersonLabel.text = String(format: "$%.2f/person", arguments: [tipCalculator.amountPerPerson])
        }
    }
    

    // MARK:- UIControl Events
    @IBAction func onTapHideKeyboard(sender: AnyObject) {
        
        // dismiss the keyboard on tapping anywhere
        view.endEditing(true)
    }
    @IBAction func billAmountFieldChanged(sender: AnyObject) {
        // delegated text field to the viewcontroller (view controller is representative of any UI control)
        // run the calculation as the bill amount is changed
        calculateSliderTip()
        updateUI()
    }
    @IBAction func tipPercentSliderChanged(sender: AnyObject) {
        // When the slider changes, change the text of the tip percent label
        tipPercentSliderLabel.text = String(format: "%.0f%%", arguments: [tipPercentSlider.value * 100])
        calculateSliderTip()
    }
    @IBAction func quickTipControlChanged(sender: AnyObject) {
        claculateControlTip()
    }
    @IBAction func numAttendeeStepperChanged(sender: AnyObject) {
        splitBill()
    }
    @IBAction func roundButtonTapped(sender: AnyObject) {
        roundTheTotal()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide the keyboard and run the slider tip calculation when the bill amount is changed
        if textField == billAmountField{
            textField.resignFirstResponder()
            claculateControlTip()
        }
        return true  // allow the keybard to return
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaultSettings = NSUserDefaults.standardUserDefaults()
        
        let tip = defaultSettings.floatForKey("tipPercent")
        let index = defaultSettings.floatForKey("tipIndex")
        let bill = defaultSettings.floatForKey("billAmount")
        let guests = defaultSettings.floatForKey("numGuests")
        let tipAmt = bill * tip
        let total = tipAmt + bill
        
        let tipCalculator = TipCalc(tipPercent: tip, billAmount: bill, numAttendees: guests, totalAmount: total)
        
        billAmountField.text = String(format: "%.2f", arguments:[tipCalculator.billAmount])
        totalAmountLabel.text = String(format: "$%.2f", arguments:[tipCalculator.totalAmount])
        tipAmountLabel.text = String(format: "$%.2f", arguments:[tipCalculator.tipAmount])
        tipPercentSliderLabel.text = String(format: "%.0f%%", arguments: [(tipCalculator.tipPercent * 100)])
        quickTipControl.selectedSegmentIndex = Int(index)
        
        // Calculate the tip from default quick tip amount
        claculateControlTip()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }



}

