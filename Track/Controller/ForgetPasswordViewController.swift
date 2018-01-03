//
//  ForgetPasswordViewController.swift
//  Track
//
//  Created by ty on on 6/9/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    var textLabel: UILabel!
    var emailTextField: UITextField!
    var sendButton: UIButton!
    var email: String!
    var width : CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setTitle(text: "Forget Password")
        width = UIScreen.main.bounds.width - 30
        setup()
       
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
       
    }
    func setup() {
        setupText()
        emailTextField = UITextField.init()
        emailTextField.textFieldSetup(title: "  Email", Y: textLabel.frame.maxY + 8)
        emailTextField.delegate = self
        emailTextField.font = UIFont(name: Constant.fontName, size: 15)
        view.addSubview(emailTextField)
        
        setupSendButton()
        setupConstraint()
    }
    
    func setupText() {
        textLabel = UILabel.init(frame: CGRect(x: 8, y: 100, width: width, height: 30))
        textLabel.text = "We'll send you a code to confirm this account is yours"
        textLabel.textColor = .gray
        textLabel.font = UIFont(name: Constant.fontName, size: 15)
       // textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.sizeToFit()
        textLabel.numberOfLines = 0
        
        view.addSubview(textLabel)
    }
    
    func setupSendButton() {
        sendButton = UIButton.init(frame: CGRect(x: 8, y:8, width: width, height: 50))
        sendButton.setTitle("SEND", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 18)
        sendButton.backgroundColor = Constant.defaultColor
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        sendButton.layer.cornerRadius = 10.0
       
        self.view.addSubview(sendButton)
    }
    func setupConstraint(){
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.centerX(to: self.view)
        textLabel.top(to: self.view, offset: 100, relation: .equal, isActive: true)
        textLabel.width(width)
        //textLabel.height(30)
        
        emailTextField.centerX(to: self.view)
        emailTextField.topToBottom(of: textLabel, offset: 8, relation: .equal, isActive: true)
        emailTextField.width(width)
        emailTextField.height(40)
        
        sendButton.centerX(to: self.view)
        sendButton.topToBottom(of: emailTextField, offset: 8, relation: .equal, isActive: true)
        sendButton.width(width)
        sendButton.height(40)
    
    }
    
    func sendAction() {
        let nextViewcontroller = VerifyAccountViewController()
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        self.navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
    
    
    // MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email = emailTextField.text
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(emailTextField.text != ""){
            email = emailTextField.text
        }
        view.endEditing(true)
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
