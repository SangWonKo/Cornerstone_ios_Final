//
//  FullRecipeViewController.swift
//  Final
//
//  Created by 고상원 on 2019-06-13.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class FullRecipeViewController: UIViewController {
    
    var recipe: Recipe!
    
    private final let horizontalSpacing: CGFloat = 12
    private final let cornerRadius: CGFloat = 16
    private final let itemHeight: CGFloat = 400

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        if let imageData = recipe?.image {
            recipeImageView.image = UIImage(data: imageData)
        }
        if let titleData = recipe?.title {
            titleTextField.text = titleData
        }
        //titleTextField.text = recipe.title
        if let textData = recipe?.text {
            descriptionTextField.text = textData
        }
        //descriptionTextField.text = recipe.text
        

        // Do any additional setup after loading the view.
    }
    
    @objc func done() {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Recipe Name"
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let descriptionTextField: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .black
        tf.heightAnchor.constraint(equalToConstant: 500)
        return tf
    }()
    
    fileprivate func setupUI() {
        view.addSubview(recipeImageView)
        recipeImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        recipeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recipeImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let vStackView = UIStackView(arrangedSubviews: [titleTextField,descriptionTextField])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 0
        vStackView.distribution = .equalSpacing
        view.addSubview(vStackView)
        
        vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        vStackView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 16).isActive = true
        //vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //vStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
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

