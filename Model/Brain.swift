//
//  Brain.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import Foundation

func factorial(_ n: Double) -> Double {
	if n == 0 {
		return 1
	}
	else {
		return n * factorial(n - 1)
	}
}

struct Brain {
	
	private var accumulator:Double?
	
	private enum Operation {
		case constant(Double) 		//pi,e,
		case unaryOparation((Double)->Double) 		//√
		case binaryOperation((Double,Double)-> Double)
		case equals
		case clear
	}
	
	
	
	private var operations:Dictionary<String,Operation> = [
	"π"		: .constant(Double.pi), //Double.pi,
	"e"		: .constant(M_E),
	"√"		: .unaryOparation(sqrt),
	"cos"	: .unaryOparation(cos),
	"sin"	: .unaryOparation(sin),
	"sinh"	: .unaryOparation(sinh),
	"cosh"	: .unaryOparation(cosh),
	"tan"	: .unaryOparation(tan),
	"tanh"	: .unaryOparation(tanh),
	"x!"	: .unaryOparation(factorial),
	"x²" 	: .unaryOparation({ pow($0, 2) }),
	"x³" 	: .unaryOparation({ pow($0, 3) }),
	"eˣ"		: .unaryOparation(exp),
	"xʸ"		: .binaryOperation(pow),
	"±"		: .unaryOparation({-$0}),
	"+"		: .binaryOperation({$0 + $1}),
	"−"		: .binaryOperation({$0	- $1}),
	"÷"		: .binaryOperation({$0	/ $1}),
	"×"		: .binaryOperation({$0	* $1}),
	"="		: .equals,
	"AC"	: .clear
	]
	
	mutating func performOperation(_ symbol :String) {
		
		if let operation = operations[symbol] {
			
			switch operation {
			case .constant(let value):
					accumulator = value
			case .unaryOparation(let unaryOperator):
				if  accumulator != nil{
					accumulator = unaryOperator(accumulator!)
				}
			case .binaryOperation(let function):
				if accumulator != nil{
					pbo = PendingBinaryOPeration(function: function, firstOperand: accumulator!)
					accumulator = nil
				}
			case .equals:
				performPendingBinaryOperation()
			case .clear:
				clear()
			}
			
		}
		
		
	
	}
	
	private mutating func performPendingBinaryOperation() {
		if pbo != nil && accumulator != nil {
			accumulator = pbo?.perform(with: accumulator!)
			pbo = nil
		}
		
		
	}
	
	private var pbo:PendingBinaryOPeration?
	
	private struct PendingBinaryOPeration {
		let function: (Double,Double) -> Double
		let firstOperand: Double
		
		func perform(with secondOperand : Double) -> Double {
			return function(firstOperand,secondOperand)
		}
		
	}
	
	mutating func setOperand(_ operand: Double)  {
		accumulator = operand
	}
	
	var result : Double? {
		
		get{
			return accumulator
		}
	}
	
	mutating func clear() {
		accumulator = 0
		pbo = nil
		
	}
	
	
}
