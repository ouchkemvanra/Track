//
//  AppDelegate.swift
//  Track
//
//  Created by ty on on 5/16/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SWRevealViewControllerDelegate {

    var window: UIWindow?

   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
      /*  let mainController = DashboardViewController() as UIViewController
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.isTranslucent = false
        let mainViewController   = DashboardViewController()
        let drawerViewController = MenuViewController()
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        
        drawerController.mainViewController = UINavigationController(
            rootViewController: mainViewController
        )
        drawerController.drawerViewController = drawerViewController
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = drawerController
        */
        let frontNavigationController:UINavigationController
       
        let revealController = SWRevealViewController()
        var mainRevealController = SWRevealViewController()
        
        let sidebar = MenuViewController()
        
        let homepage = DashboardViewController()
        
        frontNavigationController =  UINavigationController(rootViewController: homepage)
        //rearNavigationController = sidebar
        
        revealController.frontViewController = frontNavigationController
        revealController.rearViewController = sidebar
       // revealController.delegate = self
        //revealController.rearViewRevealWidth
        revealController.rearViewRevealOverdraw = 0
        
        mainRevealController  = revealController
        
        self.window?.rootViewController = mainRevealController

       // self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        //UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(30, -50.0), for: .default)
        // Override point for customization after application launch.
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

}
 private let DimmingViewTag = 10001

