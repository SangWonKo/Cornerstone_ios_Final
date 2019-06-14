//
//  ViewController.swift
//  SegueStoryboard
//
//  Created by 고상원 on 2019-04-25.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "GoSecond":
                if let vc = segue.destination as? SecondViewController {
                    // This preparation is happening before outlets get set!
                    vc.phoneNumber = phoneTextField.text
                }
            default: break
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //when u want to perform segue conditionally
        return true
    }

    @IBAction func goToSecondVC(_ sender: UIButton) {
      
    }
    
}

