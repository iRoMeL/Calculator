//
//  ViewController.swift
//  Calculator
//
//  Created by Roman Melnychok on 30.09.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {

	
	@IBOutlet weak var display: UILabelX!
	
	@IBAction func buttonPressed(_ sender: UIButtonX) {
	//button has been pressed
	print("\(sender.currentTitle!)")
		display.text = String(sender.currentTitle!)
	}
	
	@IBAction func operationPressed(_ sender: UIButtonX) {
		
		
	}
	
	
	
	
	
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}


}

