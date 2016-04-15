//
//  AppDelegate.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
//      设置控件外观
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true);
        UIApplication.sharedApplication().statusBarStyle = .LightContent;
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor();
        
//  Umeng 消息推送
        UMessage.startWithAppkey("56976da967e58e6412001760", launchOptions: launchOptions );
    
        let action1 = UIMutableUserNotificationAction();
        action1.identifier = "action1_identifier";
        action1.title = "接受";
        action1.activationMode = UIUserNotificationActivationMode.Foreground;
        
        let action2 = UIMutableUserNotificationAction();
        action2.identifier = "action2_identifier";
        action2.title = "拒绝";
        action2.activationMode = UIUserNotificationActivationMode.Background;
        action2.authenticationRequired = true;
        action2.destructive = true;
        
        let categorys = UIMutableUserNotificationCategory();
        categorys.identifier = "category1";
        categorys.setActions([action1,action2], forContext: .Default);
        
        let userSettings = UIUserNotificationSettings(forTypes: [.Badge,.Sound,.Alert], categories: NSSet(object: categorys) as! Set<UIUserNotificationCategory>);
        UMessage.registerRemoteNotificationAndUserNotificationSettings(userSettings);
        UMessage.setLogEnabled(true);
        
//
//        关闭推送
//        UMessage.unregisterForRemoteNotifications();
        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("deviceToken = \(deviceToken)");
        UMessage.registerDeviceToken(deviceToken);
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("userInfo = \(userInfo)");
        UMessage.didReceiveRemoteNotification(userInfo);
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

