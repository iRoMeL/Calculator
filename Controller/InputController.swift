//
//  InputController.swift
//  Calculator
//
//  Created by Roman Melnychok on 04.10.17.
//  Copyright © 2017 Roman Melnychok. All rights reserved.
//

import UIKit
import AVFoundation

class InputController: UIViewController,InputInterface {
	
	var mainController: CalculatorVC!
	
	@IBOutlet weak var point: UIButton!
	
	@IBAction func digitPressed(_ sender: UIButton) {
		
		playClick()
		
		symbolPressed(sender.currentTitle!)
		
	}
	
	@IBAction func operationPressed(_ sender: UIButton) {
		
		playClick()
		
		utilityPressed(sender.currentTitle!)
	}
	
	
	
	
	private func playClick() {
		AudioServicesPlaySystemSound(1104)
	}
	
	func symbolPressed(_ symbol: String) {
		mainController.symbolPressed(symbol)
	}
	
	func utilityPressed(_ symbol: String) {
		mainController.utilityPressed(symbol)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	
}
