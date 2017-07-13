//
//  DoctorProfileViewController.swift
//  Track
//
//  Created by ty on on 6/26/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class DoctorProfileViewController: UIViewController {

    var loadingIndicator: UIActivityIndicatorView!
    var profileImage: UIImageView!
    var information: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setTitle(text: "Doctor Profile")
        self.navigationController?.setupNavigationColor()
        self.loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        self.setupActivityIndicator(indicator: loadingIndicator)
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("111111")
                
                
                
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    
                    self.setupProfileImage()
                    self.setupTextView()
                    self.setupConstraintProfileImage()
                    self.setupConstraintTextView()
                    print("This is run on the main queue, after the previous code in outer block")
                }
            }
        }
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: revealViewController, action: #selector(self.revealViewController().revealToggle(_:))), animated: true)
       
        
        
        if self.revealViewController() != nil{
            
            self.setupMenuGestureRecognizer()
            
            
        }
        // Do any additional setup after loading the view.
    }

    
    //MARK: - Setup View
    
    func setupProfileImage() {
        self.profileImage = UIImageView.init(frame: CGRect.zero)
        self.profileImage.contentMode = .scaleAspectFit
        self.profileImage.image = UIImage.init(named: "profilePlaceholder")
        self.view.addSubview(self.profileImage)
    }
    
    func setupTextView() {
        self.information = UITextView.init(frame: CGRect.zero)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        style.alignment = .center
        
        let attributes = [NSParagraphStyleAttributeName : style]
        information.attributedText = NSAttributedString(string: "Name: Dr.Ben" + "\n" + "Dr. Code: ABC123" + "\n" + "Gender: Male" + "\n" + "Age: 66 years old" + "\n" + "Phone: +612345678" + "\n" + "Email: ben@gmail.com" + "\n" + "Address: #22, St 594, Phnom Penh, Cambodia", attributes:attributes)
        self.information.textColor = .gray
        self.information.font = UIFont.init(name: Constant.fontName, size: 16)
        self.information.textAlignment = .center
        self.information.isEditable = false

        //self.information.text = "Name: Dr.Ben" + "\n" + "Dr. Code: ABC123" + "\n" + "Gender: Male" + "\n" + "Age: 66 years old" + "\n" + "Phone: +612345678" + "\n" + "Email: ben@gmail.com" + "\n" + "Address: #22, St 594, Phnom Penh, Cambodia"
        
        self.view.addSubview(self.information)
    }
    func setupConstraintProfileImage() {
        self.profileImage.translatesAutoresizingMaskIntoConstraints = false
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        self.profileImage.centerX(to: self.view)
        self.profileImage.top(to: self.view, offset: 0, relation: .equal, isActive: true)
        self.profileImage.width(width/2 + 30)
        self.profileImage.height(height/2 - 80)
        
    }
    
    func setupConstraintTextView() {
        self.information.translatesAutoresizingMaskIntoConstraints = false
        let width = UIScreen.main.bounds.width
     
        self.information.centerX(to: self.view)
        self.information.topToBottom(of: self.profileImage, offset: 0, relation: .equal, isActive: true)
        self.information.width(width - 16)
        self.information.bottom(to: self.view, offset: -10, relation: .equal, isActive: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
