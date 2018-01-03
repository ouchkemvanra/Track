
//
//  TrackViewController.swift
//  Track
//
//  Created by ty on on 6/14/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import ImageSlideshow
import ImagePicker



class TrackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate,ImagePickerDelegate {
    var pagecontroller : UIPageControl!
    var pageViewController : UIPageViewController!
    var photos: [UIImage] = []
    var collectionView: UICollectionView!
    var emptyView: UIView!
    var topView: UIView!
    var bottomView: UIView!
    var imageSlide: ImageSlideshow! = ImageSlideshow()
    var titleTextField: UITextView!
    var descriptionTextField: UITextView!
    var recognizer : UITapGestureRecognizer!
    var textediting: Bool = false
    var reactionPhotos: [UIImage] = []
    var imagePickerController: ImagePickerController! = ImagePickerController()
    
    var recievedLog: Log!
    var isUpdate: Bool! = false
    var photoEdited: Bool! = false
    var editButton: UIButton!
    var addButton: UIButton!
    var deleteButton: UIButton!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var reactionLabel: UILabel!
    var currentPhoto: Int! = 0
    var addMedicinePhoto : Bool = false
    var addReactionPhoto: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        self.navigationItem.hidesBackButton = true
        self.addBackButton()
        self.addSubmitButton()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.setTitle(text: "NEW LOG")
        if(isUpdate == false){
        if(photos.count > 0){
            setupTopView()
            setupImageSlide()
            setupBottomView()
            setupTitlesTextfield()
            setupDescriptionTextField()
            addDoneButtonOnKeyboard()
            setupCollectionView()
            setupLabelForView()
            constraint()
            
           
        }
        else{
            showEmptyView()
            setupBottomView()
            setupTitlesTextfield()
            setupDescriptionTextField()
            addDoneButtonOnKeyboard()
            setupCollectionView()
            setupLabelForView()
            constraintForEmptyPhoto()
            print("Empty Photos")
            }
        }
        else{
            let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            self.setupActivityIndicator(indicator: loadingIndicator)
            DispatchQueue.global(qos: .background).async {
                print("This is run on the background queue")
                for reaction in self.recievedLog.reactionPhoto{
                    let strBase64 = reaction
                    let data : Data = Data(base64Encoded: strBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                  
                    self.reactionPhotos.append(UIImage.init(data: data as Data)!)
                }
                
                for image in self.recievedLog.medecinePhoto {
                    let strBase64 = image
                    let data : Data = Data(base64Encoded: strBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                    
                    

                    self.photos.append(UIImage.init(data: data as Data)!)
                    
                }
              
                    DispatchQueue.main.async {
                        loadingIndicator.stopAnimating()
                        
                        self.setupView()
                        print("This is run on the main queue, after the previous code in outer block")
                    }
                
            }
        
        }
       
       
        // Do any additional setup after loading the view.
    }
    
    //Setup View
    
    func setupView() {
        self.setupTopView()
        self.setupImageSlide()
        self.setupPageControler()
        self.setupBottomView()
        self.setupTitlesTextfield()
        self.setupDescriptionTextField()
        self.titleTextField.text = self.recievedLog.title
        self.descriptionTextField.text = self.recievedLog.descriptions
        self.descriptionTextField.textColor = .black
        self.titleTextField.textColor = .black
        self.addDoneButtonOnKeyboard()
        self.setupCollectionView()
        self.setupLabelForView()
        self.constraint()
    }
    
    //Setup Title , Description, Reaction Photos Label
    func setupLabelForView() {
        titleLabel = self.setupLabel(title: "Title", place: CGRect(x: 8, y: 8, width: 100, height: 30))
        descriptionLabel = self.setupLabel(title: "Description", place: CGRect(x: 8, y: self.titleTextField.frame.maxY, width: 100, height: 30))
        reactionLabel = self.setupLabel(title: "Reaction Photo", place: CGRect(x: 8, y: self.descriptionTextField.frame.maxY, width: 100, height: 30))
        
        bottomView.addSubview(titleLabel)
        bottomView.addSubview(descriptionLabel)
        bottomView.addSubview(reactionLabel)
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        print("Close")
    }
    
    
    //Setup Top View
    func setupTopView(){
        topView = UIView.init(frame: CGRect.zero)
        topView.backgroundColor = .white
        
        view.addSubview(topView)
        
    }
    
    
    //Setup Bottom View
    func setupBottomView(){
        bottomView = UIView.init(frame: CGRect.zero)
        bottomView.backgroundColor = view.backgroundColor
        
        view.addSubview(bottomView)
        
    
    }
    
    //Setup Titles Text Field View
    func setupTitlesTextfield(){
        titleTextField = UITextView.init(frame: CGRect.zero)
        titleTextField.text = " Title"
        titleTextField.textColor = .lightGray
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.borderColor = Constant.textBorder.cgColor
        titleTextField.layer.cornerRadius = 4.0
        titleTextField.keyboardType = .default
        titleTextField.autocorrectionType = .no
        titleTextField.delegate = self
  
        titleTextField.font = UIFont(name: Constant.fontName, size: 13)
        bottomView.addSubview(titleTextField)
    }
    
    
    //Setup Description Text Field View
    func setupDescriptionTextField(){
        descriptionTextField = UITextView.init(frame: CGRect.zero)
        descriptionTextField.text = " Description"
        descriptionTextField.textColor = .lightGray
        descriptionTextField.layer.borderWidth = 1.0
        descriptionTextField.delegate = self
        descriptionTextField.layer.borderColor = Constant.textBorder.cgColor
        descriptionTextField.keyboardType = .default
        descriptionTextField.layer.cornerRadius = 4.0
        descriptionTextField.autocorrectionType = .no
        descriptionTextField.font = UIFont(name: Constant.fontName, size: 13)
        bottomView.addSubview(descriptionTextField)
        
    }
    
    
    //Setup CollectionView of Reaction Photos
    func setupCollectionView(){
        var multiplier = CGFloat(photos.count)
        switch multiplier {
        case 3,4:
            multiplier = 2.5
      
        default:
            multiplier = 2
            break
        }
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.ConfigsVertical(widthMultiplier: 4.5, heights:70, itemSpacing: 1))
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(TrackCollectionViewCell.self))
        collectionView.register(AddReactionCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(AddReactionCollectionViewCell.self))
        collectionView.layer.cornerRadius = 4.0
        bottomView.addSubview(collectionView)
        
       
    }
    
    //Convert UIImage to [ImageSource] for ImageSlideShow
    func setInputImage(image : [UIImage]) -> [ImageSource]{
        var images : [ImageSource] = []
        for i in 0 ..< photos.count {
            //print(photos[i])
            images.append(ImageSource(image: photos[i]))
        }
        return images
    }
    
    //Setup Image Slide Show
    func setupImageSlide(){
        imageSlide = ImageSlideshow.init(frame: CGRect.zero)
        
        var images : [ImageSource] = []
        for i in 0 ..< photos.count {
            //print(photos[i])
            images.append(ImageSource(image: photos[i]))
        }
        imageSlide.bringSubview(toFront: imageSlide.pageControl)
        imageSlide.pageControl.currentPageIndicatorTintColor = .white
        
        imageSlide.contentScaleMode = .scaleAspectFill
        imageSlide.clipsToBounds = true
        imageSlide.setImageInputs(images)
        imageSlide.backgroundColor = Constant.textBorder
    
        
        recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        
        imageSlide.addGestureRecognizer(recognizer)
        topView.addSubview(imageSlide)
        editButton = UIButton.init(frame: CGRect(x: 8, y: 0, width: 60, height: 60))
        editButton.setTitle("Edit", for: .normal)
        editButton.layer.cornerRadius = editButton.frame.width/2
        editButton.addTarget(self, action: #selector(didTapOnEdit), for: .touchUpInside)
        editButton.backgroundColor = .clear
        editButton.titleLabel?.font = UIFont(name: Constant.fontName, size: 15)
        imageSlide.addSubview(editButton)
        
       
        imageSlide.currentPageChanged = { page in
            print("current page:", page)
            self.editButton.tag = page
            self.currentPhoto = page
            if(self.isUpdate == true){
            self.pagecontroller.currentPage = page
            }
        }
    }
    
    //Setup Page Controller
    
    func setupPageControler(){
        print("Page controller")
        self.pagecontroller = UIPageControl.init(frame: CGRect.zero)
        self.pagecontroller.currentPageIndicatorTintColor = .white
        self.pagecontroller.pageIndicatorTintColor = .gray
        self.pagecontroller.numberOfPages = photos.count
        self.pagecontroller.currentPage = self.currentPhoto
        self.pagecontroller.isUserInteractionEnabled = false
        self.imageSlide.addSubview(self.pagecontroller)
        self.setupPageControllerConstraint()
    }
    
    
    //Setup Page Controller Constraint
    
    func setupPageControllerConstraint() {
        self.pagecontroller.translatesAutoresizingMaskIntoConstraints = false
        
        self.pagecontroller.centerX(to: self.imageSlide)
        self.pagecontroller.height(40)
        self.pagecontroller.width(to: imageSlide)
        self.pagecontroller.bottom(to: imageSlide, offset: -30, relation: .equal, isActive: true)
    }
    
    //Setup View For Empty Photos
    func showEmptyView() {
        emptyView = UIView.init(frame: CGRect.zero)
        emptyView.backgroundColor = .white
        let message = UILabel.init(frame: CGRect.zero)
        message.text = "No Photos"
        message.font = message.font.withSize(20)
        message.textAlignment = .center
        emptyView.addSubview(message)
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        message.translatesAutoresizingMaskIntoConstraints = false
        
        message.center(in: emptyView)
        message.width(200)
        message.height(50)
        
        emptyView.top(to: self.view)
        emptyView.leading(to: self.view)
        emptyView.width(to: self.view)
        emptyView.height(self.view.frame.height/2 + 50)
        
    }
    
    //Did Tap on Button Edit on Image Slid Show
    func didTapOnEdit(sender: UIButton){
        print("Edit photo at: ", sender.tag)
        photoEdited = !photoEdited
        if(photoEdited == true){
            self.addButton = UIButton.init(frame: self.editButton.frame)
            self.addButton.setTitle("Add", for: .normal)
            self.addButton.addTarget(self, action: #selector(didTapOnAddPhoto), for: .touchUpInside)
            self.addButton.layer.cornerRadius = self.addButton.frame.width/2
            self.addButton.tag = sender.tag
            self.addButton.backgroundColor = editButton.backgroundColor
            self.addButton.setTitleShadowColor(.black, for: .highlighted)
            self.addButton.titleLabel?.font = editButton.titleLabel?.font
            
            self.deleteButton = UIButton.init(frame: self.editButton.frame)
            self.deleteButton.setTitle("Delete", for: .normal)
            self.deleteButton.layer.cornerRadius = self.deleteButton.frame.width/2
            self.deleteButton.addTarget(self, action: #selector(didTapOnDeletePhoto(sender:)), for: .touchUpInside)
            self.deleteButton.backgroundColor = editButton.backgroundColor
            self.deleteButton.tag = sender.tag
            self.deleteButton.setTitleShadowColor(.black, for: .highlighted)
            self.deleteButton.titleLabel?.font = editButton.titleLabel?.font
            
            imageSlide.addSubview(addButton)
            imageSlide.addSubview(deleteButton)
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.addButton.frame.origin.x += self.editButton.frame.width + 3
            self.deleteButton.frame.origin.x += self.editButton.frame.width + self.addButton.frame.width + 6
            self.addButton.alpha = 1
            self.deleteButton.alpha = 1
           
            })
        }
        else{
            self.removeButton {
            self.imageSlide.bringSubview(toFront: editButton)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    print("done")
                 
                    self.addButton.removeFromSuperview()
                    self.deleteButton.removeFromSuperview()
                }
                
            }
        }
        
        
    }
    
    //Remove Button Add & Delete
    func removeButton(finished: () -> Void) {
        
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.addButton.frame.origin.x -= self.editButton.frame.width - 8
            self.deleteButton.frame.origin.x -= self.editButton.frame.width + self.addButton.frame.width - 8
            self.addButton.alpha = 0
            self.deleteButton.alpha = 0
            
        })
        print("Doing something!")
        
        finished()
        
    }
    
    //Did Tap on Delete on Image slide Show Edit button
    func didTapOnDeletePhoto(sender: UIButton) {
        
         photoEdited = !photoEdited
        self.removeButton {
            self.imageSlide.bringSubview(toFront: editButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                print("Delete")
                print(self.currentPhoto)
                self.addButton.removeFromSuperview()
                self.deleteButton.removeFromSuperview()
                if(self.photos.count > 0){
                self.photos.remove(at: self.currentPhoto)
                self.imageSlide.setImageInputs(self.setInputImage(image: self.photos))
                //self.pagecontroller.numberOfPages = self.photos.count
                self.imageSlide.reloadInputViews()
                }
            }
        }
    }
    
    
    //Did tap on Add on Image Slide Show Edit Button
    func didTapOnAddPhoto() {
        print("Add")
        photoEdited = !photoEdited
        self.addMedicinePhoto = !self.addMedicinePhoto
        self.removeButton {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                print("done")
                
                self.addButton.removeFromSuperview()
                self.deleteButton.removeFromSuperview()
                self.setupCamera()
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
        }
        }
    
    //Did Tap on Image Slide Show to View in Full Screen
    func didTap() {
        if(self.textediting == false){
        imageSlide.presentFullScreenController(from: self)
        }
        else{
            hidekeyboard()
            print("Hide")
            
        }
    }
    
    
    
    //Constraint setup for view
    func constraint() {
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.top(to: view, offset: 8, relation: .equal, isActive: true)
        topView.leading(to: view, offset: 8, relation: .equal, isActive: true)
        topView.trailing(to: view, offset: -8, relation: .equal, isActive: true)
        topView.height(view.frame.size.height/2 - 70)
        
        imageSlide.translatesAutoresizingMaskIntoConstraints = false
        imageSlide.top(to: topView)
        imageSlide.leading(to: topView)
        imageSlide.width(to: topView)
        imageSlide.height(UIScreen.main.bounds.height/2 - 70)
    
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topToBottom(of: topView)
        bottomView.leading(to: view, offset: 8, relation: .equal, isActive: true)
        bottomView.trailing(to: view, offset: -8, relation: .equal, isActive: true)
        bottomView.bottom(to: view, offset: -8, relation: .equal, isActive: true)
        
        
       
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.top(to: bottomView, offset: 28, relation: .equal, isActive: true)
        titleTextField.leading(to: bottomView, offset: 0, relation: .equal, isActive: true)
        titleTextField.trailing(to: bottomView, offset: 0, relation: .equal, isActive: true)
        titleTextField.height(40)
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.topToBottom(of: titleTextField, offset: 28, relation: .equal, isActive: true)
        descriptionTextField.leading(to: bottomView, offset: 0, relation: .equal, isActive: true)
        descriptionTextField.trailing(to: bottomView, offset: 0, relation: .equal, isActive: true)
        descriptionTextField.height(100)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottom(to: bottomView, offset: -8, relation: .equal, isActive: true)
        collectionView.leading(to: self.bottomView)
        collectionView.width(to: self.bottomView)
        collectionView.topToBottom(of: descriptionTextField, offset: 28, relation: .equal, isActive: true)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        reactionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.top(to: self.bottomView, offset: 6, relation: .equal, isActive: true)
        titleLabel.leading(to: self.titleTextField, offset: 8, relation: .equal, isActive: true)
        descriptionLabel.topToBottom(of: self.titleTextField, offset: 6, relation: .equal, isActive: true)
        descriptionLabel.leading(to: titleLabel)
        reactionLabel.topToBottom(of: descriptionTextField, offset: 6, relation: .equal, isActive: true)
        reactionLabel.leading(to: titleLabel)
    }
    
    
    //Constraint setup for empty Photos
    func constraintForEmptyPhoto(){
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.top(to: view, offset: 8, relation: .equal, isActive: true)
        emptyView.leading(to: view, offset: 8, relation: .equal, isActive: true)
        emptyView.trailing(to: view, offset: -8, relation: .equal, isActive: true)
        emptyView.height(view.frame.size.height/2 - 70)
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topToBottom(of: emptyView)
        bottomView.leading(to: view, offset: 8, relation: .equal, isActive: true)
        bottomView.trailing(to: view, offset: -8, relation: .equal, isActive: true)
        bottomView.bottom(to: view, offset: -8, relation: .equal, isActive: true)
        
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.top(to: bottomView, offset: 28, relation: .equal, isActive: true)
        titleTextField.leading(to: bottomView, offset: 0, relation: .equal, isActive: true)
        titleTextField.trailing(to: bottomView, offset: 0, relation: .equal, isActive: true)
        titleTextField.height(40)
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.topToBottom(of: titleTextField, offset: 28, relation: .equal, isActive: true)
        descriptionTextField.leading(to: bottomView, offset: 0, relation: .equal, isActive: true)
        descriptionTextField.trailing(to: bottomView, offset: 0, relation: .equal, isActive: true)
        descriptionTextField.height(100)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottom(to: bottomView, offset: -8, relation: .equal, isActive: true)
        collectionView.leading(to: self.bottomView)
        collectionView.width(to: self.bottomView)
        collectionView.topToBottom(of: descriptionTextField, offset: 28, relation: .equal, isActive: true)
   
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        reactionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.top(to: self.bottomView, offset: 6, relation: .equal, isActive: true)
        titleLabel.leading(to: self.titleTextField, offset: 8, relation: .equal, isActive: true)
        descriptionLabel.topToBottom(of: self.titleTextField, offset: 6, relation: .equal, isActive: true)
        descriptionLabel.leading(to: titleLabel)
        reactionLabel.topToBottom(of: descriptionTextField, offset: 6, relation: .equal, isActive: true)
        reactionLabel.leading(to: titleLabel)
    }
    

    
    
    //MARK: UITextViewDelegate 
    
    func textViewDidBeginEditing(_ textView: UITextView) {
     
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
       
  
                }

    func textViewDidEndEditing(_ textView: UITextView) {
       
        if textView.text.isEmpty {
            switch textView {
            case titleTextField:
                textView.text = "Title"
            case descriptionTextField:
                textView.text = "Description"
            default:
                 textView.text = "Input text"
            }
           
            textView.textColor = UIColor.lightGray
        }
       
        hidekeyboard()
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    
    //Hide Keyboard
    func hidekeyboard(){
       
        self.view.endEditing(true)
       
    }
    //Push View Up when keyboard appear
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
        self.imageSlide.scrollView.isScrollEnabled = false
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
        self.imageSlide.scrollView.isScrollEnabled = true
        self.textediting = false
    }
    
    //Add done Button on Keyboard
    func addDoneButtonOnKeyboard() {
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
                                              target: self, action: #selector(doneButtonAction))
        
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
      
        self.titleTextField.inputAccessoryView = toolbarDone
        self.descriptionTextField.inputAccessoryView = toolbarDone
//        txtCardDetails3.inputAccessoryView = toolbarDone
    }
    
    //Action for Done Button on Keyboard
    func doneButtonAction() {
       // self.view.endEditing(true)
        
        self.titleTextField.resignFirstResponder()
        self.descriptionTextField.resignFirstResponder()
    }
    
    
    //MARK: UICollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reactionPhotos.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let currentIndex = indexPath.item
        switch currentIndex {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(AddReactionCollectionViewCell.self), for: indexPath) as! AddReactionCollectionViewCell
            cell.isUserInteractionEnabled = true
            cell.layer.borderColor = Constant.textBorder.cgColor
            cell.layer.borderWidth = 1.0
            cell.image.image = UIImage.init(named: "add (1)")
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TrackCollectionViewCell.self), for: indexPath) as! TrackCollectionViewCell
            cell.isUserInteractionEnabled = true
            cell.image.image = reactionPhotos[indexPath.item - 1]
            if(cell.deleteButton != nil){
                cell.deleteButton.addTarget(self, action: #selector(self.didTapOnDelete(sender:)), for: .touchUpInside)
                cell.deleteButton.tag = indexPath.item - 1
            }
            return cell

        }

        
        
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select")
        if(indexPath.item == 0){
        self.addReactionPhoto = !self.addReactionPhoto
        setupCamera()
        present(imagePickerController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(imagePickerController, animated: true)
        }
    }
    
    
    //Did Tap on delete on CollectionView of Reaction Photos
    func didTapOnDelete(sender: UIButton) {
        print("delete")
        
        reactionPhotos.remove(at: sender.tag)
        collectionView.reloadData()
    
        
    }
    
    //Setup Camera view
    func setupCamera(){
        var configuration = Configuration()
        configuration.bottomContainerColor = configuration.gallerySeparatorColor
        imagePickerController.removeFromParentViewController()
        imagePickerController = ImagePickerController()
        imagePickerController.configuration = configuration
        
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 10
        
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        
        
        imagePickerController.setTitle(text: "Camera")
    }
    
    //MARK: Image Picker Controller Delegate Method
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        print("Hello")
        
    }
    func setImage(images: [UIImage], completion: (Bool) -> ()) {
        self.photos.append(contentsOf: images)
        self.imageSlide.setImageInputs(self.setInputImage(image: images))
        print("Doing something!")
        completion(true)
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
       
        let totalImages = images
        if(self.addMedicinePhoto == true){
            self.setImage(images: totalImages, completion: { (success) -> Void in
                 print("Done")
                self.dismiss(animated: true, completion: nil)
                self.imageSlide.reloadInputViews()
                //self.pagecontroller.numberOfPages += totalImages.count
                self.addMedicinePhoto = !self.addMedicinePhoto
            })
           
        
        }
        else if(self.addReactionPhoto == true){
            self.reactionPhotos.append(contentsOf: totalImages)
            self.dismiss(animated: true, completion: nil)
            collectionView.reloadData()
            self.addReactionPhoto = !self.addReactionPhoto
        }
        
        
        self.imagePickerController.removeFromParentViewController()
        //didTapOnDone(images: images)
        
        
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
        print("Cancel")
        self.imagePickerController.removeFromParentViewController()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func addSubmitButton(){
        let submit = UIBarButtonItem.init(title: "Submit", style: .plain, target: self, action: #selector(didTabOnSubmit))
        self.navigationItem.rightBarButtonItem = submit
    }
    func didTabOnSubmit(){
        let successAlert = UIAlertController(title: "", message: "Your log has been saved successfully", preferredStyle: .alert)
        
        
        submitLog(completion: {(success) -> Void in
        print("Done")
            
        })
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            let log1 = Log()
            log1.title = "Tiffy"
            if(self.titleTextField.text != ""){
                log1.title = self.titleTextField.text
            }
          
            let image = UIImage.init(named: "testImage")
            let imageData : NSData = UIImagePNGRepresentation(image!)! as NSData
           // let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            log1.descriptions = "I took a paracetamol, but i still having cold"
            log1.date = "12:30 PM 09 June 2017"
            log1.monitoringDate = "Monitoring started 19 days ago"
            log1.reactionPhoto = self.convertImagetoBinary(Images: self.reactionPhotos)
            log1.medecinePhoto = self.convertImagetoBinary(Images: self.photos)
            
            LogManager.sharedInstance.logs.add(log1)
            LogManager.sharedInstance.save()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logAdded"), object: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(successAlert, animated: true, completion: nil)
    }

    func submitLog(completion: (Bool) -> ()) {
       
        print("Doing something!")
        completion(true)
        
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
extension UIViewController{
    func ConfigsVertical(widthMultiplier: CGFloat, heights: CGFloat, itemSpacing: CGFloat) -> UICollectionViewFlowLayout{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let mainScreen = UIScreen.main.bounds
        let width = mainScreen.width
       
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (width/widthMultiplier), height: heights)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        return layout
        
        
    }
    func addBackButton(){
        let back = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(self.dismissView))
    
        self.navigationItem.leftBarButtonItem = back
    }

    func dismissView(){
        
        self.navigationController?.popToRootViewController(animated:true)
      
    }
    func setupLabel(title: String, place: CGRect) -> UILabel{
        let label = UILabel.init(frame: place)
        label.text = title
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont(name: Constant.fontName, size: 13)
        
        return label
    }
}

extension UICollectionView {
    func reloadWithoutAnimation(){
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.reloadData()
        CATransaction.commit()
    }
}
extension UIViewController{
    func decodeImage(text: String) -> UIImage{
        let strBase64 = text
        let data : Data = Data(base64Encoded: strBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage.init(data: data)!
        
    }
    func convertImagetoBinary(Images: [UIImage]) -> [String]{
        var result: [String] = []
        for image in Images{
            let img = image
            let imageData : NSData = UIImagePNGRepresentation(img)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            result.append(strBase64)
        }
        return result
        
    }
}
