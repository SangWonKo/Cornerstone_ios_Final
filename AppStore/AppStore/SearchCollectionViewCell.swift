//
//  SearchCollectionViewCell.swift
//  AppStore
//
//  Created by 고상원 on 2019-04-30.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Instagram"
        return lb
    }()
    
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Photos & Videos"
        return lb
    }()
    
    let ratingsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "991K"
        return lb
    }()
    
    let getButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("GET", for: .normal)
        butt.setTitleColor(.blue, for: .normal)
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.backgroundColor = UIColor(white: 0.95, alpha: 1)
        butt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        butt.heightAnchor.constraint(equalToConstant: 32).isActive = true
        butt.layer.cornerRadius = 16
        return butt
    }()
    
    lazy var screenshot1ImageView: UIImageView = createScreenShotImageView()
    lazy var screenshot2ImageView: UIImageView = createScreenShotImageView()
    lazy var screenshot3ImageView: UIImageView = createScreenShotImageView()
    
    fileprivate func createScreenShotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.layer.cornerRadius = 8
        return iv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingsLabel
            ])
        labelsStackView.axis = .vertical
        
        let appInfoStackView = UIStackView(arrangedSubviews: [
            iconImageView, labelsStackView, getButton
            ])
        appInfoStackView.spacing = 12
        appInfoStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [
            screenshot1ImageView, screenshot2ImageView, screenshot3ImageView
            ])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let wholeStackView = UIStackView(arrangedSubviews: [
            appInfoStackView, screenshotsStackView
            ])
        wholeStackView.axis = .vertical
        wholeStackView.spacing = 16
        
        addSubview(wholeStackView)
        wholeStackView.matchParent(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UIView {
    
    func matchParent(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superTopAnchor = superview?.topAnchor {
            self.topAnchor.constraint(equalTo: superTopAnchor, constant: padding.top).isActive = true
        }
        if let superBottomAnchor = superview?.bottomAnchor {
            self.bottomAnchor.constraint(equalTo: superBottomAnchor, constant: -padding.bottom).isActive = true
        }
        if let superLeadingAnchor = superview?.leadingAnchor {
            self.leadingAnchor.constraint(equalTo: superLeadingAnchor, constant: padding.left).isActive = true
        }
        if let superTrailingAnchor = superview?.trailingAnchor {
            self.trailingAnchor.constraint(equalTo: superTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
}


