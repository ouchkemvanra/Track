//
//  DashBoardTableViewCell.swift
//  Track
//
//  Created by ty on on 6/12/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import AlamofireImage

class DashBoardTableViewCell: UITableViewCell {
    var titles : UILabel!
    var images : UIImageView!
    var dates : UILabel!
    var descriptions: UILabel!
    var monitoringDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(log: Log){
    
        self.titles.text = log.title
        self.images.image = self.decodeImage(text: log.medecinePhoto[0])
      //  self.images.af_setImage(withURL: URL.init(string: (log.medecinePhoto[0]))!, placeholderImage: UIImage.init(named: "placeholder"), filter: nil)
        //self.images.image = UIImage.init(named: "testImage")
        self.dates.text = log.date
        self.descriptions.text = log.descriptions
        self.monitoringDate.text = log.monitoringDate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImage()
        setupTitle()
        setupDates()
        setupDescriptions()
        setupMonitoringDate()
        Constraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupTitle(){
        titles = UILabel.init(frame: CGRect(x: 8, y: 8, width: self.contentView.frame.size.width - 8, height: 30))
        titles.textAlignment = .left
        titles.font = UIFont.boldSystemFont(ofSize: 18)
        titles.font = UIFont(name: Constant.fontName, size: 18)
        titles.sizeToFit()
        titles.numberOfLines = 0
        
        self.contentView.addSubview(titles)
    }
    func setupImage(){
        images = UIImageView.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        images.contentMode = .scaleAspectFill
        images.image = UIImage.init(named: "placeholder")
        images.clipsToBounds = true
        
       
        self.contentView.addSubview(images)
    }
    func setupDates(){
        dates = UILabel.init(frame: CGRect(x: titles.frame.maxX + 8, y: 8, width: self.contentView.frame.size.width - self.titles.frame.size.width - 16, height: 30))
        dates.textColor = .gray
        dates.textAlignment = .right
        dates.font = dates.font.withSize(12)
        dates.font = UIFont(name: Constant.fontName, size: 12)
        dates.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(dates)
    }
    func setupDescriptions(){
        descriptions = UILabel.init(frame: CGRect(x: titles.frame.minX, y: titles.frame.maxY + 8, width: self.contentView.frame.size.width - images.frame.size.width - 8, height: 30))
        descriptions.textColor = .gray
        descriptions.textAlignment = .left
        descriptions.font = descriptions.font.withSize(13)
        descriptions.font = UIFont(name: Constant.fontName, size: 13)
        self.contentView.addSubview(descriptions)
    }
    func setupMonitoringDate() {
        monitoringDate = UILabel.init(frame: CGRect(x: titles.frame.minX, y: descriptions.frame.maxY, width: descriptions.frame.size.width, height: 30))
        monitoringDate.font = UIFont.boldSystemFont(ofSize: 15)
        monitoringDate.font = UIFont(name: Constant.fontName, size: 13)
        
        self.contentView.addSubview(monitoringDate)
    }
    func Constraints() {
        images.translatesAutoresizingMaskIntoConstraints = false
        titles.translatesAutoresizingMaskIntoConstraints = false
        dates.translatesAutoresizingMaskIntoConstraints = false
        descriptions.translatesAutoresizingMaskIntoConstraints = false
        monitoringDate.translatesAutoresizingMaskIntoConstraints = false
        
      
        images.leading(to: self.contentView, offset: 8, relation: .equal, isActive: true)
        images.top(to: self.contentView, offset: 8, relation: .equal, isActive: true)
        images.width(self.contentView.frame.size.width/4 - 20)
        images.height(self.contentView.frame.size.width/4)
        
        
        titles.leadingToTrailing(of: images, offset: 10, relation: .equal, isActive: true)
        titles.top(to: self.contentView, offset: 8, relation: .equal, isActive: true)
        titles.width(self.contentView.frame.size.width - images.frame.size.width - 90)
        titles.height(30)
        
        
        dates.top(to: titles)
        dates.leadingToTrailing(of: titles, offset: 8, relation: .equal, isActive: true)
        dates.height(30)
        dates.trailing(to: self.contentView, offset: -8, relation: .equal, isActive: true)
        
        
        descriptions.topToBottom(of: titles, offset: 0, relation: .equal, isActive: true)
        descriptions.leading(to: titles)
        descriptions.trailing(to: self.contentView, offset: -8, relation: .equal, isActive: true)
        descriptions.height(30)
        
        monitoringDate.leading(to: titles)
        monitoringDate.topToBottom(of: descriptions, offset: -3, relation: .equal, isActive: true)
        monitoringDate.height(30)
        monitoringDate.trailing(to: self.contentView, offset: 8, relation: .equal, isActive: true)
    }
    

}
extension UITableViewCell{
    func decodeImage(text: String) -> UIImage{
        let strBase64 = text
        let data : Data = Data(base64Encoded: strBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage.init(data: data)!
        
    }
}
