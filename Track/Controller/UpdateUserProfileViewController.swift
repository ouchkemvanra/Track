//
//  UpdateUserProfileViewController.swift
//  Track
//
//  Created by ty on on 7/5/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
protocol updateUserInfoDelegate {
    func dismissEditInfo()
    func saveInfo()
}

class UpdateUserProfileViewController: UIViewController {
    var username: UITextField!
    var userAge: UITextField!
    var userGender: UITextField!
    var titleLabel: UILabel!
    var saveButton: UIButton!
    var mainView: UIView!
    var delegate : updateUserInfoDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        self.setupView()
        self.setupTitleLabel()
        self.setupUserNameTextField()
        self.setupUserAgeTextField()
        self.setupUserGenderTextField()
        self.setupSaveButton()
//        self.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissInfoView)))
        
        // Do any additional setup after loading the view.
    }
    func dismissInfoView(){
        delegate.dismissEditInfo()
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        dismissInfoView()
    }
    func dismisskeyboard(){
        view.endEditing(true)
    }
    
    
    // MARK - Setup View
    
    func setupView(){
        self.mainView = UIView.init(frame: CGRect.zero)
        self.mainView.backgroundColor = .white
        self.mainView.layer.cornerRadius = 4.0
        
        self.view.addSubview(self.mainView)
        self.setupConstraint()
    }
    //setup Title Label
    
    func setupTitleLabel() {
        self.titleLabel = UILabel.init(frame: CGRect.zero)
        self.titleLabel.textAlignment = .center
        
        self.titleLabel.font = UIFont(name: Constant.fontName, size: 15)
        self.titleLabel.textColor = .black
      
        self.titleLabel.text = "Profile"
        
        self.mainView.addSubview(titleLabel)
        self.setupTitleLabelConstraint()
    }
    
    //setup UserName Textfield
    
    func setupUserNameTextField() {
        self.username = UITextField.init(frame: CGRect.zero)
        self.username.placeholder = "Username"
        
        self.username.font = UIFont(name: Constant.fontName, size: 15)
        self.username.textColor = .black
        self.username.layer.cornerRadius = 4
        self.username.layer.borderColor = Constant.defaultColor.cgColor
        self.username.layer.borderWidth = 1.0
        self.mainView.addSubview(self.username)
        self.setupUserNameConstraint()
    }
    
    //setup User Age Textfield
    
    func setupUserAgeTextField() {
        self.userAge = UITextField.init(frame: CGRect.zero)
        self.userAge.placeholder = "Age"
    
        self.userAge.layer.cornerRadius = 4
        self.userAge.layer.borderColor = Constant.defaultColor.cgColor
        self.userAge.layer.borderWidth = 1.0
        self.userAge.font = UIFont(name: Constant.fontName, size: 15)
        self.userAge.textColor = .black
        self.mainView.addSubview(self.userAge)
        self.setupAgeConstraint()
    }

    //setup User Gender Textfield
    
    func setupUserGenderTextField() {
        self.userGender = UITextField.init(frame: CGRect.zero)
        self.userGender.placeholder = "Gender"
        self.userGender.layer.cornerRadius = 4
        self.userGender.layer.borderColor = Constant.defaultColor.cgColor
        self.userGender.layer.borderWidth = 1.0
        self.userGender.font = UIFont(name: Constant.fontName, size: 15)
        self.userGender.textColor = .black
        self.mainView.addSubview(self.userGender)
        self.setupGenderConstraint()
    }
    func setupSaveButton(){
        self.saveButton = UIButton.init(frame: CGRect.zero)
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.backgroundColor = Constant.defaultColor
        self.saveButton.layer.cornerRadius = 4.0
        
        self.mainView.addSubview(self.saveButton)
        
        self.setupSaveButtonConstraint()
    }
    
    
    
    func setupTitleLabelConstraint(){
           self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.top(to: self.mainView, offset: 8, relation: .equal, isActive: true)
        self.titleLabel.leading(to: self.mainView, offset: 16, relation: .equal, isActive: true)
        self.titleLabel.height(40)
        self.titleLabel.trailing(to: self.mainView, offset: -8, relation: .equal, isActive: true)
    }
    
    func setupUserNameConstraint(){
        self.username.translatesAutoresizingMaskIntoConstraints = false
        
        self.username.topToBottom(of: self.titleLabel, offset: 16, relation: .equal, isActive: true)
        self.username.leading(to: titleLabel)
        self.username.trailing(to: self.titleLabel)
        self.username.height(40)
    }
    func setupAgeConstraint(){
        self.userAge.translatesAutoresizingMaskIntoConstraints = false
        self.userAge.topToBottom(of: self.username, offset: 16, relation: .equal, isActive: true)
        self.userAge.leading(to: self.titleLabel)
        self.userAge.trailing(to: self.username, offset: -(UIScreen.main.bounds.width/2 - 8), relation: .equal, isActive: true)
        self.userAge.height(40)
    }
    
    func setupGenderConstraint(){
        self.userGender.translatesAutoresizingMaskIntoConstraints = false
        self.userGender.topToBottom(of: self.username, offset: 16, relation: .equal, isActive: true)
        self.userGender.trailing(to: self.titleLabel)
        self.userGender.width(to: self.userAge)
        self.userGender.height(40)
    }
    func setupSaveButtonConstraint(){
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.saveButton.topToBottom(of: self.userAge, offset: 16, relation: .equal, isActive: true)
        self.saveButton.leading(to: self.userAge)
        self.saveButton.width(to: self.username)
        self.saveButton.height(60)
    }
    
    func setupConstraint(){
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
    
        self.mainView.centerX(to: self.view)
        self.mainView.width(self.view.frame.size.width - 32)
        self.mainView.height(self.view.frame.size.height/2 - 50)
        self.mainView.top(to: self.view, offset: 100, relation: .equal, isActive: true)
       
        
    
    
       
        
     
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
