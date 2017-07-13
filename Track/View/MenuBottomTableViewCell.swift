//
//  MenuBottomTableViewCell.swift
//  Track
//
//  Created by ty on on 6/13/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class MenuBottomTableViewCell: UITableViewCell {
    var loginLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = Constant.defaultColor
        setupLoginBtn()
        constraint()
      
    }
    func setupLoginBtn(){
        loginLbl = UILabel.init(frame: CGRect.zero)
        loginLbl.backgroundColor = Constant.defaultColor
        loginLbl.layer.masksToBounds = true
        loginLbl.layer.cornerRadius = 8
        loginLbl.text = "Login"
        loginLbl.textColor = .white
        loginLbl.textAlignment = .center
        loginLbl.font = UIFont(name: Constant.fontName, size: 20)
        self.contentView.addSubview(loginLbl)
    }
    func constraint(){
        loginLbl.translatesAutoresizingMaskIntoConstraints = false
        
        loginLbl.centerY(to: self.contentView)
        loginLbl.leading(to: self.contentView, offset: 40, relation: .equal, isActive: true)
        loginLbl.trailing(to: self.contentView, offset: -80, relation: .equal, isActive: true)
        loginLbl.height(self.contentView.frame.size.height - 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
