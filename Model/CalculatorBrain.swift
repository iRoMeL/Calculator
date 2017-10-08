//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import Foundation

struct CalculatorBrain:CalculatorInterface {
	
	var equation: String //вираз для розрахунку
	
	private let opa = [
		"^": (prec: 4, rAssoc: true),
		"sin": (prec: 5, rAssoc: true),
		"x": (prec: 3, rAssoc: false),
		"/": (prec: 3, rAssoc: false),
		"+": (prec: 2, rAssoc: false),
		"-": (prec: 2, rAssoc: false),
		]
	
	
	
	mutating func digit(_ value: Double) {
		
		equation  += " " + String(value)
		let a = calculate(equation: equation)
		resultClosure(a,nil)
		print(a.clean)
	}
	
	mutating func operation(_ operation: Operation) {
	
		equation  += " " + String(operation.rawValue)
		let a = calculate(equation: equation)
		resultClosure(a,nil)
		print(a.clean)
		
	}
	
	mutating func equal()  {
		let a = calculate(equation: equation)
		resultClosure(a,nil)
		equation = String(a)
		print(a.clean)
	}
	
	mutating func clear() {
		equation = "0"
		resultClosure(0,nil)
	}
	
	
	func function(_ function: Function) {
		
	}
	
	func memory(_ memory: Memory) {
		
	}
	
	func utility(_ utility: Utility) {
		
	}
	
	var resultClosure: ((Double?, Error?) ->Void)
	
	
	func rpn(tokens: [String]) -> [String] {
		var rpn		: [String] = [] // equation in rpn
		var stack 	: [String] = [] // holds operators and left parenthesis
		
		for tok in tokens {
			switch tok {
			case "(":
				stack += [tok] // push "(" to stack
			case ")":
				while !stack.isEmpty {
					let op = stack.removeLast() // pop item from stack
					if op == "(" {
						break // discard "("
					} else {
						rpn += [op] // add operator to result
					}
				}
			default:
				if let o1 = opa[tok] { // token is an operator?
					for op in stack.reversed() {
						if let o2 = opa[op] {
							if !(o1.prec > o2.prec || (o1.prec == o2.prec && o1.rAssoc)) {
								// top item is an operator that needs to come off
								rpn += [stack.removeLast()] // pop and add it to the result
								continue
							}
						}
						break
					}
					
					stack += [tok] // push operator (the new one) to stack
				} else { // token is not an operator
					rpn += [tok] // add operand to result
				}
			}
		}
		
		return rpn + stack.reversed()
	}
	
	func parseInfix(e: String) -> [String] {
		let tokens = e.characters.split{ $0 == " " }.map(String.init)
		return tokens
	}
	
	
	
	func calculate(  equation: String ) -> Double {
		let tokens = rpn(tokens: parseInfix(e: equation )) // array for input symbols
		var stack = [String]()
		
		for token in tokens {
			
			if Double(token) != nil  {
				stack += [token] // if symbol is number  - add to stack
				
			} else if !stack.isEmpty && (token == Function.sin.rawValue || token == Function.cos.rawValue || token == Function.ln.rawValue || token == Function.sqrt.rawValue) {
				if let operand = Double((stack.removeLast())) {
					switch token {
					case Function.sin.rawValue:
						stack += [String(sin(operand))]
					case Function.cos.rawValue:
						stack += [String(cos(operand))]
					case Function.ln.rawValue:
						stack += [String(log(operand))]
					case Function.sqrt.rawValue:
						stack += [String(sqrt(operand))]
					default:
						break
					}
				}
			} else {
				if stack.count > 1 {
					if let secondOperand = Double(stack.removeLast()), let firstOperand = Double(stack.removeLast()) {
						switch token {
						case Operation.plus.rawValue:
							stack += [String(firstOperand + secondOperand)]
						case Operation.minus.rawValue:
							stack += [String(firstOperand - secondOperand)]
						case Operation.div.rawValue:
							stack += [String(firstOperand / secondOperand)]
						case Operation.mult.rawValue:
							stack += [String(firstOperand * secondOperand)]
						case Operation.exp.rawValue:
							stack += [String(pow(firstOperand,secondOperand))]
						default:
							break
						}
					}
					
				}
				
				
			}
		}
		
		return Double(stack.removeLast())!
	}
	
	
	
}
