//
//  ViewController.swift
//  LifeCycle
//
//  Created by 고상원 on 2019-05-09.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        //
        super.viewDidLoad()
        // when the view controller loads all the view into the memory
        // (not yet visible)
        // This process creates the views  that the controller will manage
        // Gets called once when the views are loaded to the memory
        // 1. Initialization of views (set attributes of views)
        // 2. Network requests
        // 3. Database access
         print("ViewController - View Did Load")
    
    }
    
    //For the work that will be performed multiple times, your app can rely on these view event notifications (life cycle methods)
    //When the visibility of its views changes, a view controller woll automatically call its life cycle methods
    
    
    //This method gets called before the view is displayed (everytime)
    // 1. Updating user location
    // 2. Updating or refreshing some views (everytime)
    // 3. Starting network requests
    // 4. Adjust screen orientations (portrait, lanscapes)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController - View Will Appear")
    }
    // Gets called right after the view appears on the screen
    // 1. Start an animation
    // 2. long running code (fetching data, database access)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController - View Did Appear")
    }
    
    // These methods execute when the user navigates away from the screen
    // by tapping the back button or switching tabs, or presenting or dismissing
    // a model view controller
    
    // Gets called right before the disappear from the screen
    // 1. saving edits
    // 2. hiding the keyboards
    // 3. cancelling network requests
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController - View Will Disappear")
    }
    
    // Gets called right after the view disappears from the screen
    // (usually after the user navigated to a new view)
    // 1. stop services related to the view.
    // (playing audio, removing notification observers)
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController - View Did Disappear")
    }


}

