//
//  ViewController.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {

	private var userEnteringNumber = false
	private var brain =  Brain()
	
	@IBOutlet weak var display: UILabelX!
	
	@IBAction func buttonPressed(_ sender: UIButtonX) {
	//button has been pressed
	let digit = sender.currentTitle!
		
	   if userEnteringNumber {
			let textInDisplay = display.text!
			display.text = textInDisplay + digit
		} else {
			display.text = digit
			userEnteringNumber = true
		}
		
	print("\(digit)")
		
		
	}
	
	 var displayValue:Double {
		get{
			//print(String(display.text!))
			return Double(display.text!)!
		}
		set{
			//display.text = NumberFormatter.localizedString(from: NSNumber(value:newValue), number: .decimal)
			display.text = String(newValue)
			//display.text = String(format: "%.0f", newValue)
		}
	}
	
	@IBAction func operationPressed(_ sender: UIButtonX) {
		
		if userEnteringNumber {
			brain.setOperand(displayValue)
			userEnteringNumber = false
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



