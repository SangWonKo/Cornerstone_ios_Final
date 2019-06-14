//
//  UIView+ConvenienceInit.swift
//  Final
//
//  Created by 고상원 on 2019-06-13.
//  Copyright © 2019 고상원. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont? = nil, textColor: UIColor? = nil) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let font = font {
            self.font = font
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        self.text = text
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}

extension UIButton {
    static func appleGetButton() -> UIButton {
        let butt = UIButton(type: .system)
        butt.setTitle("GET", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.backgroundColor = UIColor(white: 0.95, alpha: 1)
        butt.constraintWidth(equalToConstant: 80)
        butt.constraintHeight(equalToConstant: 32)
        butt.layer.cornerRadius = 16
        return butt
    }
}

