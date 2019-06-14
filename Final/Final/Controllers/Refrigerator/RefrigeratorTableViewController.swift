//
//  RefrigeratorTableViewController.swift
//  Final
//
//  Created by 고상원 on 2019-06-11.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit
import CoreData

class RefrigeratorTableViewController: UITableViewController, AddFoodControllerDelegate {
    
    
    
    private let cellId = "foodCell"
    
    var sections: [String] = ["Meat","Vegetable","Fruit", "Dairy Product"]
    var meat = [Refrigerator]()
    var vegetable = [Refrigerator]()
    var fruit = [Refrigerator]()
    var dairy = [Refrigerator]()

    lazy var dict: Dictionary = [0:meat, 1:vegetable, 2:fruit, 3:dairy]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFood))
        
    }
    
    @objc func addFood() {
        let addFoodVC = addFoodViewController()
        addFoodVC.delegate = self
        navigationController?.pushViewController(addFoodVC, animated: true)
        
    }
    
    private func fetchFood() {
        // NSManagedObjectContext: scratch pad
        // - viewContext: ManagedObjectContext (main thread)
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Refrigerator>(entityName: "Refrigerator")
        do {
            let food =  try managedContext.fetch(fetchRequest)
            self.meat = food
            tableView.reloadData()
        } catch let err {
            print("Failed to fetch food: \(err)")
        }
    }
    
    func addMeatDidFinish(refrigerator: Refrigerator) {
        meat.append(refrigerator)
        let insertPath = IndexPath(row: meat.count - 1, section: 0)
        tableView.insertRows(at: [insertPath], with: .automatic)
    }
    
    func addVegetableDidFinish(refrigerator: Refrigerator) {
        vegetable.append(refrigerator)
        let insertPath = IndexPath(row: vegetable.count - 1, section: 0)
        tableView.insertRows(at: [insertPath], with: .automatic)
    }
    
    func addFruitDidFinish(refrigerator: Refrigerator) {
        fruit.append(refrigerator)
        let insertPath = IndexPath(row: fruit.count - 1, section: 0)
        tableView.insertRows(at: [insertPath], with: .automatic)
    }
    
    func addDairyDidFinish(refrigerator: Refrigerator) {
        dairy.append(refrigerator)
        let insertPath = IndexPath(row: dairy.count - 1, section: 0)
        tableView.insertRows(at: [insertPath], with: .automatic)
    }
    
    func editFoodDidFinish(refrigerator: Refrigerator) {
        if let row = meat.firstIndex(of: refrigerator) {
            tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .middle)
        }
        else if let row = vegetable.firstIndex(of: refrigerator) {
            tableView.reloadRows(at: [IndexPath(row: row, section: 1)], with: .middle)
        }
        else if let row = fruit.firstIndex(of: refrigerator) {
            tableView.reloadRows(at: [IndexPath(row: row, section: 2)], with: .middle)
        }
        else if let row = dairy.firstIndex(of: refrigerator) {
            tableView.reloadRows(at: [IndexPath(row: row, section: 3)], with: .middle)
        }
        
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if section == 0 {
            count = meat.count
        }
        else if section == 1 {
            count = vegetable.count
        }
        else if section == 2 {
            count = fruit.count
        }
        else if section == 3 {
            count = dairy.count
        }
//        count = dict[section]!.count
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FoodTableViewCell
        if indexPath.section == 0 {
            cell.refrigerator = meat[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.refrigerator = vegetable[indexPath.row]
        }
        else if indexPath.section == 2 {
            cell.refrigerator = fruit[indexPath.row]
        }
        else if indexPath.section == 3 {
            cell.refrigerator = dairy[indexPath.row]
        }
//        cell.refrigerator = dict[indexPath.section]?[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .gray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .boldSystemFont(ofSize: 15)
        header.textLabel?.textColor = .black
        
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // 1. remove from the tableview
            if indexPath.section == 0 {
                let meat = self.meat[indexPath.row]
                self.meat.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                CoreDataManager.shared.persistentContainer.viewContext.delete(meat)
                CoreDataManager.shared.saveContext()
            }
            else if indexPath.section == 1 {
                let vegetable = self.vegetable[indexPath.row]
                self.vegetable.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                CoreDataManager.shared.persistentContainer.viewContext.delete(vegetable)
                CoreDataManager.shared.saveContext()
            }
            else if indexPath.section == 2 {
                let fruit = self.fruit[indexPath.row]
                self.fruit.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                CoreDataManager.shared.persistentContainer.viewContext.delete(fruit)
                CoreDataManager.shared.saveContext()
            }
            else if indexPath.section == 3 {
                let dairy = self.dairy[indexPath.row]
                self.dairy.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                CoreDataManager.shared.persistentContainer.viewContext.delete(dairy)
                CoreDataManager.shared.saveContext()
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // 1. navigate(modal) to AddCompanyViewController
            let editVC = addFoodViewController()
            editVC.delegate = self
            if indexPath.section == 0 {
                editVC.refrigerator = self.meat[indexPath.row]
            }
            else if indexPath.section == 1 {
                editVC.refrigerator = self.vegetable[indexPath.row]
            }
            else if indexPath.section == 2 {
                editVC.refrigerator = self.fruit[indexPath.row]
            }
            if indexPath.section == 3 {
                editVC.refrigerator = self.dairy[indexPath.row]
            }
            
            // modal transition
            self.present(editVC, animated: true, completion: nil)
        }
        
        
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   

}
