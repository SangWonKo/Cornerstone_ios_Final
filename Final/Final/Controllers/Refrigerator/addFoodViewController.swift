//
//  addFoodViewController.swift
//  Final
//
//  Created by 고상원 on 2019-06-11.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit
import CoreData

protocol AddFoodControllerDelegate: class {
    func addMeatDidFinish(refrigerator: Refrigerator)
    func addVegetableDidFinish(refrigerator: Refrigerator)
    func addFruitDidFinish(refrigerator: Refrigerator)
    func addDairyDidFinish(refrigerator: Refrigerator)
    func editFoodDidFinish(refrigerator: Refrigerator)
}

class addFoodViewController: UIViewController {
    
    weak var delegate: AddFoodControllerDelegate?
    
    var refrigerator: Refrigerator? {
        didSet {
            nameTextField.text = refrigerator?.name
            
            guard let expireDate = refrigerator?.expireDate else { return }
            datePicker.date = expireDate
            
        }
    }
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Food"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        //lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return lb
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " Enter Food..."
        //tf.textColor = .black
        //tf.layer.cornerRadius = 16
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["Meat","Vegetable","Fruit","Dairy"])
        seg.translatesAutoresizingMaskIntoConstraints = false
        
        seg.selectedSegmentIndex = 0
        //seg.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        seg.tintColor = .black
        seg.backgroundColor = .white
        return seg
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        //dp.backgroundColor = .white
        dp.datePickerMode = .date
        //        dp.layer.cornerRadius = 16
        //        dp.clipsToBounds = true
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Add Food"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        setupUI()
        
        
    }
    
    @objc func savePressed() {
        
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        if refrigerator == nil {
            // add (create)
            let newRefrigerator = NSEntityDescription.insertNewObject(forEntityName: "Refrigerator", into: managedContext)
            newRefrigerator.setValue(nameTextField.text ?? "", forKey: "name")
            newRefrigerator.setValue(datePicker.date, forKey: "expireDate")
            //            let currentDate = Date()
            //            let interval = (datePicker.date).timeIntervalSince(currentDate)
            //            let day = Int(interval/86400)
            //            newRefrigerator.setValue(day, forKey: "dueDate")
            CoreDataManager.shared.saveContext()
            if self.segmentedControl.selectedSegmentIndex == 0 {
                self.delegate?.addMeatDidFinish(refrigerator: newRefrigerator as! Refrigerator)
                 navigationController?.popViewController(animated: true)
            }
            else if self.segmentedControl.selectedSegmentIndex == 1 {
                self.delegate?.addVegetableDidFinish(refrigerator: newRefrigerator as! Refrigerator)
                 navigationController?.popViewController(animated: true)
            }
            else if self.segmentedControl.selectedSegmentIndex == 2 {
                self.delegate?.addFruitDidFinish(refrigerator: newRefrigerator as! Refrigerator)
                 navigationController?.popViewController(animated: true)
            }
            else if self.segmentedControl.selectedSegmentIndex == 3 {
                self.delegate?.addDairyDidFinish(refrigerator: newRefrigerator as! Refrigerator)
                 navigationController?.popViewController(animated: true)
            }
            
            
        } else {
            // edit (update)
            refrigerator?.name = nameTextField.text
            refrigerator?.expireDate = datePicker.date
            CoreDataManager.shared.saveContext()
            
            self.delegate?.editFoodDidFinish(refrigerator: self.refrigerator!)
            navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    private func setupUI() {
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStackView)
        
        hStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        hStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        hStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let vStackView = UIStackView(arrangedSubviews: [segmentedControl,datePicker])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 30
        view.addSubview(vStackView)
        
        vStackView.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 32).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        
    }
    
    
    
}
