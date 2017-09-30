//
//  Brain.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import Foundation

struct Brain {
	
	private var accumulator:Double?
	private enum Operation {
		case constant(Double) 		//pi,e,
		case unaryOparation((Double)->Double) 		//√
		case binaryOperation((Double,Double)-> Double)
		case equals
	}
	
	
	
	private var operations:Dictionary<String,Operation> = [
	"π"		: Operation.constant(Double.pi), //Double.pi,
	"e"		: Operation.constant(M_E),
	"√"		: Operation.unaryOparation(sqrt),
	"cos"	: Operation.unaryOparation(cos),
	"sin"	: Operation.unaryOparation(sin),
	"±"		: Operation.unaryOparation({-$0}),
	"+"		: Operation.binaryOperation({$0 + $1}),
	"−"		: Operation.binaryOperation({$0	- $1}),
	"÷"		: Operation.binaryOperation({$0	/ $1}),
	"×"		: Operation.binaryOperation({$0	* $1}),
	"="		: Operation.equals
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
	
	
}
