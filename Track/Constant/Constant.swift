//
//  Constant.swift
//  Track
//
//  Created by ty on on 6/7/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import Foundation
import UIKit
struct Constant {
// MARK: Color
     static var defaultColor = UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
     static var textBackground = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 0.5)
     static var textBorder = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    
    static var icons = [UIImage.init(named: "dashboard"), UIImage.init(named: "archive"),UIImage.init(named: "doctor"),UIImage.init(named: "about"),UIImage.init(named: "faq"),UIImage.init(named: "disclaimer")]
    static var menuTitles = ["Dashboard", "Archives", "Dr.Profile", "About", "FAQ", "Disclaimer"]
    static var fontName = "futura"
    static var profileInforPlaceholder = [[""]]
    static var locale = Locale.current
    static var countries = Locale.isoRegionCodes.map {
        locale.localizedString(forRegionCode: $0)!
        }.sorted()
    static  var languages : [String]! = ["Cambodia", "English"]
    static var profileInforIcon : [[UIImage]] = [[UIImage.init(named: "location")!,UIImage.init(named: "user")!,UIImage.init(named: "language")!],[UIImage.init(named: "email")!,UIImage.init(named: "tel")!,UIImage.init(named: "home")!]]
    static var profileInforPlacholder : [[String]] = [["Location", "Nationality", "Languge"],["Email", "Tel", "Address"]]

}
