//
//  TipCalc.swift
//  TipTop
//
//  Created by lmohamed on 9/21/16.
//  Copyright © 2016 mhmd. All rights reserved.
//

import Foundation


class TipCalc {
    
    //what is the public API. how will other classes interact with this/get access to this?
    
    var tipPercent: Float = 0
    var tipAmount: Float = 0
    var billAmount: Float = 0
    var totalAmount: Float = 0
    var numAttendees: Float = 1
    var amountPerPerson: Float = 0
    
    // instructor or initializer for the TipCalc class
    init(tipPercent: Float, billAmount: Float, numAttendees: Float, totalAmount: Float){
        
        //when I instantiate/create an object from TipCalc I need to provide amt
        self.billAmount = billAmount
        self.tipPercent = tipPercent
    }
    
    func calculateTheTip() {
        tipAmount = billAmount * tipPercent
        totalAmount = billAmount + tipAmount
    }
    
    func splitTheBill(){
        amountPerPerson = totalAmount / numAttendees
    }
    
}