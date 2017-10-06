//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import Foundation


enum Operation {
	case pls
	case min
	case mul
	case div
	case equal
}


protocol Input {
	func enter(value: String)
}

protocol Output {
	func output(value: String)
	var displayValue:String {get set}
	
}

protocol Model {
	func input(number: Double)
	func input(operation: Operation)
}




class Brain: Model {
	
	var output: Output
	
	private var userEnteringNumber = false
	
	var operandOne: Double?
	var operandTwo: Double?
	var operation: Operation?
	
	init(with output: Output) {
		self.output = output
	}
	
	func input(operation: Operation) {
		if operation == .equal {
			
			var result: Double? = nil
			
			switch self.operation! {
				case .pls: result = (operandOne ?? 0.0) + (operandTwo ?? 0.0)
				case .min: result = (operandOne ?? 0.0) - (operandTwo ?? 0.0)
				case .div: result = (operandOne ?? 0.0) / (operandTwo ?? 0.0)
				case .mul: result = (operandOne ?? 0.0) * (operandTwo ?? 0.0)
				
			default: break
			}
			
			if let result = result {
				//output.output(value: "\(result)")
				output.displayValue = String(result)
				operandOne = result
				operandTwo = nil
			}
		} else {
			self.operation = operation
		}
		userEnteringNumber = false
	}
	
	func input(number: Double) {
		
		//if (number == "0") && (display.text == "0") { return }
		//		if (digit != ".") && (display.text == "0") { display.text = digit ; return }
		//		if (digit == ".") && (display.text?.characters.contains("."))! { return }
		//
		if userEnteringNumber {
		let textInDisplay = output.displayValue
		
				output.displayValue = (String(textInDisplay) + String(number))
				} else {
					output.displayValue = String(number)
					userEnteringNumber = true
				}
	
		if operandOne == nil {
			operandOne = number
		} else if operandTwo == nil {
			operandTwo = number
		}
	}
}

struct Formatter {
	private static let format: NumberFormatter = {
		let format = NumberFormatter()
		format.numberStyle = .decimal
		format.notANumberSymbol = "Err"
		return format
	}()
	
	static var separator: String? {
		return format.decimalSeparator
	}
	
	static func toDouble(value: String?) -> Double? {
		return value == nil ? nil : format.number(from: value!)?.doubleValue
	}
	
	//static func toString(value: Double?) -> String? {
	//	return value == nil ? nil : format.string(from: NSNumber(value!))
	//}
}

