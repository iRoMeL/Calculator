//
//  OutputController.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class OutputController: UIViewController {
	
	

	@IBOutlet weak var display: UILabel!
	
	var displayValue:String {
		
		get{
			return display.text!
			}
		set{
			display.text = newValue.description
			}
		
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	func output(value: String) {
		print("\(value)")
		
		display.text = value
	}

}
