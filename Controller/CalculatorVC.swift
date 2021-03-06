//
//  ViewController.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController,CalculatorDelegate {
	
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
			
			if error != nil {
				print(error!)
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
	
	
	func input(_ symbol: String) {
		
		//розпарсуємо яка кнопка була натиснута
		
		switch symbol {
		case "0","1","2","3","4","5","6","7","8","9",".","±","%":
			numberPressed(symbol)
		case "+","−","÷","×","^","=":
			operationPressed(symbol)
		case "π":
			constantPressed(Double.pi)
		case "e":
			constantPressed(M_E)
		case "Rand":
			constantPressed(Double.random0to1())
		case "sin","cos","tan","sinh","cosh","tanh","²√x","³√x","1/x","x²","x³","xʸ","eˣ","2ˣ","10ˣ","ln","ʸ√x","log₁₀","log₂","x!","Deg":
			functionPressed(symbol)
		case "(",")":
			utilityPressed(symbol)
		case "AC","C","m+","m-","mc","mr":
			memoryPressed(symbol)
		default:
			break
		}
		
	}
	
	func constantPressed(_ constant: Double) {
		output.displayValue = String(constant)
		userEnteringNumber = true
	}
	
	func numberPressed(_ digit: String) {
		//number has been pressed
		
		if userEnteringNumber {
			
			//забираєм нулі
			if (digit == "0") && (output.displayValue == "0") { return }
			if (digit == ".") && ((output.displayValue == "0") || (output.displayValue == "")) { output.displayValue = "0."; return }
			if (digit != ".") && (output.displayValue == "0") { output.displayValue = digit ; return }
			if (digit == ".") && (output.displayValue.characters.contains(".")) { return }
			if (digit == "±") && ((output.displayValue == ".") || (output.displayValue == "0") || (output.displayValue == "")){ return }
			if (digit == "%") && ((output.displayValue == ".") || (output.displayValue == "0") || (output.displayValue == "")){ return }
			
			print(output.displayValue)
			
			//міняємо знак
			if (digit == "±")  {
				if  let nn = Double(output.displayValue) {
					
					if  nn.sign == .minus {
						output.displayValue = abs(nn).clean
					} else {
						output.displayValue = "-" + nn.clean
					}
					
					
				}
				
				
			} else if (digit == "%") {
				if  let nn = Double(output.displayValue) {
					
					output.displayValue = String(nn * 0.01)
				}
				
			}
			
			else {

				let textInDisplay = output.displayValue
				output.displayValue = textInDisplay + digit
			}
			
		} else {
			if  (digit == "±")   {return}
			if  (digit == "%")   {return}
			if  (digit == ".") && ((output.displayValue == "0") || (output.displayValue == ""))
			{ output.displayValue = "0."
				userEnteringNumber = true
				return }
			
			output.displayValue = digit
			userEnteringNumber = true
		}
		
		print("Entering number: \(digit)")
		
		
	}
	
	func memoryPressed(_ symbol: String) {
		
		userEnteringNumber = false
		
		switch symbol {
		case "AC":
			brain.memory(.allClean,nil)
		case "C":
			brain.memory(.clean,nil)
		case "m+":
			brain.memory(.memoryAdd,Double(output.displayValue))
		case "m-":
			brain.memory(.memoryClean,nil)
		case "mc":
			brain.memory(.memoryClean,nil)
		case "mr":
			brain.memory(.memoryRemove,nil)
		default:
			break
		}
		
	}
	
	func operationPressed(_ operation:String) {
		
		if userEnteringNumber {
			if output.displayValue == "." {output.displayValue = "0"}
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
		default:
			break
		}
		
		
	}
	
	
	
	func functionPressed(_ operation:String) {
		
		if userEnteringNumber {
			if output.displayValue == "." {output.displayValue = "0"}
			brain.digit(Double(output.displayValue)!)
			userEnteringNumber = false
		}
		
		switch operation {
		case "sin":
			brain.function(.sin)
		case "cos":
			brain.function(.cos)
		case "tan":
			brain.function(.tan)
		case "sinh":
			brain.function(.sinh)
		case "cosh":
			brain.function(.cosh)
		case "tanh":
			brain.function(.tanh)
		case "²√x":
			brain.function(.sqrt)
		case "³√x":
			brain.function(.root3_x)
		case "1/x":
			brain.function(.x_1)
		case "x²":
			brain.function(.x2)
		case "x³":
			brain.function(.x3)
		case "log₁₀":
			brain.function(.log)
		case "log₂":
			brain.function(.log2)
		case "ln":
			brain.function(.ln)
		case "eˣ":
			brain.function(.ex)
		case "2ˣ":
			brain.function(.x2x)
		case "xʸ":
			brain.function(.xy)
		case "10ˣ":
			brain.function(.x10)
		case "ʸ√x":
			brain.function(.y_root_x)
		case "x!":
			brain.function(.fact)
		case "Deg":
			brain.function(.Deg)
		default:
			break
		}
		
		
	}
	
	func utilityPressed(_ operation:String) {
		
		if userEnteringNumber {
			if output.displayValue == "." {output.displayValue = "0"}
			brain.digit(Double(output.displayValue)!)
			userEnteringNumber = false
		}
		
		switch operation {
		case "(":
			brain.utility(.leftBracket)
		case ")":
			brain.utility(.rightBracket)
		default:
			break
		}
		
		
	}
	
	
}



