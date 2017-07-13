//
//  AboutViewController.swift
//  Track
//
//  Created by ty on on 7/3/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    var textInfo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setupNavigationColor()
        self.setTitle(text: "ABOUT")
        self.setupView()
        if self.revealViewController() != nil{
            
            self.setupMenuGestureRecognizer()
            
            navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: revealViewController, action: #selector(self.revealViewController().revealToggle(_:))), animated: true)
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Setup View
    
    func setupView(){
        self.textInfo = UITextView.init(frame: CGRect.zero)
        self.textInfo.font = UIFont(name: Constant.fontName, size: 15)
        self.textInfo.textColor = .black
        self.textInfo.isEditable = false
        
        self.textInfo.textAlignment = .left
        let linkAttributes = [
            NSLinkAttributeName: NSURL(string: "https://www.gmail.com")!,
            NSForegroundColorAttributeName: UIColor.blue,
            NSFontAttributeName: UIFont.systemFont(ofSize: 15)
            ] as [String : Any]
        
        let normalText = ""
        
        let boldText  = "About Us"
        
        let attributedString = NSMutableAttributedString(string:normalText)
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)]
        let attrss = [NSFontAttributeName : UIFont.systemFont(ofSize: 15)]
        let boldString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let attributedStringss = NSMutableAttributedString(string: "\n\nTrack, is a mobile application that helps users track and monitor their record, while providing other userful skincare information as well. \n\nPrevalence of Skin cancer, especially Melanoma, is on the rise. Malanoma is notably one of the most deadly types of skin cancer. Fortuanely, it can be cured if detected during the early stages - Track plans to do just that. With our proprietary algorithms, we aim to provide users an (sufficiently) accurate analysis. \n\nTrack is a Singaporean-based company, focusing on being the first in the region to provide such servies. \n\nFor more information about our app, do read up the FAQ section or contact us at support@dermaanalytics.com", attributes: attrss)
        
        attributedString.append(boldString)
        attributedString.append(attributedStringss)
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(658, 27))
        self.textInfo.attributedText = attributedString
        //self.textInfo.font = UIFont(name: Constant.fontName, size: 15)
        //        let attributedString = NSMutableAttributedString(string: "\nAbout Us \n\nTrack, is a mobile application that helps users track and monitor their record, while providing other userful skincare information as well. \n\nPrevalence of Skin cancer, especially Melanoma, is on the rise. Malanoma is notably one of the most deadly types of skin cancer. Fortuanely, it can be cured if detected during the early stages - Track plans to do just that. With our proprietary algorithms, we aim to provide users an (sufficiently) accurate analysis. \n\nTrack is a Singaporean-based company, focusing on being the first in the region to provide such servies. \n\nFor more information about our app, do read up the FAQ section or contact us at support@dermaanalytics.com")
        
        
        
        //        self.textInfo.text = "\nAbout Us \n\n\tTrack, is a mobile application that helps users track and monitor their record, while providing other userful skincare information as well. \n\n\tPrevalence of Skin cancer, especially Melanoma, is on the rise. Malanoma is notably one of the most deadly types of skin cancer. Fortuanely, it can be cured if detected during the early stages - Track plans to do just that. With our proprietary algorithms, we aim to provide users an (sufficiently) accurate analysis. \n\n\tTrack is a Singaporean-based company, focusing on being the first in the region to provide such servies. \n\n\tFor more information about our app, do read up the FAQ section or contact us at support@dermaanalytics.con"
        
        
        self.view.addSubview(self.textInfo)
        self.setupConstraint()
    }
    
    
    // Setup Constraint
    
    func setupConstraint(){
        self.textInfo.translatesAutoresizingMaskIntoConstraints = false
        
        self.textInfo.center(in: self.view)
        self.textInfo.top(to: self.view, offset: 8, relation: .equal, isActive: true)
        self.textInfo.bottom(to: self.view, offset: -8, relation: .equal, isActive: true)
        self.textInfo.width(self.view.frame.size.width - 16)

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
