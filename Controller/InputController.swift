//
//  InputController.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit

class InputController: UIViewController,InputInterface {
	
	
	private var userEnteringNumber = false
	
	@IBOutlet weak var point: UIButton!
	
	@IBAction func digitPressed(_ sender: UIButton) {
		
		let digit = sender.currentTitle!
		
		symbolPressed(digit)
		
		
	}
	
	func symbolPressed(_ symbol: String) {
		print(symbol)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//point.setTitle(Formatter.separator, for: .normal)
		
		//self.model = Brain()
		// Do any additional setup after loading the view.
	}
	
	
}
