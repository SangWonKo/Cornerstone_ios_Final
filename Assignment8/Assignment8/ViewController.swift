//
//  ViewController.swift
//  Assignment8
//
//  Created by 고상원 on 2019-05-07.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private let reuseIdentifier = "repo"
    var repos:[Repo] = [Repo]()
    private let refreshController = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshRepos), for: .valueChanged)
        getRepositories(userName: "SangWonKo")
        
    }
    
    @objc func refreshRepos() {
        getRepositories(userName: "SangWonKo")
    }
    
    private func getRepositories(userName: String) {
        guard let url = URL(string: "https://api.github.com/users/\(userName)/repos") else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error", err)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let repos = try decoder.decode([Repo].self, from: data)
                    self.repos = repos
                    // update UI (main thread)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshController.endRefreshing()
                    }
                } catch {
                    debugPrint("Error",error)
                    
                }
//                let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
//
//                if let dict = jsonObj![0] as? [String:Any] {
//                    print(dict["name"])
//                }
                
            }
        }
        task.resume()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
            }
            return cell
        }()
        //let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        //cell.textLabel?.text = repos[]
       // cell.detailTextLabel?.text = "Canada"
       // return cell
        cell.textLabel?.text = repos[indexPath.row].name
        cell.detailTextLabel?.text = repos[indexPath.row].created_at.description
        return cell
    }
    
    

}

