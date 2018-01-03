//
//  UserProfileViewController.swift
//  Track
//
//  Created by ty on on 6/29/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import ImagePicker
class UserProfileViewController: UIViewController, ImagePickerDelegate {
    var topView: UIView!
    var bottomView: UIView!
    var tableView: UITableView!
    var coverImage: UIImageView!
    var profileImage: UIImageView!
    var cameraButton: UIButton!
    let size = UIScreen.main.bounds
    var name: UILabel!
    var age: UILabel!
    var gender: UILabel!
    var isChanged: Bool = false
    var country: String!
    var countryPicker: UIPickerView!
    var languagePicker: UIPickerView!
    var genderPicker: UIPickerView!
    var index : IndexPath!
    var countries : [String]! = Constant.countries
    var languages : [String]! = Constant.languages
    var profilePhoto: UIImage!
    var profileCountry: String!
    var profileNationality: String!
    var prfileLanguage: String!
    var profileEmail: String!
    var profilePhnoneNumber: String!
    var profileAddress: String!
    var profileLanguage: String!
    var isOnProfileEdit: Bool = false
    var nameTextField: UITextField!
    var ageTextField: UITextField!
    var genderTextField: UITextField!
    var genderString = ["Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = .white
        self.navigationController?.setupNavigationColor()
        self.setTitle(text: "User Profile")
         self.setupView()
        if self.revealViewController() != nil{
            
            self.setupMenuGestureRecognizer()
            
            navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: revealViewController, action: #selector(self.revealViewController().revealToggle(_:))), animated: true)
            navigationItem.setRightBarButton(UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveAction)), animated: true)
            navigationItem.rightBarButtonItem?.tintColor = .lightGray
        }
        
        // Do any additional setup after loading the view.
    }
    
    func saveAction() {
        if(self.isChanged == false){
            
        }
        else{
            
//            if let rightbar = self.navigationItem.rightBarButtonItem{
//                rightbar.tintColor = .lightGray
//                self.isChanged = false
//            }
            print("Changed")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: Notification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    
    //MARK: - Setup View
    
    func setupView(){
        self.setupTopView()
        self.setupCover()
        self.setupProfileImage()
        self.setupCameraButton()
        self.setupNameLabel()
        self.setupAgeLabel()
        self.setupGenderLabel()
        self.setupBottomView()
        self.setupTableView()
    }
    //View for Top and Bottom
    func setupTopView(){
        self.topView = UIView.init(frame: CGRect.zero)
        self.topView.backgroundColor = .white
        
        self.view.addSubview(topView)
        self.setupTopViewConstraint()
    }
    
    func setupBottomView(){
        self.bottomView = UIView.init(frame: CGRect.zero)
        self.bottomView.backgroundColor = .white
        
        self.view.addSubview(bottomView)
        self.setupBottomViewConstraint()
    }

    // Constraint for Top and Bottom view
    
    func setupTopViewConstraint(){
        self.topView.translatesAutoresizingMaskIntoConstraints = false
        
        self.topView.centerX(to: self.view)
        self.topView.top(to: self.view)
        self.topView.width(to: self.view)
        self.topView.height(size.height/2 - 80)
    }
    
    func setupBottomViewConstraint(){
        
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomView.centerX(to: self.view)
        self.bottomView.topToBottom(of: self.topView)
        self.bottomView.width(to: self.view)
        self.bottomView.bottom(to: self.view)
    }
    // MARK: - Setup Component for Top View
    func setupCover(){
        self.coverImage = UIImageView.init(frame: CGRect.zero)
        self.coverImage.contentMode = .scaleAspectFill
        self.coverImage.image = UIImage.init(named: "profileImage")
        self.coverImage.clipsToBounds = true
        self.coverImage.isUserInteractionEnabled = true
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coverImage.addSubview(blurEffectView)
        self.topView.addSubview(coverImage)
        self.setupCoverConstraint()
    }
    
    func setupProfileImage(){
        self.profileImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        self.profileImage.image = UIImage.init(named: "profileImage")
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.profileImage.layer.borderWidth = 2.0
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        
        self.profileImage.clipsToBounds = true
        self.profileImage.isUserInteractionEnabled = true
       
        self.view.addSubview(profileImage)
        self.setupProfileConstraint()
        
       
        
    }
    func setupCameraButton(){
        self.cameraButton = UIButton.init(frame: CGRect.zero)
        self.cameraButton.setImage(UIImage.init(named: "photo-camera (1)"), for: .normal)
        self.cameraButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.cameraButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
      
        self.profileImage.addSubview(self.cameraButton)
     
        self.setupCameraButtonConstraint()
    }
   
    
    func setupNameLabel(){
        self.name = UILabel.init(frame: CGRect.zero)
        self.name.textAlignment = .center
        self.name.font = UIFont(name: Constant.fontName, size: 16)
        self.name.text = "Vanra"
        self.name.textColor = .white
        self.name.isUserInteractionEnabled = true
        self.name.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnName)))
        self.view.addSubview(self.name)
        self.setupNameLabelConstraint()
    }
    func setupAgeLabel(){
        self.age = UILabel.init(frame: CGRect.zero)
        self.age.textAlignment = .center
        self.age.font = UIFont(name: Constant.fontName, size: 16)
        self.age.text = "24"
        self.age.textColor = .white
        self.age.isUserInteractionEnabled = true
         self.age.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnAge)))
        self.view.addSubview(self.age)
        self.setupAgeLabelConstraint()
    }
    func setupGenderLabel(){
        self.gender = UILabel.init(frame: CGRect.zero)
        self.gender.textAlignment = .center
        self.gender.font = UIFont(name: Constant.fontName, size: 16)
        self.gender.text = "Male"
        self.gender.textColor = .white
        self.gender.isUserInteractionEnabled = true
        self.gender.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnGender)))
        self.view.addSubview(self.gender)
        setupGenderConstraint()
       
    }

    
    
    //Constraint
    
    func setupGenderConstraint(){
        self.gender.translatesAutoresizingMaskIntoConstraints = false
        
        self.gender.centerX(to: self.coverImage, offset: 30, isActive: true)
        self.gender.topToBottom(of: self.name, offset: 0, relation: .equal, isActive: true)
        self.gender.height(30)
        self.gender.width(60)
    }
    func setupCoverConstraint(){
        self.coverImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.coverImage.center(in: self.topView)
        self.coverImage.width(to: self.topView)
        self.coverImage.height(to: self.topView)
        
    }
    
    func setupProfileConstraint(){
        self.profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.profileImage.centerX(to: self.topView)
        self.profileImage.top(to: self.topView, offset: 20, relation: .equal, isActive: true)
        
        self.profileImage.width(150)
        self.profileImage.height(150)
    }
    
    func setupCameraButtonConstraint(){
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.cameraButton.width(to: self.profileImage)
        self.cameraButton.height(30)
        self.cameraButton.bottom(to: self.profileImage)
        self.cameraButton.centerX(to: self.profileImage)
    }
    
    func setupNameLabelConstraint(){
        self.name.translatesAutoresizingMaskIntoConstraints = false
        
        self.name.centerX(to: self.coverImage)
        self.name.topToBottom(of: self.profileImage, offset: 10, relation: .equal, isActive: true)
        self.name.height(30)
        self.name.width(to: self.coverImage)
    }
    
    func setupAgeLabelConstraint() {
        self.age.translatesAutoresizingMaskIntoConstraints = false
        
        self.age.centerX(to: self.coverImage, offset: -30, isActive: true)
        self.age.topToBottom(of: self.name, offset: 0, relation: .equal, isActive: true)
        self.age.height(30)
        self.age.width(60)
    }
    
    // MARK: - Setup Component for BottomView
    // Setup TableView
   
    func setupTableViewConstraint() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.center(in: self.bottomView)
        self.tableView.height(to: self.bottomView)
        self.tableView.width(to: self.bottomView)
    }
    
    
    // MARK: - Action
    func configurationTextField(textField: UITextField!){
        textField.text = self.name.text
        if (textField) != nil{
            self.nameTextField = textField!
        }
    }
    func configurationAgeTextField(textField: UITextField!){
        textField.text = self.age.text
        if (textField) != nil{
            self.ageTextField = textField!
            self.ageTextField.keyboardType = .numberPad
        }
    }
    func didTapOnName(){
        print("Hello")
        self.isOnProfileEdit = true
        let alert = UIAlertController(title: "Change Name", message: "Type in a new name", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            print("User click Ok button")
            print(self.nameTextField.text!)
        
            self.view.endEditing(true)
            self.name.text = self.nameTextField.text!
            self.name.reloadInputViews()
            self.isOnProfileEdit = false
           
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: {
            print("completion block")
            self.isOnProfileEdit = false
        })
       // let updateLogViewController = UpdateUserProfileViewController()
//        
//        let modalViewController = UpdateUserProfileViewController()
//        modalViewController.delegate = self
//        modalViewController.modalPresentationStyle = .overFullScreen
//        
//        UIView.animate(withDuration: 0.2, animations: {
//             self.present(modalViewController, animated: true, completion: nil)
//        })
        
      

    }
    func didTapOnAge(){
        print("Hello")
        self.isOnProfileEdit = true
        let alert = UIAlertController(title: "Change Name", message: "Type in a new name", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: configurationAgeTextField)
        
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            print("User click Ok button")
            print(self.ageTextField.text!)
            
            self.view.endEditing(true)
            self.age.text = self.ageTextField.text!
            self.age.reloadInputViews()
            self.isOnProfileEdit = false
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: {
            print("completion block")
            self.isOnProfileEdit = false
        })
        
        
        
        
    }
    func getDefaultPickerValue() -> Int{
        if(gender.text == "Male"){
            return 0
        }
        else{
            return 1
        }
    }
    func didTapOnGender(){
        print("Hello")
        self.isOnProfileEdit = true
        let alertView = UIAlertController(
            title: "Select item from list",
            message: "\n\n\n\n\n\n\n\n\n",
            preferredStyle: .alert)
        
        self.genderPicker = UIPickerView(frame:
            CGRect(x: -50, y: 50, width: 310, height: 162))
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.selectRow(getDefaultPickerValue(), inComponent: 0, animated: false)
        // comment this line to use white color
        genderPicker.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        alertView.view.addSubview(genderPicker)
        let canceelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction)in
            
            self.isOnProfileEdit = false
            
        })
        let action = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
          
            self.isOnProfileEdit = false
            
        })
        alertView.addAction(canceelAction)
        alertView.addAction(action)
        present(alertView, animated: true, completion: { _ in
            self.genderPicker.frame.size.width = alertView.view.frame.size.width + 50
            self.isOnProfileEdit = false
        })
        
        

        
        
        
    }
    func cancelTap(){
        print("zzz")
        self.dismiss(animated: true, completion: nil)
    }
    func pressButton(){
        print("Hello")
        var configuration = Configuration()
        configuration.bottomContainerColor = configuration.gallerySeparatorColor
        
        let imagePickerController = ImagePickerController()
        imagePickerController.configuration = configuration
        
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
        //present(imagePickerController, animated: true, completion: nil)
        //let navi = UINavigationController(rootViewController: imagePickerController)
        imagePickerController.navigationController?.setupNavigationColor()
        self.present(imagePickerController, animated: true, completion: nil)
        //print(self.imagess.count)
    }
    
    // MARK: - ImagePickerDelegateMethod
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        print("Hello")
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        print("zzz")
        
        // let totalImages = images
       
        self.dismiss(animated: true, completion: nil)
        if(images != nil){
        self.profileImage.image = images[0]
        self.coverImage.image = images[0]
        }
        
        
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
        print("dfdsfsf")
       self.dismiss(animated: true, completion: nil)
        
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

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    func setupTableView() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = .black
        self.tableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UserProfileTableViewCell.self))
        let gesture = UITapGestureRecognizer(target: self, action: #selector(UserProfileViewController.endEditing))
        self.tableView.addGestureRecognizer(gesture)
        self.view.addSubview(self.tableView)
        self.setupTableViewConstraint()
    }
    func endEditing() {
        tableView.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        let titles = UILabel.init(frame: CGRect(x: 8, y: 8, width: tableView.frame.size.width - 20, height: 40))
       
        titles.textColor = .gray
        titles.font = UIFont(name: Constant.fontName, size: 13)
        titles.textColor = Constant.defaultColor
        header.addSubview(titles)
        header.backgroundColor = .white
        
        switch section {
        case 0:
            titles.text = "Personal Information"
        default:
            titles.text = "Contact Information"
        }
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UserProfileTableViewCell.self)) as! UserProfileTableViewCell
       
        cell.setData(icon: Constant.profileInforIcon[indexPath.section][indexPath.row], title: Constant.profileInforPlacholder[indexPath.section][indexPath.row])
        cell.delegate = self
       
        let toolbar = self.addToolbar()
        if(indexPath.section == 0){
            switch indexPath.row {
            case 0:
                self.countryPicker = self.addPicker(title: "Country")
                cell.inforTextField.inputView = countryPicker
                cell.inforTextField.inputView?.backgroundColor = .white
                cell.inforTextField.inputAccessoryView = toolbar
                break
            case 2:
                self.languagePicker = self.addPicker(title: "Language")
                cell.inforTextField.inputView = languagePicker
                cell.inforTextField.inputAccessoryView = toolbar
                break
            default:
                break
            }
        }
         //cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        
        return cell
    }
    
    func addPicker(title: String) -> UIPickerView{
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect.zero)
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        let labelWidth = self.view.frame.size.width
        let label: UILabel = UILabel.init(frame: CGRect(x: picker.frame.origin.x, y: 0, width: labelWidth, height: 44))
        label.backgroundColor = .white
        label.font = label.font.withSize(20)
        label.text = title
        label.textAlignment = .center

        picker.addSubview(label)
        return picker

    }
    func addToolbar() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = Constant.defaultColor
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePickerAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPickerView))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    func donePickerAction(){
        print("Done")
        self.view.endEditing(true)
    }
    func cancelPickerView() {
        print("cancel")
        self.view.endEditing(true)
        
        
        
    }
    
    
    // MARK - PickerView Delegate Method
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let rows : Int
        switch pickerView {
        case countryPicker:
            rows = self.countries.count
        case languagePicker:
            rows = self.languages.count
        case genderPicker:
            rows = self.genderString.count
        default:
            rows = 1
        }
        return rows
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case countryPicker:
            return self.countries[row]
        case languagePicker:
            return self.languages[row]
        case genderPicker:
            return self.genderString[row]
        default:
            return "title"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        
       
        
        switch pickerView {
        case countryPicker:
            print("Country at: \(row)")
             let cell = tableView.cellForRow(at: self.index) as! UserProfileTableViewCell
            cell.inforTextField.text = countries[row]
            self.profileCountry = countries[row]
            
        case languagePicker:
             print("Language at: \(row)")
              let cell = tableView.cellForRow(at: self.index) as! UserProfileTableViewCell
            cell.inforTextField.text = languages[row]
            self.profileLanguage = languages[row]
        case genderPicker:
            self.gender.text = genderString[row]
            print(genderString[row])
        default:
            break
        }
        if let rightbar = self.navigationItem.rightBarButtonItem{
            rightbar.tintColor = .white
            self.isChanged = true
        }
    }
    
    func didTapOnDone(){
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return view.frame.size.width
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36.0
    }
   

}
extension UserProfileViewController: TextFieldInTableViewCellDelegate {
    
