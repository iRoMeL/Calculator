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
	
	var delegate: CalculatorDelegate!
	
	@IBOutlet weak var point: UIButton!
	
	@IBAction func buttonPressed(_ sender: UIButton) {
		
		//animation
		sender.titleLabel?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
		UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
			[sender] in sender.titleLabel?.transform = CGAffineTransform.identity
		}, completion: nil)
		
		playClick()
		symbolPressed(sender.currentTitle!)
		
	}
	
	private func playClick() {
		AudioServicesPlaySystemSound(1104)
	}
	
	func symbolPressed(_ symbol: String) {
		delegate.input(symbol)
	}
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	
}
