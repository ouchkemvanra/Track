//
//  RegisterViewController.swift
//  Track
//
//  Created by ty on on 6/7/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    var registerLabel: UILabel!
    var emailTxtField: UITextField!
    var nameTxtField: UITextField!
    var passwordTxtField: UITextField!
    var doctorCodeTxtField: UITextField!
    var registerButton: UIButton!
    var alreadyHaveAccountButton: UIButton!
    
    var textediting: Bool = false
    var name: String!
    var email: String!
    var password: String!
    var doctorCode: String!
    
    var textArray : [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setTitle(text: "Register")
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          self.view.backgroundColor = .white
        self.view.frame.origin.y = 0
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: Notification.Name.UIKeyboardWillHide, object: self.view.window)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.frame.origin.y = 0
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
        
    }
    func setup(){
        setupRegisterLabel()
       // setupEmail()
       // setupName()
    
        emailTxtField = UITextField.init()
        emailTxtField.textFieldSetup(title: "  Eamil", Y: registerLabel.frame.maxY + 8)
        emailTxtField.delegate = self
        emailTxtField.returnKeyType = .next
        emailTxtField.autocorrectionType = .no
        
        nameTxtField = UITextField.init()
        nameTxtField.textFieldSetup(title: "  Name", Y: emailTxtField.frame.maxY + 8)
        nameTxtField.delegate = self
        nameTxtField.returnKeyType = .next
        nameTxtField.autocorrectionType = .no
        
        passwordTxtField = UITextField.init()
        passwordTxtField.textFieldSetup(title: "  Password", Y: nameTxtField.frame.maxY + 8)
        passwordTxtField.delegate = self
        passwordTxtField.returnKeyType = .next
        passwordTxtField.isSecureTextEntry = true
        passwordTxtField.autocorrectionType = .no
        
        doctorCodeTxtField = UITextField.init()
        doctorCodeTxtField.textFieldSetup(title: "  Dr. Code", Y: passwordTxtField.frame.maxY + 8)
        doctorCodeTxtField.delegate = self
        doctorCodeTxtField.returnKeyType = .done
        doctorCodeTxtField.autocorrectionType = .no
        
        
        
        self.view.addSubview(emailTxtField)
        self.view.addSubview(nameTxtField)
        self.view.addSubview(passwordTxtField)
        self.view.addSubview(doctorCodeTxtField)
        
        setupRegisterButton()
        setupAlreadyHaveAccountButton()
        
        setupconstraint()
        textArray = [emailTxtField, nameTxtField, passwordTxtField, doctorCodeTxtField] as [UITextField]
    }
    func setupRegisterLabel(){
        registerLabel = UILabel.init(frame: CGRect(x: 8, y: 8, width: 100, height: 30))
        registerLabel.text = "Register"
        registerLabel.textColor = UIColor.lightGray
        registerLabel.textAlignment = .center
        registerLabel.font = UIFont(name: Constant.fontName, size: 25)
        
        
        self.view.addSubview(registerLabel)
    }
    func setupRegisterButton() {
        registerButton = UIButton.init(frame: CGRect(x: 8, y: doctorCodeTxtField.frame.maxY + 15, width: doctorCodeTxtField.frame.width, height: 50))
        registerButton.setTitle("REGISTER", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = Constant.defaultColor
        registerButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 20)
        registerButton.layer.cornerRadius = 10.0
        self.disableRgisterBtn()
        self.view.addSubview(registerButton)
    }
    func setupAlreadyHaveAccountButton(){
        alreadyHaveAccountButton = UIButton.init(frame: CGRect(x: 8, y: registerButton.frame.maxY, width: UIScreen.main.bounds.width/2, height: 40))
        alreadyHaveAccountButton.addTarget(self, action: #selector(alreadyHaveAccount), for: .touchUpInside)
        alreadyHaveAccountButton.setTitle("Already have account (Log In)", for: .normal)
        alreadyHaveAccountButton.setTitleColor(.gray, for: .normal)
        alreadyHaveAccountButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 15)
        alreadyHaveAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        alreadyHaveAccountButton.contentHorizontalAlignment = .right
        self.view.addSubview(alreadyHaveAccountButton)
    }
    
    func alreadyHaveAccount(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupconstraint(){
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTxtField.translatesAutoresizingMaskIntoConstraints = false
        nameTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        doctorCodeTxtField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        let width = UIScreen.main.bounds.width - 40
        let spacing: CGFloat  = 15.0
        
        registerLabel.centerX(to: self.view)
        registerLabel.top(to: self.view, offset: 100, relation: .equal, isActive: true)
        registerLabel.width(width)
        registerLabel.height(30)
        
        emailTxtField.centerX(to: self.view)
        emailTxtField.topToBottom(of: registerLabel, offset: spacing, relation: .equal, isActive: true)
        emailTxtField.width(width)
        emailTxtField.height(40)
        
        nameTxtField.centerX(to: self.view)
        nameTxtField.topToBottom(of: emailTxtField, offset: spacing, relation: .equal, isActive: true)
        nameTxtField.width(width)
        nameTxtField.height(40)
        
        passwordTxtField.centerX(to: self.view)
        passwordTxtField.topToBottom(of: nameTxtField, offset: spacing, relation: .equal, isActive: true)
        passwordTxtField.width(width)
        passwordTxtField.height(40)
        
        doctorCodeTxtField.centerX(to: self.view)
        doctorCodeTxtField.topToBottom(of: passwordTxtField, offset: spacing, relation: .equal, isActive: true)
        doctorCodeTxtField.width(width)
        doctorCodeTxtField.height(40)
        
        registerButton.centerX(to: self.view)
        registerButton.topToBottom(of: doctorCodeTxtField, offset: spacing, relation: .equal, isActive: true)
        registerButton.width(width)
        registerButton.height(40)
        
        alreadyHaveAccountButton.trailing(to: registerButton)
        alreadyHaveAccountButton.topToBottom(of: registerButton, offset: 10, relation: .equal, isActive: true)
        alreadyHaveAccountButton.width(width*0.7)
        alreadyHaveAccountButton.height(40)
       // self.view.stack(contentview, axis: .vertical, width: UIScreen.main.bounds.width - 100, height: 50, spacing: 50)
       
    }
    

    
    
    // MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTxtField:
            nameTxtField.becomeFirstResponder()
            break
        case nameTxtField:
            passwordTxtField.becomeFirstResponder()
            break
        case passwordTxtField:
            doctorCodeTxtField.becomeFirstResponder()
            break
        case doctorCodeTxtField:
            
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
        if(index == 4){
            
            if((doctorCodeTxtField.text?.characters.count)! >= (passwordTxtField.text?.characters.count)!){
                if(doctorCodeTxtField.text == passwordTxtField.text){
                    
                    doctorCodeTxtField.layer.borderWidth = 0.0
                    registerButton.backgroundColor = Constant.defaultColor
                    registerButton.isUserInteractionEnabled = true
                }
                else{
                    doctorCodeTxtField.layer.borderWidth = 1.0
                    doctorCodeTxtField.layer.borderColor = UIColor.red.cgColor
                    registerButton.backgroundColor = .gray
                    registerButton.isUserInteractionEnabled = false
                }
                
            }
            else{
                registerButton.backgroundColor = .gray
                registerButton.isUserInteractionEnabled = false
                
            }
         
           
        }
        else{
           registerButton.backgroundColor = .gray
           registerButton.isUserInteractionEnabled = false
        }
    }
    
    func returnText(){
        self.email = emailTxtField.text
        self.name = nameTxtField.text
        self.password = passwordTxtField.text
        self.doctorCode = doctorCodeTxtField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
        returnText()
        if((doctorCodeTxtField.text?.characters.count)! >= (passwordTxtField.text?.characters.count)!){
            self.disableRgisterBtn()
        }
        
      
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return true
    }

    
    //MARK: - Hide / Show Keyboard
    
    func keyboardWillShow(sender: NSNotification) {
        
        let userInfo = sender.userInfo
        
        
        let keyboardSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as? CGRect)!
        let offset: CGSize = (userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        print(offset.height)
        print(keyboardSize.height)
        if(self.textediting == false){
            print("Show")
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height - 130
            })
        }
        
        self.textediting = true
    }
    
    //Push View down when keyboard disappear
    func keyboardWillHide(sender: NSNotification){
        let userInfo = sender.userInfo
        
        
        let keyboardSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as? CGRect)!
        let offset: CGSize = (userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        print(offset.height)
        print(keyboardSize.height)
        
        print("Hide")
        if(self.textediting == true){
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - 130
            })
        }
        self.textediting = false
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

extension UITextField{
    func textFieldSetup(title: String, Y: CGFloat){
       self.frame = CGRect(x: 8, y: Y, width: UIScreen.main.bounds.size.width - 100, height: 50)
        self.placeholder = title
        self.borderStyle = .none
        self.font = UIFont(name: Constant.fontName, size: 15)
        self.backgroundColor = Constant.textBackground
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = Constant.textBorder.cgColor
        self.layer.borderWidth = 1.0
    }
}
extension UIViewController{
    func setTitle(text: String) {
        let title = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        title.text = text
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont(name: Constant.fontName, size: 20)
      
        self.navigationItem.titleView = title
    }
}
