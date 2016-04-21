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
    var operation = ""
    
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
        if operation == "" {
            operandStack.removeAll()
        }
        operandStack.append(displayValue)
        
        print("operandStack = \(operandStack)")
        
        switch operation {
            case "➕": performOp(add)
            case "➖": performOp(subtract)
            case "➗": performOp(divide)
            case "✖️": performOp(multiply)
            case "%": performOp(mod)
            default: break
        }
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
        if isInput {
            enter()
        }
        
        operation = sender.currentTitle!
    }
    
    func performOp(op: (Double, Double) -> Double) {
        operation = ""
        if operandStack.count >= 2 {
            let input2 = operandStack.removeLast()
            let input1 = operandStack.removeLast()
            displayValue = op(input1, input2)
            
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

