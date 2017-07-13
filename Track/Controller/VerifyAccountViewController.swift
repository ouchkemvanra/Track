//
//  VerifyAccountViewController.swift
//  Track
//
//  Created by ty on on 6/9/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit

class VerifyAccountViewController: UIViewController, UITextFieldDelegate {

    var textLabel: UILabel!
    var codeTextField: UITextField!
    var sendButton: UIButton!
    var code: String!
    var width : CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setTitle(text: "Verify Account")
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
        codeTextField = UITextField.init()
        codeTextField.textFieldSetup(title: "  Enter Code Here", Y: textLabel.frame.maxY + 8)
        codeTextField.delegate = self
        codeTextField.font = UIFont(name: Constant.fontName, size: 15)
        view.addSubview(codeTextField)
        
        setupSendButton()
        setupConstraint()
    }
    
    func setupText() {
        textLabel = UILabel.init(frame: CGRect(x: 8, y: 100, width: width, height: 30))
        textLabel.text = "Please enter the varification code sent to your email account"
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
        sendButton.setTitle("SUBMIT", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.backgroundColor = Constant.defaultColor
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        sendButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 20)
        sendButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(sendButton)
    }
    func setupConstraint(){
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.centerX(to: self.view)
        textLabel.top(to: self.view, offset: 100, relation: .equal, isActive: true)
        textLabel.width(width)
        //textLabel.height(30)
        
        codeTextField.centerX(to: self.view)
        codeTextField.topToBottom(of: textLabel, offset: 8, relation: .equal, isActive: true)
        codeTextField.width(width)
        codeTextField.height(40)
        
        sendButton.centerX(to: self.view)
        sendButton.topToBottom(of: codeTextField, offset: 8, relation: .equal, isActive: true)
        sendButton.width(width)
        sendButton.height(40)
        
    }
    
    
    func sendAction() {
        let nextViewcontroller = ResetPasswordViewController()
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        navigationItem.title = "Very Your Account"
        self.navigationController?.pushViewController(nextViewcontroller, animated: true)
    }
    // MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        code = codeTextField.text
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(codeTextField.text != ""){
            code = codeTextField.text
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
