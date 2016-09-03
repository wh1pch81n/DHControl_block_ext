//
//  ViewController.swift
//  DHButton
//
//  Created by Derrick  Ho on 9/2/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Boiler-plate code
		let b = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height:  100))
		b.setTitle("button", for: UIControlState.normal)
		b.backgroundColor = .blue
		self.view.addSubview(b)
		
		// usage

		b.callback { [unowned self] in
			let vc = self.storyboard!.instantiateViewController(withIdentifier: "ViewController2ViewController")
			self.show(vc, sender: $0)
		}
		
		let s = UISlider(frame: CGRect(x: 0, y: 130, width: 100, height:  100))
		self.view.addSubview(s)
		s.callback(when: [.valueChanged]) {
			print($0.value)
		}
		
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

