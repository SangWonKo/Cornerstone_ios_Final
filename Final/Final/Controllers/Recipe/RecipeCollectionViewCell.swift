//
//  RecipeCollectionViewCell.swift
//  Final
//
//  Created by 고상원 on 2019-06-13.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

protocol RecipeCellDelegate: class {
    func delete(cell: RecipeCollectionViewCell)
}

class RecipeCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: RecipeCellDelegate?
    
    
    var recipe: Recipe! {
        didSet {
            if let title = recipe.title, let description = recipe.text {
                titleLabel.text = "\(title)"
                descriptionLabel.text = "\(description)"
            }
            
            if let imageData = recipe.image {
                cellImageView.image = UIImage(data: imageData)
            }
            
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            deleteButton.isHidden = !isEditing
        }
    }
    
    private let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.constraintHeight(equalToConstant: 200)
        return iv
    }()
    
    private let titleLabel: UILabel = UILabel(font: .boldSystemFont(ofSize: 24))
    
    private let descriptionLabel: UILabel = UILabel(font: .systemFont(ofSize: 14),
                                                    textColor: UIColor(white: 0.4, alpha: 1.0))
    
    private let deleteButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "close"), for: .normal)
        b.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return b
    }()
    
    @objc func buttonClicked() {
        delegate?.delete(cell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel,descriptionLabel])
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.spacing = 0
        labelStackView.distribution = .equalSpacing
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(labelStackView)
        
        cellImageView.anchors(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, bottomAnchor: nil)
        labelStackView.anchors(topAnchor: cellImageView.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, bottomAnchor: contentView.bottomAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        cellImageView.addSubview(deleteButton)
        deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        deleteButton.isHidden = !isEditing
        setShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setShadow() {
        // shadowing slows down the performance
        backgroundView = UIView()
        backgroundView?.matchParent()
        backgroundView?.backgroundColor = .white
        backgroundView?.layer.cornerRadius = 16
        backgroundView?.layer.shadowColor = UIColor.black.cgColor
        backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 2)
        backgroundView?.layer.shadowRadius = 16
        backgroundView?.layer.shadowOpacity = 0.3
        backgroundView?.layer.masksToBounds = false // do not want to clip the shadows
        backgroundView?.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
        // increase performance (scroll) - but blury when you apply on contentView's layer
        backgroundView?.layer.shouldRasterize = true
    }

    
}


