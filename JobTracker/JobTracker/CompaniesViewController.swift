//
//  CompaniesViewController.swift
//  JobTracker
//
//  Created by 고상원 on 2019-05-14.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController, AddCompanyControllerDelegate {
    //MARK: - constants
    private let reuseIdentifier = "companyCell"
    // MARK: - properties
    var companies = [Company]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK - Life Cycle methods
        view.backgroundColor = .black
        navigationItem.title = "Company List"
        tableView.separatorColor = .spaceGray
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupRightAddButton()
        fetchCompanies()
        
    }
    
    //MARK: - helper methods
    private func setupRightAddButton() {
        let addButton = UIBarButtonItem(image: UIImage(named: "add2"), style: .plain, target: self, action: #selector(navigateAddCompany))
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func navigateAddCompany() {
        let addVC = AddCompanyViewController()
        addVC.delegate = self
        let addNVC = LightStatusBarNavigationController(rootViewController: addVC)
    
        
        present(addNVC, animated: true, completion: nil)
    }
    
    private func fetchCompanies() {
        
        
        // NSManagedObjectContext: scratched pad
        // - viewContext: Manage
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
//        let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: managedContext)
//        newCompany.setValue(nameTextField.text ?? "", forKey: "name")
        
        do {
            let companies = try managedContext.fetch(fetchRequest)
            companies.forEach { (company) in
                print(company.name ?? "")
                
            }
            
        } catch let err {
            print("Failed to save new company: \(err)")
        }
    }
    
    //MARK: - Add company controller delegate
    
    func addCompanyDidFinish(company: Company) {
        
        companies.append(company)
        let insertPath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [insertPath], with: .automatic)
    }
    
   // func addCompanyDidCancel() {}
    
    func editCompanyDidFinish(company: Company) {
        let row = companies.firstIndex(of: company)!
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .middle)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.textLabel?.text = companies[indexPath.row].name
        cell.textLabel?.textColor = .white
        return cell
    }
    
    // MARK: - tableview delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            print("Trying to do delete company \(self.companies[indexPath.row].name!)")
            // 1. remove from the tableview
            let company = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // 2. remove from the database
            let managedContext = CoreDataManager.shared.persistentContainer.viewContext
            
            managedContext.delete(company)
            
            CoreDataManager.shared.saveContext()
            
//            do {
//                try managedContext.save()
//            } catch let saveErr {
//                fatalError("Failed to delete a company: \(saveErr)")
//            }
        }
        
        //edit action
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
//            print("Trying to edit\(self.companies[indexPath.row].name!)")
            // 1. navigate(modal) to AddCompanyViewController
            let editVC = AddCompanyViewController()
            editVC.delegate = self
            editVC.company = self.companies[indexPath.row]
            let editNVC = LightStatusBarNavigationController(rootViewController: editVC)
            
            
            self.present(editNVC, animated: true, completion: nil)
            
        }
        return [deleteAction, editAction]
    }

    

}
