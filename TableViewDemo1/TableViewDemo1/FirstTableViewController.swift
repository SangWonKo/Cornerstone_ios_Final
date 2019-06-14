//
//  FirstTableViewController.swift
//  TableViewDemo1
//
//  Created by 고상원 on 2019-04-26.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {

    var names:[String] = [
        "Derrick", "Tom", "Gui", "Kazuya", "Juan", "Hao-tse", "Paulo",
        "Scott", "Ayana", "Shota", "Masa", "Enrique", "Mihail", "Ozan",
        "Daisuke", "Danilo"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.delegate = self
        //self.tableView.dateSource = self
      //  navigationController?.navigationBar - navigationBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        navigationItem.rightBarButtonItem = editButtonItem
        
//        if isEditing {
//
//        }
//        else {
//
//        }

    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            print("editing")
        }
        else {
            print("Done")
        }
    }
    
    // MARK - DataSource protocol methods
    override func numberOfSections(in tableView: UITableView) -> Int { // how many sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // how many rows
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NameCell
        cell.nameCell?.text = names[indexPath.row]
        return cell
    }
    
    
    // MARK - Delegate protocol methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Position at \(indexPath.row)")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print(".insert")
        case .delete:
            // DataSource -> names
            // 1. remove the friends from the list
            // 2. refresh the tableView
            names.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        //    tableView.reloadData()
            print(".delete")
        case .none:
            print(".none")
        default:
            break
        }
    }
    
    @objc func addFriend() {
        names.append("Justin")
        tableView.insertRows(at: [IndexPath(row: names.count-1, section: 0)], with: .automatic)
    }

}
