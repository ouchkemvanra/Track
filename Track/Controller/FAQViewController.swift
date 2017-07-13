//
//  FAQViewController.swift
//  Track
//
//  Created by ty on on 7/3/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {
    var textInfo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setupNavigationColor()
        self.setTitle(text: "FAQ")
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
       
        let normalText = ""
        
        let boldText  = "FAQ \n\nWhat is Melanoma?"
        
        let attributedString = NSMutableAttributedString(string:normalText)
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)]
        let attrss = [NSFontAttributeName : UIFont.systemFont(ofSize: 15)]
        let boldString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let linkAttributes = [
           
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)
            ] as [String : Any]
      let attributedStringss = NSMutableAttributedString(string: "  \nMelanoma is a type of skin cancer that usually manifests itself as a mole. For more detailed information, please read our Melanoma iDesk section. \n\nIs Track free? \nYes, Track is currently free for all to use. However, to use our archiving features, users would need to register an account. \n\nThis is to ensure the accountability, privacy and security of aour users, as our app requires personal photos of their skin to be taken.  \n\nIs Track alone sufficient in diagnosing skin cancer? \nNo, Track does not allow users to perform self-diagnosis. \n\nTrack only provides a level of analysis followed by a recommendation based on the photos users have taken of their skin lesions. These photos can also provide an additional help to the dermatologist upon consultation. \n\nCan Track replace your local dermatologist? \nBy all means, no. Users ultimately need consult a dermatologist for a proper check up a diagnosis. \n\nHow will Track protect my privacy? \nAs mentioned previously, in order to access our archiving features, users will need to register an account. After 7 days of inactivity (the approximate time needed to follow up on a mole), users will nedd to log in again. Also, photos taken will be stored in-app and not in your photo gallery", attributes: attrss)
        
        attributedString.append(boldString)
        attributedString.append(attributedStringss)
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(4, 20))
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(170, 20))
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(458, 51))
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(791, 44))
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(935, 37))
        self.textInfo.attributedText = attributedString

        
        
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
