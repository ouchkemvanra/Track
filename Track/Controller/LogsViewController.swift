//
//  LogsViewController.swift
//  Track
//
//  Created by ty on on 6/21/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import  ImagePicker
import ImageSlideshow

class LogsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate  {
    var pagecontroller: UIPageControl!
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
    var reactionPhotos: [UIImage]! = []
    var logAmount : Int! = 2
    var recievedArchive: Archive!
    var currentReactionPhoto: [UIImage] = []
    
    var photoEdited: Bool! = false
    var editButton: UIButton!
    var addButton: UIButton!
    var deleteButton: UIButton!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var reactionLabel: UILabel!
    var dateLabel: UILabel!
    var logAmountLabel: UILabel!
    var currentPhoto: Int! = 0
    var addMedicinePhoto : Bool = false
    var addReactionPhoto: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logAmount = recievedArchive.logs.count
      
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.setTitle(text: "LOG DETAIL")
        if(photos.count >= 0){
            let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            self.setupActivityIndicator(indicator: loadingIndicator)
            
            DispatchQueue.global(qos: .background).async {
                print("This is run on the background queue")
                for reaction in self.recievedArchive.logs[self.currentPhoto].reactionPhoto{
                    let strBase64 = reaction
                    let data : Data = Data(base64Encoded: strBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                    
                    
                    self.reactionPhotos.append(UIImage.init(data: data as Data)!)
                }
                
                for log in self.recievedArchive.logs {
                    let strBase64 = log.medecinePhoto[0]
                    let data : Data = Data(base64Encoded: strBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                    
                    self.photos.append(UIImage.init(data: data as Data)!)
                }
                
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating()
                    self.setupTopView()
                    self.setupImageSlide()
                    
                    self.setupBottomView()
                    self.setupTitlesTextfield()
                    self.setupDescriptionTextField()
                    
                    self.setupCollectionView()
                    self.setupLabelForView()
                    self.constraint()
                    if(self.recievedArchive != nil){
                        self.titleTextField.text = self.recievedArchive.logs[self.currentPhoto].title
                        self.descriptionTextField.text = self.recievedArchive.logs[self.currentPhoto].descriptions
                        self.dateLabel.text = self.recievedArchive.logs[self.currentPhoto].date
                    }
                    
                    print("This is run on the main queue, after the previous code in outer block")
                }
                
            }
            

            
            
            
        }
        else{
            showEmptyView()
            setupBottomView()
            setupTitlesTextfield()
            setupDescriptionTextField()
           
            setupCollectionView()
            setupLabelForView()
            constraintForEmptyPhoto()
            print("Empty Photos")
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    //Setup Title , Description, Reaction Photos Label
    func setupLabelForView() {
        titleLabel = self.setupLabel(title: "Title", place: CGRect(x: 8, y: 8, width: 100, height: 30))
        descriptionLabel = self.setupLabel(title: "Description", place: CGRect(x: 8, y: self.titleTextField.frame.maxY, width: 100, height: 30))
        reactionLabel = self.setupLabel(title: "Reaction Photo", place: CGRect(x: 8, y: self.descriptionTextField.frame.maxY, width: 100, height: 30))
        dateLabel = self.setupLabel(title: "19 July 2016 17:35 PM", place: CGRect(x: self.bottomView.frame.maxX - 120, y: 8, width: 100, height: 30))
        dateLabel.font = dateLabel.font.withSize(11)
        logAmountLabel = self.setupLabel(title: "1/\(self.logAmount!)", place: CGRect(x: self.bottomView.frame.maxX - 120, y: 8, width: 100, height: 30))
        
        bottomView.addSubview(titleLabel)
        bottomView.addSubview(logAmountLabel)
        bottomView.addSubview(dateLabel)
        bottomView.addSubview(descriptionLabel)
        bottomView.addSubview(reactionLabel)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        titleTextField.text = "Paracetamol"
        titleTextField.textColor = .black
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.borderColor = Constant.textBorder.cgColor
        titleTextField.layer.cornerRadius = 4.0
        titleTextField.isEditable = false
        titleTextField.isSelectable = true
        titleTextField.delegate = self
       
        titleTextField.font = UIFont(name: Constant.fontName, size: 13)
        bottomView.addSubview(titleTextField)
    }
    
    
    //Setup Description Text Field View
    func setupDescriptionTextField(){
        descriptionTextField = UITextView.init(frame: CGRect.zero)
        descriptionTextField.text = " I took a paracetamol, but i still getting hot."
        descriptionTextField.textColor = .black
        descriptionTextField.layer.borderWidth = 1.0
        descriptionTextField.layer.borderColor = Constant.textBorder.cgColor
        descriptionTextField.isEditable = false
        descriptionTextField.isSelectable = true
        descriptionTextField.layer.cornerRadius = 4.0
         descriptionTextField.delegate = self
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
        imageSlide.contentMode = .center
        
        imageSlide.contentScaleMode = .center
        imageSlide.setImageInputs(images)
        
        imageSlide.backgroundColor = .white
        recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        
        imageSlide.addGestureRecognizer(recognizer)
        topView.addSubview(imageSlide)
        
        setupPageControler()
               imageSlide.currentPageChanged = { page in
                    print("current page:", page)
                    self.currentPhoto = page
                    self.pagecontroller.currentPage = page
                if(self.recievedArchive != nil){
                    self.reactionPhotos.removeAll()
                    self.titleTextField.text = self.recievedArchive.logs[self.currentPhoto].title
                    self.descriptionTextField.text = self.recievedArchive.logs[self.currentPhoto].descriptions
                    self.dateLabel.text = self.recievedArchive.logs[self.currentPhoto].date
                    
                    DispatchQueue.global(qos: .background).async {
                        print("This is run on the background queue")
                      
                        for reaction in self.recievedArchive.logs[self.currentPhoto].reactionPhoto{
                            let strBase64 = reaction
                            let data : Data = Data(base64Encoded: strBase64, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
                            
                            self.reactionPhotos.append(UIImage.init(data: data as Data)!)
                            
                        }
                        DispatchQueue.main.async {
                            
                            self.collectionView.reloadData()
                            
                            print("This is run on the main queue, after the previous code in outer block")
                        }
                        
                    }
                  
                   
                }
                self.logAmountLabel.text = "\(self.currentPhoto! + 1)/\(self.logAmount!)"
                self.bottomView.reloadInputViews()
        }
    }
    
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
    
    
    
    //Did Tap on Image Slide Show to View in Full Screen
    func didTap() {
       
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
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        logAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.top(to: self.bottomView, offset: 6, relation: .equal, isActive: true)
        titleLabel.leading(to: self.titleTextField, offset: 8, relation: .equal, isActive: true)
        logAmountLabel.top(to: titleLabel)
        logAmountLabel.centerX(to: bottomView)
        
        dateLabel.top(to: titleLabel)
        dateLabel.trailing(to: bottomView, offset: -8, relation: .equal, isActive: true)
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
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        logAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.top(to: self.bottomView, offset: 6, relation: .equal, isActive: true)
        titleLabel.leading(to: self.titleTextField, offset: 8, relation: .equal, isActive: true)
        logAmountLabel.top(to: titleLabel)
        logAmountLabel.centerX(to: bottomView)

        dateLabel.top(to: titleLabel)
        dateLabel.trailing(to: bottomView, offset: -8, relation: .equal, isActive: true)
        descriptionLabel.topToBottom(of: self.titleTextField, offset: 6, relation: .equal, isActive: true)
        descriptionLabel.leading(to: titleLabel)
        reactionLabel.topToBottom(of: descriptionTextField, offset: 6, relation: .equal, isActive: true)
        reactionLabel.leading(to: titleLabel)
    }
    
    
    
    
 
    

    
    
    //Hide Keyboard
  
    //Push View Up when keyboard appear
        //Add done Button on Keyboard

    
    //MARK: UICollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reactionPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TrackCollectionViewCell.self), for: indexPath) as! TrackCollectionViewCell
            cell.isUserInteractionEnabled = true
        if(reactionPhotos != nil){
            cell.image.image = reactionPhotos[indexPath.item]
        }
            cell.deleteButton.alpha = 0
            return cell
            
        
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select")
        if(indexPath.item == 0){
        }
    }
    
    

    //Setup Camera view
    
    //MARK: Image Picker Controller Delegate Method
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
