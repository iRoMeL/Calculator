//
//  InputController.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class InputController: UIViewController {
	
	//let model: Model!
	


	
	
	private var userEnteringNumber = false
	
	@IBAction func digitPressed(_ sender: UIButton) {
		
		//let digit = sender.currentTitle!
		
//		if userEnteringNumber {
//
//			//забираєм нулі
//			if (digit == "0") && (display.text == "0") { return }
//			if (digit != ".") && (display.text == "0") { display.text = digit ; return }
//			if (digit == ".") && (display.text?.characters.contains("."))! { return }
//
//			let textInDisplay = display.text!
//			display.text = textInDisplay + digit
//		} else {
//			display.text = digit
//			userEnteringNumber = true
//		}
//
//		print("\(digit)")
		
		
		
	}
	
//	func enter(value: String) {
//
//		switch value {
//		case "1": model.input(number: Double(value)!)
//		case "+": model.input(operation: .pls)
//		case "-": model.input(operation: .min)
//		case "=": model.input(operation: .equal)
//		default: break
//		}
//	}
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

	
		
		//self.model = Brain()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	
	//var model: Model
	
	//init(with model: Model) {
	//	self.model = model
	//}
	
//	func enter(value: String) {
//		switch value {
//		case "1": model.input(number: Double(value)!)
//		case "+": model.input(operation: .pls)
//		case "-": model.input(operation: .min)
//		case "=": model.input(operation: .equal)
//		default: break
//		}
//	}

}
