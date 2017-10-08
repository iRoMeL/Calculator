//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import Foundation

struct CalculatorBrain:CalculatorInterface {
	
	
	mutating func digit(_ value: Double) {
		//resultClosure = ((value),nil)
	}
	
	func operation(_ operation: Operation) {
		
	}
	
	func function(_ function: Function) {
		
	}
	
	func memory(_ memory: Memory) {
		
	}
	
	func utility(_ utility: Utility) {
		
	}
	
	var resultClosure: ((Double?, Error?) -> Void)
	
	
	
	
}
