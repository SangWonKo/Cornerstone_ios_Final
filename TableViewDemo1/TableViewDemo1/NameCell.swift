//
//  NameCell.swift
//  TableViewDemo1
//
//  Created by 고상원 on 2019-04-26.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet var nameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
