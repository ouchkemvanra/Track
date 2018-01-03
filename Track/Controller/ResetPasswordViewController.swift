//
//  ResetPasswordViewController.swift
//  Track
//
//  Created by ty on on 6/9/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    var textLabel: UILabel!
    var codeTxtField: UITextField!
    var newPasswordTxtField: UITextField!
    var confirmNewPasswordTxtField: UITextField!
    var submitButton: UIButton!
    var alreadyHaveAccountButton: UIButton!
    
    var oldPassword: String!
    var newPassword: String!
    var confirmNewPassword: String!
    
    
    var textArray : [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(text: "Reset Password")
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .white
       
    }
    func setup(){
        setupRegisterLabel()
        // setupEmail()
        // setupName()
        
        codeTxtField = UITextField.init()
        codeTxtField.textFieldSetup(title: "  Code", Y: textLabel.frame.maxY + 8)
        codeTxtField.delegate = self
        codeTxtField.font = UIFont(name: Constant.fontName, size: 15)
        codeTxtField.returnKeyType = .next
        
        
        newPasswordTxtField = UITextField.init()
        newPasswordTxtField.textFieldSetup(title: "  New Password", Y: codeTxtField.frame.maxY + 8)
        newPasswordTxtField.delegate = self
        newPasswordTxtField.returnKeyType = .next
        newPasswordTxtField.font = UIFont(name: Constant.fontName, size: 15)
        newPasswordTxtField.isSecureTextEntry = true
        
        confirmNewPasswordTxtField = UITextField.init()
        confirmNewPasswordTxtField.textFieldSetup(title: "  Confrim New Password", Y: newPasswordTxtField.frame.maxY + 8)
        confirmNewPasswordTxtField.delegate = self
        confirmNewPasswordTxtField.returnKeyType = .done
        confirmNewPasswordTxtField.font = UIFont(name: Constant.fontName, size: 15)
        confirmNewPasswordTxtField.isSecureTextEntry = true
        
        submitButton = UIButton.init(frame: CGRect(x: 8, y: confirmNewPasswordTxtField.frame.maxY + 8, width: confirmNewPasswordTxtField.frame.size.width, height: 50))
        submitButton.addTarget(self, action: #selector(didTapOnSubmit(sender:)), for: .touchUpInside)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = Constant.defaultColor
        submitButton.layer.cornerRadius = 10.0
        submitButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 18)
        disableRgisterBtn()
        
        
        self.view.addSubview(codeTxtField)
        self.view.addSubview(newPasswordTxtField)
        self.view.addSubview(confirmNewPasswordTxtField)
        self.view.addSubview(submitButton)
        
      
        
        setupconstraint()
        textArray = [codeTxtField, newPasswordTxtField, confirmNewPasswordTxtField] as [UITextField]
    }
    func setupRegisterLabel(){
        textLabel = UILabel.init(frame: CGRect(x: 8, y: 8, width: 100, height: 30))
        textLabel.text = "Reset Password"
        textLabel.textColor = UIColor.lightGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: Constant.fontName, size: 25)
        
        
        self.view.addSubview(textLabel)
    }

    func setupconstraint(){
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        codeTxtField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTxtField.translatesAutoresizingMaskIntoConstraints = false
        confirmNewPasswordTxtField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        let width = UIScreen.main.bounds.width - 40
        let spacing: CGFloat  = 15.0
        
        textLabel.centerX(to: self.view)
        textLabel.top(to: self.view, offset: 100, relation: .equal, isActive: true)
        textLabel.width(width)
        textLabel.height(30)
        
        codeTxtField.centerX(to: self.view)
        codeTxtField.topToBottom(of: textLabel, offset: spacing, relation: .equal, isActive: true)
        codeTxtField.width(width)
        codeTxtField.height(40)
        
        newPasswordTxtField.centerX(to: self.view)
        newPasswordTxtField.topToBottom(of: codeTxtField, offset: spacing, relation: .equal, isActive: true)
        newPasswordTxtField.width(width)
        newPasswordTxtField.height(40)
        
        confirmNewPasswordTxtField.centerX(to: self.view)
        confirmNewPasswordTxtField.topToBottom(of: newPasswordTxtField, offset: spacing, relation: .equal, isActive: true)
        confirmNewPasswordTxtField.width(width)
        confirmNewPasswordTxtField.height(40)
      
        submitButton.centerX(to: self.view)
        submitButton.topToBottom(of: confirmNewPasswordTxtField, offset: spacing, relation: .equal, isActive: true)
        submitButton.width(width)
        submitButton.height(50)
        // self.view.stack(contentview, axis: .vertical, width: UIScreen.main.bounds.width - 100, height: 50, spacing: 50)
        
    }
    
    
    // MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case codeTxtField:
            newPasswordTxtField.becomeFirstResponder()
            break
        case newPasswordTxtField:
            confirmNewPasswordTxtField.becomeFirstResponder()
            break
      
        case confirmNewPasswordTxtField:
            
            textField.resignFirstResponder()
            self.disableRgisterBtn()
            return true
        default:
            return false
            
        }
        returnText()
        self.disableRgisterBtn()
        return false
    }
    func verifyConfirmPassword(){
        if(confirmNewPassword != newPassword){
            confirmNewPasswordTxtField.layer.borderColor = UIColor.red.cgColor
            confirmNewPasswordTxtField.layer.borderWidth = 1.0
            return
        }
        else{
            confirmNewPasswordTxtField.layer.borderWidth = 0.0
        }
    }
    
    func disableRgisterBtn(){
        var index : Int = 0
        for indexText in textArray{
            if(indexText.text != ""){
                index+=1
            }
            else{
                index-=1
            }
        }
        if(index == 3){
            if((confirmNewPasswordTxtField.text?.characters.count)! >= (newPasswordTxtField.text?.characters.count)!){
                if( newPasswordTxtField.text == confirmNewPasswordTxtField.text ){
                    confirmNewPasswordTxtField.layer.borderWidth = 0.0
                    submitButton.backgroundColor = Constant.defaultColor
                    submitButton.isUserInteractionEnabled = true
                }
                else{
                    confirmNewPasswordTxtField.layer.borderColor = UIColor.red.cgColor
                    confirmNewPasswordTxtField.layer.borderWidth = 1.0
                    submitButton.backgroundColor = .gray
                    submitButton.isUserInteractionEnabled = false
                }

            }
           
           
        }
        else{
            confirmNewPasswordTxtField.layer.borderWidth = 0.0
            submitButton.backgroundColor = .gray
            submitButton.isUserInteractionEnabled = false
        }
    }
    
    func returnText(){
        self.newPassword = codeTxtField.text
        self.oldPassword = newPasswordTxtField.text
        self.confirmNewPassword = confirmNewPasswordTxtField.text
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
        returnText()
        self.disableRgisterBtn()
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return true
    }
    
    
    
    //MARK: - IBAction
    
    func didTapOnSubmit(sender: UIButton) {
        self.goBackToHomePage()
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
