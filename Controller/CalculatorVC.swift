//
//  ViewController.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
	
	var input:InputInterface!
	var output:OutputInterface!
	private var brain:CalculatorBrain!
	private var userEnteringNumber = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		brain = CalculatorBrain( resultClosure: { (result, error) in
			
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
			destVC.delegate = self
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
	

}



