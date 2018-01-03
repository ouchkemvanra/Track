//
//  TrackCollectionViewCell.swift
//  Track
//
//  Created by ty on on 6/16/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    var image: UIImageView!
    var addPhotosButton: UIImageView!
    var deleteButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
        setupDeleteButton()
       
        
        
    }
    func addPhotos(){
        self.addPhotosButton = UIImageView.init(frame: CGRect(x: 8, y: 8, width: 30, height: 30))
        addPhotosButton.contentMode = .scaleAspectFit
        addPhotosButton.image = UIImage.init(named: "add (1)")
        addSubview(addPhotosButton)
        addPhotosButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotosButton.center(in: self.contentView)
        addPhotosButton.width(45)
        addPhotosButton.height(45)
    }
    func setupDeleteButton(){
        deleteButton = UIButton.init(frame: CGRect.zero)
        deleteButton.setImage(UIImage.init(named: "delete"), for: .normal)
        addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.trailing(to: image, offset: 8, relation: .equal, isActive: true)
        deleteButton.top(to: image, offset: -8, relation: .equal, isActive: true)
        deleteButton.width(20)
        deleteButton.height(20)
    }
    func setupImage(){
        image = UIImageView.init(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.center(in: contentView)
        image.width(self.contentView.frame.height - 10)
        image.height(self.contentView.frame.height - 10)
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}
