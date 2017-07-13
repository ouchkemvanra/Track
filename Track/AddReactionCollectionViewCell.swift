//
//  AddReactionCollectionViewCell.swift
//  Track
//
//  Created by ty on on 6/20/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class AddReactionCollectionViewCell: UICollectionViewCell {
    var image: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(){
        image = UIImageView.init(frame: CGRect.zero)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.center(in: contentView)
        image.width(45)
        image.height(45)
    }
    
}
