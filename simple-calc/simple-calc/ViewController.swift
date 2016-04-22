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
            case "➕": simpleOp(add)
            case "➖": simpleOp(subtract)
            case "➗": simpleOp(divide)
            case "✖️": simpleOp(multiply)
            case "%": simpleOp(mod)
            case "count": count()
            case "avg": avg()
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
        if isInput && sender.currentTitle != "count" && sender.currentTitle != "avg" {
            enter()
        } else {
            isInput = false
        }
        operation = sender.currentTitle!
        switch operation {
            case "fact":
                fact()
            case "count":
                if operation != sender.currentTitle! {
                    operandStack.removeAll()
                }
                operandStack.append(displayValue)
            case "avg":
                if operation != sender.currentTitle! {
                    operandStack.removeAll()
                }
                operandStack.append(displayValue)
            default: break
        }
    }
    
    func fact() {
        if operandStack.count >= 1 {
            var num = Int(operandStack.removeLast())
            var result = num
            while num - 1 > 1 {
                num -= 1
                result *= num
            }
            displayValue = Double(result)
            operandStack.append(Double(result))
        }
    }
    
    func count() {
        displayValue = Double(operandStack.count)
        operandStack.removeAll()
        operandStack.append(Double(operandStack.count))
    }
    
    func avg() {
        var sum = operandStack[0]
        for index in 1...operandStack.count - 1 {
            sum += operandStack[index]
        }
        displayValue = Double(sum / Double(operandStack.count))
        operandStack.removeAll()
        operandStack.append(Double(sum / Double(operandStack.count)))
    }
    
    func simpleOp(op: (Double, Double) -> Double) {
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
        return Double(Int(input1) % Int(input2))
    }

}

