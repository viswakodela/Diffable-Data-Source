//
//  LabelCell.swift
//  Diffable Data Source
//
//  Created by Viswa Kodela on 7/18/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureuserNameLabel()
    }
    
    // MARK:- Properties
    let nameLabel = UILabel()
    
    
    // MARK:- Helper Methods
    private func configureuserNameLabel() {
        backgroundColor = .systemRed
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
