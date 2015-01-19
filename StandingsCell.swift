//
//  StandingsCell.swift
//  CatchPhrase
//
//  Created by Alberto Benavides on 1/13/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import UIKit

class StandingsCell: UICollectionViewCell {
    
    let textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel = UILabel(frame: CGRect())
        textLabel.textAlignment = .Center
        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(textLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
