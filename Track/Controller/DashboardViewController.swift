//
//  DashboardViewController.swift
//  Track
//
//  Created by ty on on 6/10/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import KYDrawerController
import ImagePicker

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImagePickerDelegate, UpdateDelegate {
    
    
    var photos: [UIImage] = []
    var tableView: UITableView!
    var logs: NSMutableArray!
    var imagePickerController = ImagePickerController()
    var logToUpdate: Log!
    var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setupNavigationColor()
        self.setTitle(text: "TRACK")
        self.loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        self.setupActivityIndicator(indicator: loadingIndicator)
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
         
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               print("111111")
           
                
            
            
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.logs = LogManager.sharedInstance.logs
              
                self.setupTableView()
              
                print("This is run on the main queue, after the previous code in outer block")
            }
            }
        }
        
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: revealViewController, action: #selector(self.revealViewController().revealToggle(_:))), animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "add"), style: .plain, target: self, action: #selector(didTapAdd))
        
        
        if self.revealViewController() != nil{
         
           self.setupMenuGestureRecognizer()

            
        }
  NotificationCenter.default.addObserver(self, selector: #selector(logAdded(notification:)), name: NSNotification.Name(rawValue: "logAdded"), object: nil)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       NotificationCenter.default.addObserver(self, selector: #selector(updateLog(notification:)), name: NSNotification.Name(rawValue: "updateLog"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "updateLog"), object: nil)
    }
    func updateLog(notification: Notification){
        print("Update")
        let nextviewcontroller = TrackViewController()
        nextviewcontroller.isUpdate = true
        nextviewcontroller.recievedLog = self.logToUpdate
       self.navigationController?.pushViewController(nextviewcontroller, animated: true)
    }
    
    
    //UpdateDelegate method
    func logAdded(notification: Notification){
        self.tableView.reloadData()
    }
    
    func changeData(log: Log){
        self.logToUpdate = log
        
        
    }
    func dismissUpdateLog(){
        self.dismiss(animated: true, completion: nil)
    }
    func didTapOpenButton(_ sender: UIBarButtonItem) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    //Add Tap
    func didTapAdd(_ sender: UIBarButtonItem) {
        let AddNewLog = UIAlertController(title: nil, message: "Please choose whether you want to create a new log or upadate an existing one", preferredStyle: .actionSheet)
        
        // Create UIAlertAction for UIAlertController
        
        let addAction = UIAlertAction(title: "Add New Log", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Popularity")
            self.addNewLog()
        })
        let saveAction = UIAlertAction(title: "Update Log", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Price Low To High")
          self.updateLog()
        })
        
      
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
          
        })
        
        // Add UIAlertAction in UIAlertController
        
        AddNewLog.addAction(addAction)
        AddNewLog.addAction(saveAction)
        AddNewLog.addAction(cancelAction)
        
        
        // Present UIAlertController with Action Sheet
        
        self.present(AddNewLog, animated: true, completion: { () -> Void in
            AddNewLog.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
        })
      

    }
    //Dismiss when tap outside
    func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    //Cancel Tap
    func cancelTap(){
        print("zzz")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Setup TableView
    func setupTableView(){
        tableView = UITableView.init(frame: CGRect(x: 8, y: 8, width: UIScreen.main.bounds.width-8, height: UIScreen.main.bounds.height-8), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DashBoardTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(DashBoardTableViewCell.self))
      
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.top(to: self.view)
        tableView.bottom(to: self.view, offset: 0, relation: .equal, isActive: true)
        tableView.leading(to: self.view, offset: 0, relation: .equal, isActive: true)
        tableView.trailing(to: self.view)
        
    }

    
    
    //MARK: UITableview Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logs.count
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
        let titles = UILabel.init(frame: CGRect(x: 8, y: 8, width: tableView.frame.size.width - 20, height: 40))
        titles.text = "RECENT LOG"
        titles.textColor = .gray
        titles.font = UIFont(name: Constant.fontName, size: 20)
        header.addSubview(titles)
        header.backgroundColor = .white
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DashBoardTableViewCell.self)) as! DashBoardTableViewCell
        if(self.logs != nil){
            let log = logs[indexPath.row]
            cell.setData(log: log as! Log)
        }
       
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            print("row deleted")
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
           
            self.deletlLog(index: indexPath.row)
           
            print("Delte button tapped")
           
        }
        delete.backgroundColor = UIColor.red
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            //self.isEditing = false
            print("favorite button tapped")
        }
        favorite.backgroundColor = UIColor.orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            //self.isEditing = false
            print("share button tapped")
            let sharemenu = UIAlertController(title: nil, message: "Share using", preferredStyle: UIAlertControllerStyle.actionSheet)
            let twitterAction = UIAlertAction(title: "twitter", style: UIAlertActionStyle.default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            sharemenu.addAction(twitterAction)
            sharemenu.addAction(cancelAction)
            self.present(sharemenu, animated: true, completion: nil)
        }
        share.backgroundColor = UIColor.blue
        
        return [delete]
    }
    
    
    func deletlLog(index: Int){
        var tRemove:Array<NSIndexPath> = Array()
        let tIndexPath:NSIndexPath = NSIndexPath(row: index, section: 0)
        tRemove.append(tIndexPath)
        LogManager.sharedInstance.logs.removeObject(at: index)
        LogManager.sharedInstance.save()
        self.tableView.deleteRows(at: tRemove as [IndexPath], with: .left)
        //self.tableView.reloadData()
    }
    
    //MARK: Segue 
    //Add New Log Action
    func addNewLog() {
        didTapOnAddNewLog()
       /* let nextViewcontroller = CameraViewController()
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        self.navigationController?.pushViewController(nextViewcontroller, animated: true)*/
    }
    
    //Update Log
    
    func updateLog() {
        let alertController : UIAlertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        
        alertController.view.backgroundColor = UIColor.white
        alertController.view.layer.cornerRadius = 8.0
        
        let updateLogViewController = UpdateLogViewController()
    
       
    
    
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
      //  let width:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.width * 0.90)
        alertController.view.addConstraint(height)
       // alertController.view.addConstraint(width)
    
        alertController.setValue(updateLogViewController, forKeyPath: "contentViewController")
            updateLogViewController.preferredContentSize = CGSize(width: self.view.frame.width + 50 , height: CGFloat(100 * 10))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
            self.cancelTap()
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: {
       
        updateLogViewController.delegate = self
        })
    }
    
    
    
    func didTapOnAddNewLog(){
        var configuration = Configuration()
        configuration.bottomContainerColor = configuration.gallerySeparatorColor
        
        imagePickerController = ImagePickerController()
        imagePickerController.configuration = configuration
    
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 10
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        
        imagePickerController.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Skip", style: .plain, target: self, action: #selector(didTapOnSkip))
        imagePickerController.setTitle(text: "Camera")

        //present(imagePickerController, animated: true, completion: nil)
        //let navi = UINavigationController(rootViewController: imagePickerController)
        imagePickerController.navigationController?.setupNavigationColor()
        self.navigationController?.pushViewController(imagePickerController, animated: true)
        //print(self.imagess.count)
    }
    
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
       
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        
        
       // let totalImages = images
        self.photos = images
        self.dismiss(animated: true, completion: nil)
        didTapOnDone(images: images)

        
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
      
        self.navigationController?.popViewController(animated: true)
         
    }
    
    func didTapOnSkip()  {
        let nextViewController = TrackViewController()
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        imagePickerController.navigationItem.backBarButtonItem = backbutton
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func didTapOnDone(images: [UIImage]){
        let nextViewController = TrackViewController()
        nextViewController.photos = images
        nextViewController.isUpdate = false
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        imagePickerController.navigationItem.backBarButtonItem = backbutton
        self.navigationController?.pushViewController(nextViewController, animated: true)
       //  imagePickerController.removeFromParentViewController()
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
private let DimmingViewTag = 10001

extension UIViewController: SWRevealViewControllerDelegate {
      //MARK: - SWRevealViewControllerDelegate
    func setupMenuGestureRecognizer() {
        
        revealViewController().delegate = self
        
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }

    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        
       
        if case .right = position {
            
            let dimmingView = UIView(frame: CGRect(x: 0, y: -60, width: view.frame.size.width, height: view.frame.size.height + 60))
            dimmingView.tag = DimmingViewTag
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            self.navigationController?.navigationBar.layer.zPosition = -1
            view?.addSubview(dimmingView)
            view?.bringSubview(toFront: dimmingView)
            UIView.animate(withDuration: 0.5) { () -> Void in
                dimmingView.alpha = 0.3
            }

            
        } else {
            UIView.animate(withDuration: 0.5) { () -> Void in
                self.navigationController?.navigationBar.layer.zPosition = 1
                self.view?.viewWithTag(DimmingViewTag)?.removeFromSuperview()
                
            }
          
        }
    }

  
    

}
extension UIViewController{
    func setupActivityIndicator(indicator: UIActivityIndicatorView){
      
        
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        indicator.startAnimating()
       
        self.view.addSubview(indicator)
        
    }
    func goBackToHomePage(){
        //self.navigationController?.popToRootViewController(animated: true)
        let revealviewcontroller = self.revealViewController()
        let newViewcontroller = UINavigationController(rootViewController: DashboardViewController())
        revealviewcontroller?.pushFrontViewController(newViewcontroller, animated: true)
    }
}

