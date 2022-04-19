//
//  CalculatorEngine.swift
//  Calculator
//
//  Created by Екатерина Неделько on 18.04.22.
//

import Foundation

class CalculatorEngine {
    
    static let shared = CalculatorEngine()
    
    private init() { }
    
    func equal(firstNumber: Double, secondNumber: Double, operatorValue: Operator) -> Double {
        switch operatorValue {
        case .plus:
            return add(firstNumber, to: secondNumber)
        case .minus:
            return minus(firstNumber, from: secondNumber)
        case .divide:
            return divide(firstNumber, from: secondNumber)
        case .multiply:
            return multiply(firstNumber, from: secondNumber)
        }
    }
    
    private func add(_ firstNumber: Double, to secondNumber: Double) -> Double {
        firstNumber + secondNumber
    }
    
    private func minus(_ firstNumber: Double, from secondNumber: Double) -> Double {
        firstNumber - secondNumber
    }
    
    private func divide(_ firstNumber: Double, from secondNumber: Double) -> Double {
        firstNumber / secondNumber
    }
    
    private func multiply(_ firstNumber: Double, from secondNumber: Double) -> Double {
        firstNumber * secondNumber
    }
        
}
