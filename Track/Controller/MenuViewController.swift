//
//  MenuViewController.swift
//  Track
//
//  Created by ty on on 6/12/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
import KYDrawerController
import Alamofire
import AlamofireImage

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var presentRow : NSInteger!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        setupTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupTableView(){
        tableView = UITableView.init(frame: CGRect(x: 8, y: 8, width: UIScreen.main.bounds.width-8, height: UIScreen.main.bounds.height-8), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuTopTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MenuTopTableViewCell.self))
        tableView.register(MenuMiddleTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MenuMiddleTableViewCell.self))
        tableView.register(MenuBottomTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MenuBottomTableViewCell.self))
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .singleLine
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.top(to: self.view, offset: 0, relation: .equal, isActive: true)
        tableView.bottom(to: self.view, offset: 0, relation: .equal, isActive: true)
        tableView.leading(to: self.view, offset: 0, relation: .equal, isActive: true)
        tableView.width(self.view.frame.size.width - 75)
        
        
    }
    func didTapCloseButton() {
        if let drawerController = parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MenuTopTableViewCell.self)) as! MenuTopTableViewCell
            cell.setData()
            cell.selectionStyle = .none
            
           cell.separatorInset.left = UIScreen.main.bounds.width
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MenuMiddleTableViewCell.self)) as! MenuMiddleTableViewCell
            
            //cell.setData()
            cell.setData(icon: Constant.icons[indexPath.row]!, title: Constant.menuTitles[indexPath.row])
            cell.selectionStyle = .none
            
            cell.separatorInset.left = UIScreen.main.bounds.width
            
        
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MenuBottomTableViewCell.self)) as! MenuBottomTableViewCell
            cell.separatorInset.left = UIScreen.main.bounds.width
            cell.selectionStyle = .none
            //cell.setData()
            //cell.setData(icon: Constant.icons[indexPath.row]!, title: Constant.menuTitles[indexPath.row])
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        case 1:
            return 60
        default:
            return 60
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 2
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView.init(frame: CGRect(x: 8, y: 0, width: UIScreen.main.bounds.width + 100, height: 2))
        footer.backgroundColor = UIColor.lightGray
        return footer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealviewcontroller = self.revealViewController()
        let row = indexPath.row
        var newViewcontroller : UIViewController? = nil
        
        switch indexPath.section {
        case 0:
            newViewcontroller = UINavigationController(rootViewController: UserProfileViewController())
        case 1:
            switch indexPath.row {
            case 0:
                newViewcontroller = UINavigationController(rootViewController: DashboardViewController())
                break
            case 1:
                 newViewcontroller = UINavigationController(rootViewController: ArchivesViewController())
            case 2:
                 newViewcontroller = UINavigationController(rootViewController: DoctorProfileViewController())
            case 3:
                 newViewcontroller = UINavigationController(rootViewController: AboutViewController())
            case 4:
                 newViewcontroller = UINavigationController(rootViewController: FAQViewController())
            case 5:
                 newViewcontroller = UINavigationController(rootViewController: DisclaimerViewController())
            default:
                newViewcontroller = UINavigationController(rootViewController: DoctorProfileViewController())
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                print("hello")
                newViewcontroller = UINavigationController(rootViewController: Login())
                
            default:
                break
            }
        default:
            break
            
        }
        revealviewcontroller?.pushFrontViewController(newViewcontroller, animated: true)
        presentRow = row
        
    }
    func loginAciton() {
        let nextViewcontroller = Login()
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
       
       
        if let drawerController = parent as? KYDrawerController {
            let navi = drawerController.mainViewController as! UINavigationController
            navi.pushViewController(nextViewcontroller, animated: true)
            
            navi.navigationBar.backItem?.title = ""
           
            drawerController.setDrawerState(.closed, animated: true)
        
        }
        
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
