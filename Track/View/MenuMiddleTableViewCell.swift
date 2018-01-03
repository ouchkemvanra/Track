//
//  MenuMiddleTableViewCell.swift
//  Track
//
//  Created by ty on on 6/12/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class MenuMiddleTableViewCell: UITableViewCell {
    var titles: UILabel!
    var icons: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(icon: UIImage, title: String){
        self.titles.text = title
        self.icons.image = icon
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIcon()
        setupTitles()
        Constraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupTitles(){
        titles = UILabel.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        titles.textAlignment = .left
        titles.font = UIFont(name: Constant.fontName, size: 18)
        self.contentView.addSubview(titles)
        
    }
    func setupIcon(){
        icons = UIImageView.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        icons.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(icons)
    }
    func Constraints(){
        titles.translatesAutoresizingMaskIntoConstraints = false
        icons.translatesAutoresizingMaskIntoConstraints = false
        
        icons.leading(to: self.contentView, offset: 16, relation: .equal, isActive: true)
        icons.centerY(to: self.contentView)
        icons.width(20)
        icons.height(20)
        
        titles.leadingToTrailing(of: icons, offset: 16, relation: .equal, isActive: true)
        titles.top(to: self.contentView, offset: 8, relation: .equal, isActive: true)
        titles.trailing(to: self.contentView, offset: -8, relation: .equal, isActive: true)
        titles.height(44)
        
       
        
    }

}
