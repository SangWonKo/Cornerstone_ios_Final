//
//  FoodTableViewCell.swift
//  Final
//
//  Created by 고상원 on 2019-06-11.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    
    var refrigerator: Refrigerator! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let currentDate = Date()
           // let calender = Calendar.current
            
            if let name = refrigerator.name, let expire = refrigerator.expireDate {
                foodLabel.text = "\(name)"
                expireDateLabel.text = "Expire Date: \(dateFormatter.string(from: expire))"
                let interval = expire.timeIntervalSince(currentDate)
                let day = Int(interval/86400)
                dueDateLabel.text = "\(day) days left"
            }
            
        }
    }
    
    let foodLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Food Name"
        lb.font = .boldSystemFont(ofSize: 18)
        lb.textColor = .black
        
        return lb
    }()
    
    let expireDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "May 16, 2019"
        lb.font = .italicSystemFont(ofSize: 14)
        lb.textColor = .black
        
        return lb
    }()
    
    let dueDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "3 Days Left"
        lb.font = .boldSystemFont(ofSize: 16)
        lb.textColor = .red
        return lb
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let vStackView = UIStackView(arrangedSubviews: [foodLabel,expireDateLabel])
        vStackView.axis = .vertical
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.distribution = .fillEqually
        vStackView.spacing = 5
        addSubview(vStackView)
        
        vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        vStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(dueDateLabel)
        dueDateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dueDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dueDateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dueDateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
