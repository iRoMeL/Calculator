//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import Foundation


class CalculatorBrain:CalculatorInterface {

	
	
	private var equation: String 		= "0" //вираз для розрахунку
	private var braketMode:Bool			=  false
    private var memory:Double?
	
	
	private var inputStack = [""] {
		
		didSet {
			for (index, value) in inputStack.enumerated() {
				if index == 0 {
					equation = "" + value
				} else {
					equation += " " + value
				}
			}
			
			print(equation)
		}
	}
	
	
	
	private let opa = [
		"^"		: (prec: 4, rAssoc: true),
		"sin"	: (prec: 5, rAssoc: true),
		"cos"	: (prec: 5, rAssoc: true),
		"tan"	: (prec: 5, rAssoc: true),
		"sinh"	: (prec: 5, rAssoc: true),
		"cosh"	: (prec: 5, rAssoc: true),
		"tanh"	: (prec: 5, rAssoc: true),
		"x"		: (prec: 3, rAssoc: false),
		"/"		: (prec: 3, rAssoc: false),
		"1/x"	: (prec: 5, rAssoc: true),
		"x²"	: (prec: 5, rAssoc: true),
		"x!"	: (prec: 5, rAssoc: true),
		"x³"	: (prec: 5, rAssoc: true),
		"eˣ"		: (prec: 5, rAssoc: true),
		"xʸ"		: (prec: 4, rAssoc: true),
		"10ˣ"	: (prec: 5, rAssoc: true),
		"ʸ√x"	: (prec: 5, rAssoc: false),
		"³√x"	: (prec: 5, rAssoc: false),
		"ln"	: (prec: 5, rAssoc: true),
		"log₁₀"	: (prec: 5, rAssoc: true),
		"+"		: (prec: 2, rAssoc: false),
		"-"		: (prec: 2, rAssoc: false),
	
		]
	
	init(resultClosure:@escaping ((Double?, Error?) ->Void) ) {
		self.resultClosure = resultClosure
	}
	
	
	func digit(_ value: Double) {
		inputStack.append(String(value))
		if !braketMode {
			resultClosure(calculate(),nil)
		}
		
	}
	
	func operation(_ operation: Operation) {
		
		inputStack.append(String(operation.rawValue))
		
		if !braketMode {
		//	resultClosure(calculate(),nil)
		}

	}
	
    func equal()  {
		
		let result  = calculate()
		
		//потрібні перевірки
		
		braketMode = false

		inputStack.removeAll()
		inputStack.append(String(result))
		resultClosure(result,nil)
		
	}
	
   private func clear() {
		equation 		= ""
		inputStack.removeAll()
		resultClosure(0,nil)
		braketMode 		= false
	}
	
	
	func function(_ function: Function) {
		
		inputStack.append(String(function.rawValue))
		
		if !braketMode {
		resultClosure(calculate(),nil)
		}
		
	
		
	}
	
	func memory(_ mem: Memory, _ number: Double?) {
		
		switch mem {
		case .allClean,.clean:
			clear()
			
		case .memoryAdd:
			//
			if number != nil {
				memory = number
			}
			
		case .memoryRemove:
			if let m = memory {
				digit(m)
			}
		case .memoryClean:
			memory = nil
		}
		
	}
	
	func utility(_ utility: Utility) {
		
		inputStack.append(String(utility.rawValue))
		braketMode = true
		
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
	
	
	
	func calculate() -> Double {
		let tokens = rpn(tokens: parseInfix(e: equation )) // array for input symbols
		var stack = [String]()
		
		print("rpn - \(tokens) ")
		
		for token in tokens {
			
			if Double(token) != nil  {
				stack += [token] // if symbol is number  - add to stack
				
			} else if !stack.isEmpty &&
				(token == Function.sin.rawValue
					|| token == Function.cos.rawValue
					|| token == Function.ln.rawValue
					|| token == Function.sqrt.rawValue
					|| token == Function.root3_x.rawValue
					|| token == Function.tan.rawValue
					|| token == Function.sinh.rawValue
					|| token == Function.cosh.rawValue
					|| token == Function.tanh.rawValue
					|| token == Function.x_1.rawValue
					|| token == Function.x2.rawValue
					|| token == Function.x3.rawValue
					|| token == Function.log.rawValue
					|| token == Function.fact.rawValue
					|| token == Function.x10.rawValue
					|| token == Function.ex.rawValue
					|| token == Function.fact.rawValue
					
					
				) {
				if let  operand = Double((stack.removeLast())) {
					switch token {
					case Function.sin.rawValue:
						stack += [String(sin(operand))]
					case Function.cos.rawValue:
						stack += [String(cos(operand))]
					case Function.ln.rawValue:
						stack += [String(log(operand))]
					case Function.log.rawValue:
						stack += [String(log10(operand))]
					case Function.sqrt.rawValue:
						stack += [String(sqrt(operand))]
					case Function.tan.rawValue:
						stack += [String(tan(operand))]
					case Function.sinh.rawValue:
						stack += [String(sinh(operand))]
					case Function.cosh.rawValue:
						stack += [String(cosh(operand))]
					case Function.tanh.rawValue:
						stack += [String(tanh(operand))]
					case Function.x_1.rawValue:
						if operand != 0 {
							stack += [String( pow(operand, -1))]
						}
					case Function.x2.rawValue:
						stack += [String( pow(operand, 2))]
					case Function.x3.rawValue:
						stack += [String( pow(operand, 3))]
					case Function.root3_x.rawValue:
						stack += [String( pow(operand, 1/3))]
					case Function.x10.rawValue:
						stack += [String( pow(10, operand))]
					case Function.ex.rawValue:
						stack += [String( pow(M_E, operand))]
					case Function.fact.rawValue:
						
						let int_number = Int(operand)
						stack += [String( factorial(int_number))]
						
						
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
							if secondOperand != 0.0 {
								stack += [String(firstOperand / secondOperand)]
							} else {
								stack += [String(0.0)]
							}
							
						case Operation.mult.rawValue:
							stack += [String(firstOperand * secondOperand)]
						case Operation.exp.rawValue:
							stack += [String(pow(firstOperand,secondOperand))]
						case Function.xy.rawValue:
							stack += [String(pow(firstOperand,secondOperand))]
						case Function.y_root_x.rawValue:
							if secondOperand != 0.0 {
								stack += [String(pow(firstOperand,1/secondOperand))]
							} else {
								stack += [String(0.0)]
							}
							
						default:
							break
						}
					}
					
				}
				
				
			}
		}
		if !stack.isEmpty {
			return Double(stack.removeLast())!
		} else {
			return 0
		}
		
	}
	
	private func factorial(_ n: Int) -> Int {
		if n == 0 {
			return 1
		}
		else {
			return n * factorial(n - 1)
		}
	}
	
}
