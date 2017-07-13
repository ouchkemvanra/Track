//
//  UserProfileTableViewCell.swift
//  Track
//
//  Created by ty on on 6/30/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
protocol TextFieldInTableViewCellDelegate {
    func textFieldInTableViewCell(didSelect cell:UserProfileTableViewCell)
    func textFieldInTableViewCell(cell:UserProfileTableViewCell, editingChangedInTextField newText:String)
}
class UserProfileTableViewCell: UITableViewCell, UITextFieldDelegate{
    var inforTextField: UITextField!
    var icons: UIImageView!
    var delegate: TextFieldInTableViewCellDelegate?
    var devider: UIView!
    var picker: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    func setData(icon: UIImage, title: String){
        self.inforTextField.placeholder = title
        self.icons.image = icon
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        setupIcon()
        setupTitles()
        //setupDivider()
        Constraints()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupTitles(){
        inforTextField = UITextField.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        inforTextField.textAlignment = .left
        inforTextField.font = UIFont(name: Constant.fontName, size: 13)
        inforTextField.delegate = self
        inforTextField.inputView?.backgroundColor = .white
        inforTextField.inputAccessoryView?.backgroundColor = .white
        inforTextField.returnKeyType = .done
        inforTextField.addTarget(self, action: #selector(UserProfileTableViewCell.textFieldValueChanged(_:)), for:UIControlEvents.editingChanged)
        
        self.contentView.addSubview(inforTextField)
        
    }
    func setupIcon(){
        icons = UIImageView.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        icons.contentMode = .scaleAspectFit
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        icons.addGestureRecognizer(gesture)
        self.contentView.addSubview(icons)
    }
    func setupDivider(){
        self.devider = UIView.init(frame: CGRect.zero)
        self.devider.backgroundColor = .black
        
        self.contentView.addSubview(self.devider)
    }
    func dismiss(){
        self.endEditing(true)
    }
    func Constraints(){
        inforTextField.translatesAutoresizingMaskIntoConstraints = false
        icons.translatesAutoresizingMaskIntoConstraints = false
        //devider.translatesAutoresizingMaskIntoConstraints = false
        
        icons.leading(to: self.contentView, offset: 32, relation: .equal, isActive: true)
        icons.centerY(to: self.contentView)
        icons.width(15)
        icons.height(15)
        
        inforTextField.leadingToTrailing(of: icons, offset: 32, relation: .equal, isActive: true)
        inforTextField.centerY(to: self.contentView)
        inforTextField.trailing(to: self.contentView, offset: -8, relation: .equal, isActive: true)
        inforTextField.height(44)
        self.separatorInset.left = icons.frame.size.width - 20
//        devider.leading(to: inforTextField)
//        devider.trailing(to: inforTextField)
//        devider.topToBottom(of: inforTextField)
//        devider.height(2)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        textFieldValueChanged(textField)
        return true
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldInTableViewCell(didSelect: self)
       
        return true
    }
    
    func addPicker(){
        self.picker = UIPickerView(frame: CGRect.zero)
        self.picker.backgroundColor = .white
        
    }
    
    
}

extension UserProfileTableViewCell {
    
    func didSelectCell() {
        print("Did Select")
        inforTextField.becomeFirstResponder()
        delegate?.textFieldInTableViewCell(didSelect: self)
    }
    
    func textFieldValueChanged(_ sender: UITextField) {
        print("Hello")
        if let text = sender.text {
            delegate?.textFieldInTableViewCell(cell: self, editingChangedInTextField: text)
        }
    }
}
