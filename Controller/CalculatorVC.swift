//
//  ViewController.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
	
	
	var input:InputController!
	var output:OutputController!
	private var brain:CalculatorBrain!
	private var userEnteringNumber = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		brain = CalculatorBrain(equation: "", resultClosure: { (result, error) in
			
			if result != nil {
				self.output.display(result!.clean)
			}
			
			
		})
		
		output.display("0")
		
	}
	
	
	//MARK Seque
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let destVC = segue.destination as? OutputController {
			output = destVC
		}
		
		if  let destVC = segue.destination as? InputController {
			input = destVC
			destVC.mainController = self
		}
		
	}
	
	
	func symbolPressed(_ digit: String) {
		//button has been pressed
		
		if userEnteringNumber {
			
			//забираєм нулі
			if (digit == "0") && (output.displayValue == "0") { return }
			if (digit != ".") && (output.displayValue == "0") { output.displayValue = digit ; return }
			if (digit == ".") && (output.displayValue.characters.contains(".")) { return }
			
			let textInDisplay = output.displayValue
			output.displayValue = textInDisplay + digit
		} else {
			output.displayValue = digit
			userEnteringNumber = true
		}
		
		print("\(digit)")
		
		
	}
	
	func utilityPressed(_ operation:String) {
		
		if userEnteringNumber {
			brain.digit(Double(output.displayValue)!)
			userEnteringNumber = false
		}
		
		switch operation {
		case "+":
			brain.operation(.plus)
		case "−":
			brain.operation(.minus)
		case "÷":
			brain.operation(.div)
		case "×":
			brain.operation(.mult)
		case "=":
			brain.equal()
		case "AC":
			brain.clear()
		default:
			break
		}
		
		
	}
	
	
	//	private var userEnteringNumber = false
	//	private var brain =  Brain()
	//
	//	@IBOutlet weak var display: UILabelX!
	//
	//	@IBAction func buttonPressed(_ sender: UIButtonX) {
	//	//button has been pressed
	//
	//	let digit = sender.currentTitle!
	//
	//	   if userEnteringNumber {
	//
	//		//забираєм нулі
	//		if (digit == "0") && (display.text == "0") { return }
	//		if (digit != ".") && (display.text == "0") { display.text = digit ; return }
	//		if (digit == ".") && (display.text?.characters.contains("."))! { return }
	//
	//			let textInDisplay = display.text!
	//			display.text = textInDisplay + digit
	//		} else {
	//			display.text = digit
	//			userEnteringNumber = true
	//		}
	//
	//	print("\(digit)")
	//
	//
	//	}
	//
	//	 var displayValue:Double {
	//		get{
	//			//print(String(display.text!))
	//			return Double(display.text!)!
	//		}
	//		set{
	//			//display.text = NumberFormatter.localizedString(from: NSNumber(value:newValue), number: .decimal)
	//			display.text = newValue.description
	//			//display.text = String(format: "%.0f", newValue)
	//		}
	//	}
	//
	//	@IBAction func operationPressed(_ sender: UIButtonX) {
	//
	//		if userEnteringNumber {
	//			brain.setOperand(displayValue)
	//			userEnteringNumber = false
	//		}
	//
	//		if let mathSymbol = sender.currentTitle {
	//			brain.performOperation(mathSymbol)
	//		}
	//
	//		if let result = brain.result{
	//			displayValue = result
	//		}
	//
	//
	//	}
	//
	
	
	
	
	
	
	
	
	
	
}



