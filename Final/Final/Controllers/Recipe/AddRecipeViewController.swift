//
//  AddRecipeViewController.swift
//  Final
//
//  Created by 고상원 on 2019-06-13.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit
import CoreData

protocol AddRecipeControllerDelegate: class {
    func addRecipeDidFinish(recipe: Recipe)
    func editRecipeDidFinish(recipe: Recipe)
}

class AddRecipeViewController: UIViewController {
    
    weak var delegate: AddRecipeControllerDelegate?
    
    var recipe: Recipe? {
        didSet {
            titleTextField.text = recipe?.title
            descriptionTextField.text = recipe?.text
            if let imageData = recipe?.image {
                recipeImageView.image = UIImage(data: imageData)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupUI()

        
    }
    
    lazy var recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
        iv.backgroundColor = .lightGray
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
        tf.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return tf
    }()
    
    fileprivate func setupUI() {
        view.addSubview(recipeImageView)
        recipeImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        recipeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recipeImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let vStackView = UIStackView(arrangedSubviews: [titleTextField,descriptionTextField])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 8
        vStackView.distribution = .equalSpacing
        view.addSubview(vStackView)
        
        vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        vStackView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 16).isActive = true
        //vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //vStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = recipe == nil ? "Add Recipe" : "Edit Recipe"
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelBtn.tintColor = .black
        navigationItem.leftBarButtonItem = cancelBtn
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        saveBtn.tintColor = .black
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func savePressed() {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        if recipe == nil {
            // add (create)
            let newRecipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: managedContext)
            newRecipe.setValue(titleTextField.text ?? "", forKey: "title")
            newRecipe.setValue(descriptionTextField.text, forKey: "text")
            if let newRecipeImage = recipeImageView.image {
                let imageData = newRecipeImage.jpegData(compressionQuality: 0.7)
                newRecipe.setValue(imageData, forKey: "image")
            }
            CoreDataManager.shared.saveContext()
            
            self.delegate?.addRecipeDidFinish(recipe: newRecipe as! Recipe)
            navigationController?.popViewController(animated: true)
            
        } else {
            // edit (update)
            recipe?.title = titleTextField.text
            recipe?.text = descriptionTextField.text
            if let recipeImage = recipeImageView.image {
                let imageData = recipeImage.jpegData(compressionQuality: 0.7)
                recipe?.image = imageData
            }
            CoreDataManager.shared.saveContext()
            
            self.delegate?.editRecipeDidFinish(recipe: self.recipe!)
            navigationController?.popViewController(animated: true)
            
        }
    }
    
}

extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            recipeImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            recipeImageView.image = originalImage
        }
        
        
        dismiss(animated: true, completion: nil)
    }
}
