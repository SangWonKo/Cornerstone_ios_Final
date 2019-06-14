//
//  MainTabBarController.swift
//  Final
//
//  Created by 고상원 on 2019-06-11.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewControllers = [
            createViewController(viewController: UIViewController(), title: "Home", imageName: "home"),
            createViewController(viewController: RefrigeratorTableViewController(), title: "Refrigerator", imageName: "refrigerator"),
            createViewController(viewController: RecipeCollectionViewController(), title: "Recipe", imageName: "recipe"),
            createViewController(viewController: UIViewController(), title: "Setting", imageName: "setting")
        ]
    }
    
    fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: imageName)
        return navigationController
    }
}