    func textFieldInTableViewCell(didSelect cell:UserProfileTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell){
            print("didSelect cell: \(indexPath)")
            self.index = indexPath
        }
    }
    
    func textFieldInTableViewCell(cell:UserProfileTableViewCell, editingChangedInTextField newText:String) {
    
        if let indexPath = tableView.indexPath(for: cell){
            print("editingChangedInTextField: \"\(newText)\" in cell: \(indexPath)")
            if(indexPath.section == 0){
              self.profileNationality = newText
            }
            else{
                switch indexPath.row {
                case 0:
                    self.profileEmail = newText
                case 1:
                    self.profilePhnoneNumber = newText
                case 2:
                    self.profileAddress = newText
                default:
                    break
                }
            }
        }
        
        if let rightbar = self.navigationItem.rightBarButtonItem{
           rightbar.tintColor = .white
            self.isChanged = true
        }
    }
    //Push View Up when keyboard appear
    func keyboardWillShow(sender: NSNotification) {
        if(self.isOnProfileEdit == false){
        let userInfo = sender.userInfo
        
        
        let keyboardSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as? CGRect)!
        let offset: CGSize = (userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        print(offset.height)
        print(keyboardSize.height)
        var height = keyboardSize.height
        if(keyboardSize.height == 260){
            height = 258
        }
        if(self.isEditing == false){
            print("Show")
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y -= height
            })
        }
      
        self.isEditing = true
        }
    }
    
    //Push View down when keyboard disappear
    func keyboardWillHide(sender: NSNotification){
        if(self.isOnProfileEdit == false){
        let userInfo = sender.userInfo
        
        
        let keyboardSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as? CGRect)!
        let offset: CGSize = (userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        print(offset.height)
        print(keyboardSize.height)
        var height = keyboardSize.height
        if(keyboardSize.height == 260){
            height = 258
        }
        print("Hide")
        if(self.isEditing == true){
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += height
            })
        }
               self.isEditing = false
    }
    }
}
extension UserProfileViewController: updateUserInfoDelegate{
    func saveInfo() {
        dismissEditInfo()
    }
    func dismissEditInfo() {
        self.isOnProfileEdit = false
        print("Dismiss")
    }
}
