//
//  ViewController.swift
//  simple-calc
//
//  Created by MyungJin Eun on 4/19/16.
//  Copyright © 2016 MyungJin Eun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var isInput = false
    var operandStack = Array<Double>()
    
    @IBAction func enternumber(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isInput {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isInput = true
        }
    }
    
    @IBAction func enter() {
        isInput = false
        operandStack.append(displayValue)
        
        print("operandStack = \(operandStack)")
    }
     
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        } set {
            display.text = "\(newValue)"
            isInput = false
        }
    }
    
    @IBAction func clear() {
        displayValue = 0
        display.text = "\(displayValue)"
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if isInput {
            enter()
        }
        switch operation {
            case "➕": performOp(add)
            case "➖": performOp(subtract)
            case "➗": performOp(divide)
            case "✖️": performOp(multiply)
            case "%": performOp(mod)
            default: break
        }
    }
    
    func performOp(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            
            enter()
        } else if operandStack.count == 1 {
            displayValue = operandStack.removeLast()
            
            enter()
        }
    }
    
    
    let add = {(input1 : Double, input2 : Double) -> Double in
        return input1 + input2
    }
    
    let subtract = {(input1 : Double, input2 : Double) -> Double in
        return input1 - input2
    }
    
    let multiply = {(input1 : Double, input2 : Double) -> Double in
        return input1 * input2
    }
    
    let divide = {(input1 : Double, input2 : Double) -> Double in
        return input1 / input2
    }
    
    let mod = {(input1 : Double, input2 : Double) -> Double in
        return input1 % input2
    }
    
}

