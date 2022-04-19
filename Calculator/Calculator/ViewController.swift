//
//  ViewController.swift
//  Calculator
//
//  Created by Екатерина Неделько on 15.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    let calculatorEngine = CalculatorEngine.shared
    
    var operationButtonIsPressed = false
    var resultIsCalculated = false
    
    var firstNumber: Double?
    var secondNumber: Double?
    var operatorString = ""
    
    var resultNumber: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func numberButtonPress(_ sender: UIButton) {
        guard var resultLabelText = resultLabel.text else {
            return
        }
        
        resultNumber = numberFromString(resultLabelText)
        
        if resultIsCalculated {
            resultNumber = 0
            resultIsCalculated = false
        }
        
        if !characterInputAvailable(resultNumber) {
            return
        }
        
        if resultLabelText == "Error" {
                resultNumber = 0
        }
        
        if operationButtonIsPressed {
            resultNumber = 0
            operationButtonIsPressed = false
        }
        
        if resultNumber == 0 && resultLabelText != "0," {
            resultNumber = numberFromString(sender.titleLabel?.text ?? "0")
            resultLabel.text = separatedNumber(resultNumber)
            return
        }
        
        resultLabelText += sender.titleLabel?.text ?? "0"
        resultNumber = numberFromString(resultLabelText)
        resultLabel.text = separatedNumber(resultNumber)
    }
    
    @IBAction func zeroButtonPress(_ sender: UIButton) {
        guard let resultLabelText = resultLabel.text else {
            return
        }
        
        resultNumber = numberFromString(resultLabelText)
        
        if !characterInputAvailable(resultNumber) {
            return
        }
        
        if operationButtonIsPressed {
            resultNumber = 0
            resultLabel.text = String(resultNumber)
            operationButtonIsPressed = false
            return
        }
        
        if resultLabelText == "0" {
            return
        }
         
        resultNumber = numberFromString(resultLabelText + (sender.currentTitle ?? "0"))
        resultLabel.text = separatedNumber(resultNumber)
    }
    
    @IBAction func cleanButtonPress(_ sender: UIButton) {
        if resultLabel.text != nil {
            resultLabel.text = "0"
        }
        
        firstNumber = 0
        secondNumber = 0
        operatorString = ""
        
        resultNumber = 0
        
        operationButtonIsPressed = false
    }
    
    @IBAction func signChangeButtonPress(_ sender: UIButton) {
        guard let resultLabelText = resultLabel.text else {
            return
        }
        
        operationButtonIsPressed = false
        
        resultNumber = -numberFromString(resultLabelText)
        resultLabel.text = separatedNumber(resultNumber)
    }
    
    @IBAction func percentButtonPress(_ sender: UIButton) {
        guard let resultLabelText = resultLabel.text else {
            return
        }
        
        resultNumber = numberFromString(resultLabelText) / 100
        
        resultLabel.text = separatedNumber(resultNumber)
        
        if operationButtonIsPressed {
            secondNumber = resultNumber
            operationButtonIsPressed = false
        } else {
            firstNumber = resultNumber
        }
    }
    
    @IBAction func dotButtonPress(_ sender: UIButton) {
        guard let resultLabelText = resultLabel.text else {
            return
        }
        
        resultNumber = numberFromString(resultLabelText)
        
        if !characterInputAvailable(resultNumber) {
            return
        }
        
        operationButtonIsPressed = false
        
        if resultLabelText.contains(",") {
            resultNumber = 0
            resultLabel.text = "0,"
            return
        }
        
        resultLabel.text = resultLabelText + ","
    }
    
    @IBAction func operationButtonPress(_ sender: UIButton) {
        guard let resultLabelText = resultLabel.text else {
            return
        }
    
        if operationButtonIsPressed {
            return
        }
        operationButtonIsPressed = true
    
        resultNumber = numberFromString(resultLabelText)
        firstNumber = resultNumber
        
        operatorString = sender.titleLabel?.text ?? ""
    }
    
    @IBAction func equalsButtonPress(_ sender: UIButton) {
        guard let resultLabelText = resultLabel.text else {
            return
        }
        
        resultNumber = numberFromString(resultLabelText)
        
        operationButtonIsPressed = false
        
        secondNumber = resultNumber
        
        guard let operatorValue = Operator(rawValue: operatorString), let firstNumberValue = firstNumber, let secondNumberValue = secondNumber else {
            return
        }
        
        if operatorValue == .divide && secondNumberValue == 0 {
            resultLabel.text = "Error"
            firstNumber = nil
        } else {
            
            resultNumber = calculatorEngine.equal(firstNumber: firstNumberValue, secondNumber: secondNumberValue, operatorValue: operatorValue)
            
            resultLabel.text = separatedNumber(resultNumber)
            firstNumber = resultNumber
        }
        
        secondNumber = nil
        operatorString = ""
        
        resultIsCalculated = true
    }
    
    private func characterInputAvailable(_ resultNumber: Double?) -> Bool {
        guard let resultNumber = resultNumber else {
            return false
        }
        
        let resultString = String(resultNumber)
        
        if operationButtonIsPressed {
            return true
        }

        var charactersCount = 9
        
        if resultString.contains(".") {
            charactersCount += 1
        }
        if resultString.contains("-") {
            charactersCount += 1
        }
        
        if resultString.count < charactersCount {
            return true
        }
        
        return false
    }
    
    private func separatedNumber(_ number: Any) -> String {
        guard let number = number as? NSNumber else {
            return "0" }
        
        let intPartCount = String(abs(Int(truncating: number))).count
  
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 9 - intPartCount

        return formatter.string(from: number)! == "-0" ? "0" : formatter.string(from: number)!
    }
    
    private func numberFromString(_ string: String) -> Double {
        let string = string.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: "")
        
        if let number = Double(string) {
            return number
        }
        
        return 0
    }
    
}

