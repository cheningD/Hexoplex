//
//  AppDelegate.swift
//  Hexoplex
//
//  Created by Yeshwanth Devabhaktuni on 10/5/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        application.applicationIconBadgeNumber = 0
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var firstAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "Accept"
        firstAction.title = "Accept"
        
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = true
        firstAction.authenticationRequired = false
        
        var secondAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "Decline"
        secondAction.title = "Decline"
        
        secondAction.activationMode = UIUserNotificationActivationMode.Background
        secondAction.destructive = false
        secondAction.authenticationRequired = false
        
        var firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "first_category"
        
        let defaultActions:NSArray = [firstAction, secondAction]
        
        firstCategory.setActions(defaultActions as! [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Default)
        
        let categories:NSSet = NSSet(objects: firstCategory)
        
        
        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: categories as! Set<UIUserNotificationCategory>))
        }
        // Override point for customization after application launch.
        return true
    }
    func application(application: UIApplication!, handleActionWithIdentifier identifier:String!, forLocalNotification notification:UILocalNotification!, completionHandler: (() -> Void)!){
        
        if(identifier == "Accept")
        {
            NSNotificationCenter.defaultCenter().postNotificationName("actionOnePressed", object:nil)
        }
        else
        {
            completionHandler()
        }
        
        completionHandler()
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

