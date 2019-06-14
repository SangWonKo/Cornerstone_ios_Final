//
//  ViewController.swift
//  UserDefaultExample
//
//  Created by 고상원 on 2019-05-13.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bluetoothSwitch = UISwitch?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "switch") != nil {
            
        }
    }

    @IBAction func saveSwitchState(_ sender: UISwitch) {
    }
    
}

