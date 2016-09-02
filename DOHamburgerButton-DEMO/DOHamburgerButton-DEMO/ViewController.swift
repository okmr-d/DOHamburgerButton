//
//  ViewController.swift
//  DOHamburgerButton-DEMO
//
//  Created by Daiki Okumura on 2015/07/20.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = CGRectMake(self.view.frame.width / 2 - 22, self.view.frame.height / 3 - 22, 44, 44)
        let button = DOHamburgerButton(frame: frame)
        button.color = UIColor.whiteColor()
        button.addTarget(self, action: #selector(ViewController.tapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapped(sender: DOHamburgerButton) {
        if sender.selected {
            sender.deselect()
        } else {
            sender.select()
        }
    }
}

