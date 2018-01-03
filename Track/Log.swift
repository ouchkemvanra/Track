//
//  Log.swift
//  Track
//
//  Created by ty on on 6/22/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import Foundation
class Log: NSObject, NSCoding {
    
    var title: String!
    var descriptions: String!
    var medecinePhoto: [String]!
    var reactionPhoto: [String]!
    var date: String!
    var monitoringDate: String!
    
  init(titles: String, descriptions: String, medecinePhotos: [String], reactionPhotos: [String], dates: String, monitoringDates: String) {
        super.init()
        self.title = titles
        self.descriptions = descriptions
        self.medecinePhoto = medecinePhotos
        self.reactionPhoto = reactionPhotos
        self.date = dates
        self.monitoringDate = monitoringDates

       
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        title = aDecoder.decodeObject(forKey: "title") as? String
        descriptions = aDecoder.decodeObject(forKey: "descriptions") as? String
        medecinePhoto = aDecoder.decodeObject(forKey: "medecinephoto") as? [String]
        reactionPhoto = aDecoder.decodeObject(forKey: "reactionphoto") as? [String]
        date = aDecoder.decodeObject(forKey: "date") as? String
        monitoringDate = aDecoder.decodeObject(forKey: "monitoringdate") as? String
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(descriptions, forKey: "descriptions")
        aCoder.encode(medecinePhoto, forKey: "medecinephoto")
        aCoder.encode(reactionPhoto, forKey: "reactionphoto")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(monitoringDate, forKey: "monitoringdate")
    }
    override init() {
        super.init()
        
        //Do whatever you want here
    }
}
