//
//  AddCompanyViewController.swift
//  JobTracker
//
//  Created by 고상원 on 2019-05-14.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit
import CoreData

//protol (passing cdata back to companyTableViewCOntroller)
protocol AddCompanyControllerDelegate: class {
    func addCompanyDidFinish(company: Company)
    //func addCompanyDidCancel()
    func editCompanyDidFinish(company: Company)
}

class AddCompanyViewController: UIViewController {
    
    var delegate: AddCompanyControllerDelegate?
    
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
            guard let applied = company?.applied else { return }
            datePicker.date = applied
            
        }
    }
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Company"
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return lb
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter company name..."
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.backgroundColor = .white
        dp.datePickerMode = .date
        dp.layer.cornerRadius = 16
        dp.layer.masksToBounds = true
        return dp
    }()
    
    private func setupUI() {
        let hstackView = UIStackView(arrangedSubviews: [nameLabel,nameTextField])
        hstackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hstackView)
        hstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        hstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        hstackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        hstackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: hstackView.bottomAnchor, constant: 16).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    private func setupNavigation() {
        navigationItem.title = company == nil ? "AddCompany" : "Edit Company"
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelBtn.tintColor = .white
        navigationItem.leftBarButtonItem = cancelBtn
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        saveBtn.tintColor = .white
        navigationItem.rightBarButtonItem = saveBtn
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        view.backgroundColor = .black
        

        
    }
    
    
    @objc func cancelPressed() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func savePressed() {
        //save or edit
        if company == nil {
            // add
            let managedContext = CoreDataManager.shared.persistentContainer.viewContext
            let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: managedContext)
            newCompany.setValue(nameTextField.text ?? "", forKey: "name")
            newCompany.setValue(datePicker.date, forKey: "applied")
            CoreDataManager.shared.saveContext()
            dismiss(animated: true) {
                //                let company = Company(context: managedContext)
                //                company.name = self.nameTextField.text ?? ""
                self.delegate?.addCompanyDidFinish(company: newCompany as! Company)
            }
            
    
            //   delegate?.addCompanyDidFinish(company: nameTextField.text ?? "")
            //        dismiss(animated: true) {
            //            let company = Company(context: managedContext)
            //            company.name = self.nameTextField.text ?? ""
            //            self.delegate?.addCompanyDidFinish(company: company)
            //
            //
            //        }
            
        } else {
            //edit (update)
            company?.name = nameTextField.text
            company?.applied = datePicker.date
            CoreDataManager.shared.saveContext()
            dismiss(animated: true) {
                //                let company = Company(context: managedContext)
                //                company.name = self.nameTextField.text ?? ""
                self.delegate?.editCompanyDidFinish(company: self.company!)
                
                
            }
            
            
            
        }
        
        }
        
        //NSPersistentContainer: database
        
        
        // NSManagedObjectContext: scratched pad
        // - viewContext: Manage
    
    

    

}
