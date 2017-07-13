//
//  LogManager.swift
//  Track
//
//  Created by ty on on 6/22/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import Foundation
import Alamofire

class LogManager{
    
    static let sharedInstance = LogManager()
    var logs : NSMutableArray! = []
    var archive: NSMutableArray!{
       
        
        return [getArchives(), getArchives(), getArchives()]
    }
    
    
    func addlog() {
    
    let log1 = Log()
    log1.title = "Tiffy"
    log1.descriptions = "I took a paracetamol, but i still having cold"
    log1.date = "12:30 PM 09 June 2017"
    log1.monitoringDate = "Monitoring started 19 days ago"
    log1.reactionPhoto = ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg"]
    log1.medecinePhoto = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"]
        
    let log2 = Log()
        log2.title = "Sara"
        log2.descriptions = "I took a paracetamol, but i still getting hot"
        log2.date = "12:30 PM 09 June 2017"
        log2.monitoringDate = "Monitoring started 19 days ago"
        log2.reactionPhoto = ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg"]
        log2.medecinePhoto = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"]
        
        
    let log3 = Log()
        log3.title = "Paracetamol"
        log3.descriptions = "I took a paracetamol, but i still getting hotter"
        log3.date = "12:30 PM 09 June 2017"
        log3.monitoringDate = "Monitoring started 19 days ago"
        log3.reactionPhoto = ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg"]
        log3.medecinePhoto = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"]
        
    let log4 = Log()
        log4.title = "Tanason"
        log4.descriptions = "I took a tanason, but i still getting iggy"
        log4.date = "12:30 PM 09 June 2017"
        log4.monitoringDate = "Monitoring started 19 days ago"
        log4.reactionPhoto = ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"]
        log4.medecinePhoto = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"]
    logs = NSMutableArray(array: [log1, log2, log3, log4])
//        logs = NSMutableArray(array: [Log.init(titles: "Tiffy", descriptions: "I took a paracetamol, but i still having cold", medecinePhotos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"], reactionPhotos: ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg"],dates: "12:30 PM 09 June 2017", monitoringDates: "Monitoring started 19 days ago")!, Log.init(titles: "Sara", descriptions: "I took a paracetamol, but i still getting hot", medecinePhotos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"], reactionPhotos: ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg"],dates: "12:30 PM 09 June 2017", monitoringDates: "Monitoring started 19 days ago")!,Log.init(titles: "Paracetamol", descriptions: "I took a paracetamol, but i still getting headache", medecinePhotos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp"], reactionPhotos: ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg"],dates: "12:30 PM 09 June 2017", monitoringDates: "Monitoring started 19 days ago")!,Log.init(titles: "Anagon", descriptions: "I took a paracetamol, but i still getting iggy", medecinePhotos: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbHOLReBtMLyiYr3NWdpKORmTu5E_i3c4RNhETQT8sX2OZ0Ohp"], reactionPhotos: ["https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://i.ytimg.com/vi/OH2XPFbngvk/maxresdefault.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8UP5FHRnFvtED3eLfI_K5HHISXioco-6fJdgeMm4jieMq2a7W"],dates: "12:30 PM 09 June 2017", monitoringDates: "Monitoring started 19 days ago")! ])
        print("111")
    }
    private init() {
        if let logdata = UserDefaults.standard.object(forKey: "Logs") as? NSData{
            let tempararylog = NSKeyedUnarchiver.unarchiveObject(with: logdata as Data) as? NSArray
            if(tempararylog != nil){
                self.logs = NSMutableArray(array: tempararylog!)
            }
            else{
               
            }
            
            
        }
        else{
          
        }
    }
    func save(){
        let log = NSKeyedArchiver.archivedData(withRootObject: self.logs)
        UserDefaults.standard.set(log, forKey: "Logs")
        UserDefaults.standard.synchronize()
    }
    func deleteall(){
        var log = NSKeyedArchiver.archivedData(withRootObject: self.logs)
        log.removeAll()
        UserDefaults.standard.set(log, forKey: "Logs")
        UserDefaults.standard.synchronize()
    }
    
    func getArchives() -> Archive{
        return Archive.init(log: logs as! [Log])
    }
    func getLog() {
        print("Get Log")
    }
    
    func saveLog(){
        print("Save Log")
        
    }

    func updateLog(){
        print("Update")
    }
}
