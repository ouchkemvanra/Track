//
//  UpdateLogViewController.swift
//  Track
//
//  Created by ty on on 6/13/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit
protocol UpdateDelegate {
    func changeData(log: Log)
    func dismissUpdateLog()
}
class UpdateLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
     var logs: NSMutableArray!
    var delegate: UpdateDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        logs = LogManager.sharedInstance.logs
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
        tableView.register(DashBoardTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(DashBoardTableViewCell.self))
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.top(to: self.view)
        tableView.bottom(to: self.view, offset: 0, relation: .equal, isActive: true)
        tableView.leading(to: self.view, offset: 10, relation: .equal, isActive: true)
        tableView.trailing(to: self.view, offset: -10, relation: .equal, isActive: true)
        
    }
    

    //MARK: UITableview Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logs.count
    }
    


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DashBoardTableViewCell.self)) as! DashBoardTableViewCell
        let log = logs[indexPath.row]
        cell.setData(log: log as! Log)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("12312312")
        let log = logs[indexPath.row]
       
        delegate?.changeData(log: log as! Log)
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLog"), object: nil)
        self.dismiss(animated: true, completion: nil)
        
    
    }
    func goToTrack(log: Log) {
        print("Update")
     
        
        
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
