//
//  DisclaimerViewController.swift
//  Track
//
//  Created by ty on on 7/3/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class DisclaimerViewController: UIViewController {
    var textInfo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setupNavigationColor()
        self.setTitle(text: "DISCLAIMER")
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
        
        let boldText  = "Disclaimer"
        
        let attributedString = NSMutableAttributedString(string:normalText)
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)]
        let attrss = [NSFontAttributeName : UIFont.systemFont(ofSize: 15)]
        let boldString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let attributedStringss = NSMutableAttributedString(string: " \n\nDisclaimer 1. Supply of Services a. The Services are comprised of the downloadable iPhone or Android smartphone application DermA. b. The Services are provided to you as follows: i. You register and receive a DermA account; ii. You upload your digital images to your account, through DermA iii. We run an automatic analysis of your uploaded images and provide an on the spot recommendation on whether you need to see a dermatologist. You are advised to review your images before, and if you consider it necessary, arrange an appointment with a medical professional. 2. Disclaimer of Services a. DermA is intended to complement, not substitute, your existing skin self-examination. The DermA only facilitates your skin monitoring routine and will flag the possibility of Melanoma (the probability score provided on the results page) on the basis of the images provided to us by you. DermA does not constitute a medical device and does not provide any form of diagnosis, cure or treatment. b. You should not solely rely in any way on DermA and any associated materials or information. We do not claim 100% accuracy on the score or recommendation provided. Any reliance by you is at your own discretion and risk. c. You are responsible for ensuring images uploaded are of good quality e.g. using a smartphone with a decent camera, ensuring good light. Failure to do so may result in DermA being less effective d. Our ability to provide recommendations effectively may be compromised when you upload images where lesions are obscured by large amounts of hair or where there is not a reasonable level of contrast between the colour of a lesion and your normal skin tone. e. DermA is not a substitute for a visit to a medical professional, and thus you should not delay seeking medical advice. f. The Ultra-Violet Ray Index and its respective recommendations provided by DermA are powered by a third-party services provider, AccuWeather. g. Once you have created an account with DermA, you will not be able to delete it. 3. Data Protection and Privacy a. We use several security procedures to protect your personal information and data from unauthorised access or disclosure and to ensure compliance with data protection standards. b. Our web servers have SSL certificates installed on them; all data (whether sensitive or not) are transferred from you to us are encrypted by HTTPS. c. Account passwords are stored using one-way encryption and so cannot be retrieved or decrypted d. All systems, both web servers and database servers, sit behind a firewall restricted to only necessary ports for running the Website and all sensitive areas of the Website and App (login and account sections) run over industry standard secure SSL-encrypted protocols to prevent interception and unwanted access to accounts. e. Your payment details are not shared with or held by us at any time, and we do not store them on our servers f. We store your digital images on Amazon Web Service (AWS) cloud servers and the data centre currently resides in Australia. AWS itself also has its security protocols that will add to the overall defence of our platform. We may also use the third-party service providers in future for data security should the need arises. 4. Use of your data a. By uploading your images to DermA, you explicitly consent to the images being processed for the purposes of the provision of DermA’s services and to be used anonymously for the purposes of research and testing of the software. As such, your images may be reviewed by our employees or third-party consultants engaged by us. b. All third-party service providers mentioned in these Terms are subject to similar privacy obligations as are contained in these Terms. c. You grant us an transferable, sub-licensable, royalty-free, worldwide, perpetual license to use anonymously any of the images and data that you upload to DermA for the purposes of medical, clinical and commercial research. We will retain and protect your personal information in the usual way during this period and you explicitly consent to your images continuing to be used anonymously for the purposes of medical, clinical and commercial research, and for testing and improvement of DermA. You agree that images uploaded prior to registration, in respect of which you consent to their continued use, in anonymous form only, for the purposes of medical, clinical and commercial research, and for testing of DermA.", attributes: attrss)
        
        attributedString.append(boldString)
        attributedString.append(attributedStringss)
        
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
