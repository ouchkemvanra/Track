//
//  MenuTopTableViewCell.swift
//  Track
//
//  Created by ty on on 6/12/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import AlamofireImage

class MenuTopTableViewCell: UITableViewCell {
    var profileImage: UIImageView!
    var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(){
        let url = "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/18157027_1387579324639169_3978796641263566916_n.jpg?oh=59e379317e9b9f50c7dd979cb5f77b72&oe=59E6BC37"
        let filter = CircleFilter()
        self.profileImage.af_setImage(withURL: URL.init(string: url)!, placeholderImage: UIImage.init(named: "profilePlaceholder"), filter: filter)
        
        self.username.text = "Ouch Kemvanra"
        //self.profileImage.image = UIImage.init(named: "profileImage")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = Constant.defaultColor
        setupProfileImage()
        setupUsername()
        Constraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupProfileImage()  {
        profileImage = UIImageView.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        profileImage.contentMode = .scaleAspectFit
        
        
        self.contentView.addSubview(profileImage)
        
    
    }
    func setupUsername() {
        username = UILabel.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        username.font = UIFont(name: Constant.fontName, size: 18)
        username.textAlignment = .center
        username.textColor = .white
        
        username.numberOfLines = 2
        self.contentView.addSubview(username)
    }
    func Constraints() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        
        profileImage.leading(to: self.contentView, offset: 20, relation: .equal, isActive: true)
        profileImage.centerY(to: self.contentView)
        profileImage.width((UIScreen.main.bounds.width - 50)/5)
        profileImage.height((UIScreen.main.bounds.width - 50)/5)
        
        username.centerY(to: self.contentView)
        username.leadingToTrailing(of: profileImage, offset: 20, relation: .equal, isActive: true)
        username.height(44)
        
      
    }

}
