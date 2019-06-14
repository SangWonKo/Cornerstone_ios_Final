//
//  SecondViewController.swift
//  SegueStoryboard
//
//  Created by 고상원 on 2019-04-25.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var phoneLabel: UILabel! {
        didSet {
            phoneLabel.text = phoneNumber
        }
    }
    
    var phoneNumber: String!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
