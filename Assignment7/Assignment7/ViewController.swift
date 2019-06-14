//
//  ViewController.swift
//  Assignment7
//
//  Created by 고상원 on 2019-05-07.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate, URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        OperationQueue.main.addOperation {
            self.phoneImageView.image = try? UIImage(data: Data(contentsOf: location))
        }
        
    
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print(progress)
    }
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("done")
//    }
    
    
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        print(bytesWritten)
//    }
    
    let phoneImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(phoneImageView)
        phoneImageView.matchParent()
        
        // 1. create an url object
        guard let url = URL(string: "http://imgur.com/zdwdenZ.png") else { return }
        
        // 2. create an URLSession object
        //let session = URLSession.shared //singleton oject (basic configuration)
        let configuration = URLSessionConfiguration.background(withIdentifier: "ca.ciccc.neetwork")
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue())
        
        
//        // 3. create a task (downloadTask)
//        let task = session.downloadTask(with: url) { (location, response, err) in
//            //error checking
//            if let err = err {
//                print("Error",err)
//                return
//            }
//
//            // 5. update UI(main tread)
//            if let location = location {
//                OperationQueue.main.addOperation {
//                    self.phoneImageView.image = try? UIImage(data: Data(contentsOf: location))
//                }
//            }
//        }
        let task = session.downloadTask(with: url)
        // 4. resume! (by default, task -> suspended state)
        task.resume()
        
        //5. update UI (main thread)
    
    }


}

