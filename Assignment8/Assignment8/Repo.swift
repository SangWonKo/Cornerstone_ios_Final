//
//  Repo.swift
//  Assignment8
//
//  Created by 고상원 on 2019-05-08.
//  Copyright © 2019 고상원. All rights reserved.
//

import Foundation

class Repo: Decodable {
    let id: Int
    let name: String
    let full_name: String
    let clone_url: String
    let created_at: String
}
