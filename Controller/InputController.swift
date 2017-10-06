//
//  InputController.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class InputController: UIViewController,Input {
	
	var model:Brain!
	
	
	@IBOutlet weak var point: UIButton!
	

	func enter(value: String) {
		
		switch value {
		case "1": model.input(number: Double(value)!)
		case "2": model.input(number: Double(value)!)
		case "3": model.input(number: Double(value)!)
		case "4": model.input(number: Double(value)!)
		case "5": model.input(number: Double(value)!)
		case "6": model.input(number: Double(value)!)
		case "7": model.input(number: Double(value)!)
		case "8": model.input(number: Double(value)!)
		case "9": model.input(number: Double(value)!)
		case "0": model.input(number: Double(value)!)
			
		case "+": model.input(operation: .pls)
		case "-": model.input(operation: .min)
		case "÷": model.input(operation: .div)
		case "×": model.input(operation: .mul)
		case "=": model.input(operation: .equal)
		default: break
		}
	}
	

	private var userEnteringNumber = false
	
	@IBAction func digitPressed(_ sender: UIButton) {
		
		let digit = sender.currentTitle!
		
		enter(value: digit)
		
	
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()

		point.setTitle(Formatter.separator, for: .normal)
		
		//self.model = Brain()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
