//
//  ViewController.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {

	private var typingDigit = false
	private var brain =  Brain()
	
	@IBOutlet weak var display: UILabelX!
	
	@IBAction func buttonPressed(_ sender: UIButtonX) {
	//button has been pressed
	let digit = sender.currentTitle!
		
	   if typingDigit {
			let textInDisplay = display.text!
			display.text = textInDisplay + digit
		} else {
			display.text = digit
			typingDigit = true
		}
		
	print("\(digit)")
		
		
	}
	
	 var displayValue:Double {
		get{
			//print(String(display.text!))
			return Double(display.text!)!
		}
		set{
			display.text = String(newValue)
		}
	}
	
	@IBAction func operationPressed(_ sender: UIButtonX) {
		
		if typingDigit {
			brain.setOperand(displayValue)
			typingDigit = false
		}
		
		if let mathSymbol = sender.currentTitle {
			brain.performOperation(mathSymbol)
		}
		
		if let result = brain.result{
			displayValue = result
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}


}



