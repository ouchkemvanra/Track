//
//  Login.swift
//  Track
//
//  Created by ty on on 5/16/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import TinyConstraints

class Login: UIViewController, UITextFieldDelegate, Anime {

    var txfName: login_text!
    var txfPasword: login_text!
    var lblLogin: UILabel!
    var screen = UIScreen.main.bounds
    var loadingView : UIView!
    var loginView: UIView!
    var loginBtn: login_button!
    var forgetPasswordButton: UIButton!
    var registerButton: UIButton!
    var errorLabel : error!
    
    var name: String!
    var password: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupNavigationColor()
        self.setTitle(text: "Login")
       
        if self.revealViewController() != nil{
            
            self.setupMenuGestureRecognizer()
            
            navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: revealViewController, action: #selector(self.revealViewController().revealToggle(_:))), animated: true)
            
        }

        self.view.backgroundColor = Constant.defaultColor
        setupLoadingView()
       
        loadingView.removeFromSuperview()
        setupLbllogin()
        setupTxfName()
        setupTxfPassword()
        setupLoginButton()
        setupForgetPasswordButton()
        setupRegiseterButton()
        setupError()
            //self.navigationController?.setupNavigationColor()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Constant.defaultColor
       
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: First Setup of Login Label
    func setupLbllogin(){
        lblLogin = UILabel.init(frame: CGRect(x: screen.width/2 - 40, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
       // lblLogin.text = "Login"
        lblLogin.textColor = .white
        lblLogin.textAlignment = .center
        lblLogin.font = UIFont(name: Constant.fontName, size: 25)
        self.view.addSubview(lblLogin)
        setupLblLoginConstraint()
    }
    
    // MARK: First Setup of User Name Text Field
    func setupTxfName(){
        txfName = login_text.init(frame: CGRect(x: 20, y: lblLogin.frame.origin.y + 30, width: 100, height: 100))
        txfName.placeholder = "  Email"
        txfName.delegate = self
        txfName.borderStyle = .none
       // txfName.layer.borderWidth = 1.0
       // txfName.layer.cornerRadius = 10
        txfName.roundCorners([.topLeft, .topRight], radius: 20)
//        txfName.layoutIfNeeded()
        txfName.layer.borderColor = Constant.textBorder.cgColor
        txfName.backgroundColor = UIColor.white
        txfName.font = UIFont(name: Constant.fontName, size: 15)
        self.view.addSubview(txfName)
        setupNameTextFieldConstraint()
        
    }
    // MARK: Setup of Login Button
    func setupLoginButton(){
        loginBtn = login_button.init(frame: CGRect(x: 0, y: txfPasword.frame.origin.y + 58, width: self.view.frame.size.width - 50, height: 60))
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = UIColor.orange
        loginBtn.layer.cornerRadius = 8.0
        loginBtn.titleLabel?.font = UIFont(name: Constant.fontName, size: 25)
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        setupLoginButtonConstraint()
    }
    
  

    // MARK: First Setup of Password Text Field
    func setupTxfPassword(){
        txfPasword = login_text.init(frame: CGRect(x: 20, y: txfName.frame.origin.y + 30, width: 100, height: 100))
        txfPasword.placeholder = "  Password"
        txfPasword.isSecureTextEntry = true
        txfPasword.delegate = self
        txfPasword.borderStyle = .none
       // txfPasword.layer.borderWidth = 1.0
        //txfPasword.layer.cornerRadius = 10
        txfPasword.font = UIFont(name: Constant.fontName, size: 15)
        txfPasword.roundCorners([.bottomRight, .bottomLeft], radius: 20)
//        txfPasword.layoutIfNeeded()
        txfPasword.layer.borderColor = Constant.textBorder.cgColor
        txfPasword.backgroundColor = UIColor.white
        self.view.addSubview(txfPasword)
        
        setupPasswordTextFieldConstraint()
    }
    
      // MARK: First Setup of Forget Password Button
    func setupForgetPasswordButton() {
        forgetPasswordButton = UIButton.init(frame: CGRect(x: 20, y: loginBtn.frame.origin.y + 58, width: 100, height: 30))
        forgetPasswordButton.setTitle("Forget Password?", for: .normal)
        forgetPasswordButton.setTitleColor(.white, for: .normal)
        forgetPasswordButton.contentHorizontalAlignment = .left
        forgetPasswordButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 18)
        forgetPasswordButton.addTarget(self, action: #selector(forgetPasswordAciton), for: .touchUpInside)
        self.view.addSubview(forgetPasswordButton)
        setupForgetPasswordButtonConstraint()
        
    }
    
      // MARK: First Setup of Register Button
    func setupRegiseterButton() {
        registerButton = UIButton.init(frame: CGRect(x: forgetPasswordButton.frame.origin.x + 100, y: loginBtn.frame.origin.y + 58, width: 100, height: 30))
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.contentHorizontalAlignment = .right
        registerButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 18)
        registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        self.view.addSubview(registerButton)
        setupRegisterButtonConstraint()
    }
    func setupError() {
        errorLabel = error.init(frame: CGRect(x: 20, y: registerButton.frame.maxY + 15, width: UIScreen.main.bounds.width - 20, height: 30))
        errorLabel.text = "You have enter invalid email!"
        errorLabel.textColor = .white
        errorLabel.alpha = 0.0
        errorLabel.textAlignment = .center
        errorLabel.adjustsFontSizeToFitWidth = true
       
        view.addSubview(errorLabel)
        
        setupErrorLabelConstraint()
    }
    
    func registerAction() {
        let nextViewcontroller = RegisterViewController()
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        self.navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
    
    func forgetPasswordAciton() {
        let nextViewcontroller = ForgetPasswordViewController()
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage.init(named: "back")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(named: "back")
      
        navigationItem.backBarButtonItem = backbutton
       
      
        self.navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
    
    func loginAction() {
        returnText()
       
        if(name != "vanra")&&(password != "123"){
            if(name == "" || password == ""){
                self.errorLabel.text = "Username or Password can't be empty"
            }
            else{
                self.errorLabel.text = "You have entered invalid username and password"
            }
            //self.errorLabel.text = "You have entered invalid username and password"
            self.errorLabel.flash()
            self.errorLabel.jitter()
            self.txfPasword.jitter()
            self.txfName.jitter()
            self.loginBtn.jitter()
        }
        else{
           
            
            self.goBackToHomePage()
            
        
        }
       
    }
    
    
    
    // MARK: Setup of Constraint Login Label
    func setupLblLoginConstraint() {
        lblLogin.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: lblLogin, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 60)
        let centerConstraint = NSLayoutConstraint(item: lblLogin, attribute:.centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: lblLogin, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: UIScreen.main.bounds.width - 40)
        let heightConstraint = NSLayoutConstraint(item: lblLogin, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        view.addConstraints([topConstraint,centerConstraint,widthConstraint,heightConstraint])
    }
    
     // MARK: Setup of Constraint User Name Text Field
    func setupNameTextFieldConstraint(){
        txfName.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: txfName, attribute: .top, relatedBy: .equal, toItem: lblLogin, attribute: .bottom, multiplier: 1, constant: 48)
        let centerConstraint = NSLayoutConstraint(item: txfName, attribute:.centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: txfName, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: screen.width - 40)
        let heightConstraint = NSLayoutConstraint(item: txfName, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        view.addConstraints([topConstraint,centerConstraint,widthConstraint,heightConstraint])
    }
    
       // MARK: Setup of Constraint Password Text Field
    func setupPasswordTextFieldConstraint(){
        txfPasword.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: txfPasword, attribute: .top, relatedBy: .equal, toItem: txfName, attribute: .bottom, multiplier: 1, constant: 1)
        let centerConstraint = NSLayoutConstraint(item: txfPasword, attribute:.centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: txfPasword, attribute: .width, relatedBy: .equal, toItem: txfName, attribute: .width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: txfPasword, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        view.addConstraints([topConstraint,centerConstraint,widthConstraint,heightConstraint])
    }
    
    // MARK: First Setup of Password Text Field
    func setupLoginButtonConstraint(){
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: loginBtn, attribute: .top, relatedBy: .equal, toItem: txfPasword, attribute: .bottom, multiplier: 1, constant: 45)
        let centerConstraint = NSLayoutConstraint(item: loginBtn, attribute:.centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: loginBtn, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: -40)
        let heightConstraint = NSLayoutConstraint(item: loginBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        view.addConstraints([topConstraint,centerConstraint,widthConstraint,heightConstraint])
    }
    
    func setupForgetPasswordButtonConstraint(){
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: forgetPasswordButton, attribute: .top, relatedBy: .equal, toItem: loginBtn, attribute: .bottom, multiplier: 1, constant: 10)
        let centerConstraint = NSLayoutConstraint(item: forgetPasswordButton, attribute:.leading, relatedBy: .equal, toItem: loginBtn, attribute: .leading, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: forgetPasswordButton, attribute: .width, relatedBy: .equal, toItem: loginBtn, attribute: .width, multiplier: 0.5, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: forgetPasswordButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        view.addConstraints([topConstraint,centerConstraint,widthConstraint,heightConstraint])
    }
    func setupRegisterButtonConstraint(){
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: loginBtn, attribute: .bottom, multiplier: 1, constant: 10)
        let centerConstraint = NSLayoutConstraint(item: registerButton, attribute:.trailing, relatedBy: .equal, toItem: loginBtn, attribute: .trailing, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        view.addConstraints([topConstraint,centerConstraint,widthConstraint,heightConstraint])
    }
    
    func setupErrorLabelConstraint(){
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: txfPasword, attribute: .bottom, multiplier: 1, constant: 0)
        let centerConstraint = NSLayoutConstraint(item: errorLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: errorLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: -20)
        let heightConstraint = NSLayoutConstraint(item: errorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        view.addConstraints([topConstraint,centerConstraint,widthConstraint,heightConstraint])
    }
    
    // MARK: Setup of Loading Indicator
    func setupLoadingView() {
        loadingView = UIView.init(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height))
        let loading = UIActivityIndicatorView.init(frame: CGRect(x: screen.width/2 - 20, y: screen.height/2 - 20, width: 40, height: 40))
        loading.startAnimating()
        loading.color = UIColor.gray
        loadingView.addSubview(loading)
        self.view.addSubview(loadingView)
    }
    
    
    // MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txfName:
            returnText()
            txfPasword.becomeFirstResponder()
            break
        case txfPasword:
            returnText()
            textField.resignFirstResponder()
            return true
        default:
          return false
        }
        return false
    }
    
    func returnText(){
        self.name = txfName.text
        self.password = txfPasword.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        returnText()
        view.endEditing(true)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.txfName.roundCorners([.topRight, .topLeft], radius: 10)
        self.txfPasword.roundCorners([.bottomLeft, .bottomRight], radius: 10)
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
// MARK: Extension
extension UINavigationController{
    
    // MARK: Setup Navigation Color
    func setupNavigationColor(){
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = Constant.defaultColor
        self.navigationBar.titleTextAttributes = [NSFontAttributeName : (UIFont(name: "HelveticaNeue-Thin", size: 22))!, NSForegroundColorAttributeName: UIColor.white]
        
        
    }
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
