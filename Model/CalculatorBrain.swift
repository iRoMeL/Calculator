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
}

protocol Model {
	func input(number: Double)
	func input(operation: Operation)
}




class Brain: Model {
	
	let output: Output
	
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
				
			default: break
			}
			
			if let result = result {
				output.output(value: "\(result)")
			}
		} else {
			self.operation = operation
		}
	}
	
	func input(number: Double) {
		if operandOne == nil {
			operandOne = number
		} else if operandTwo == nil {
			operandTwo = number
		}
	}
}

