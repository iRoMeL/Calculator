//
//  Protocols.swift
//  Calculator
//
//  Created by Roman Melnychok on 03.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import Foundation






class InputController2: Input {
	
	let model: Model
	
	init(with model: Model) {
		self.model = model
	}
	
	func enter(value: String) {
		switch value {
		case "1": model.input(number: Double(value)!)
		case "+": model.input(operation: .pls)
		case "-": model.input(operation: .min)
		case "=": model.input(operation: .equal)
		default: break
		}
	}
}




