//
//  ArchivesViewController.swift
//  Track
//
//  Created by ty on on 6/21/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import ImageSlideshow

class ArchivesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var photos: [UIImage] = []
    var tableView: UITableView!
    var archives: NSMutableArray! = []
    var loadingIndicator : UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.loadingIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        self.setupActivityIndicator(indicator: loadingIndicator)
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("zzz")
                
                
                
                DispatchQueue.main.async {
                    self.archives = LogManager.sharedInstance.archive
                    self.setupTableView()
                    print("This is run on the main queue, after the previous code in outer block")
                }
            }
        }
        
       
        if self.revealViewController() != nil{
            
            self.setupMenuGestureRecognizer()
            self.navigationController?.setupNavigationColor()
            self.setTitle(text: "ARCHIVES")

            
            navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: revealViewController, action: #selector(self.revealViewController().revealToggle(_:))), animated: true)
            
        }
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: self, action: #selector(didTapOpenButton))
        
        
        
        // Do any additional setup after loading the view.
    }
    //MARK:  TAP Action
    //Menu Tap
 
    
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
        return archives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DashBoardTableViewCell.self)) as! DashBoardTableViewCell
        
        let arch = archives[indexPath.row] as! Archive
        if(arch != nil){
        let log = arch.logs[0]
        cell.setData(log: log)
            cell.selectionStyle = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            //self.isEditing = false
            print("more button tapped")
            
        }
        more.backgroundColor = UIColor.lightGray
        
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
        
        return [share, favorite, more]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        goToViewController(row: indexPath.row)
    }
    
    
    func goToViewController(row: Int){
        
        let nextViewController = LogsViewController()
        nextViewController.recievedArchive = self.archives[row] as! Archive
        let logamount = self.archives[row] as! Archive
        nextViewController.logAmount = logamount.logs.count
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

    //MARK: Segue
    //Add New Log Action

    

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
}
