//
//  YHTabBarVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class YHTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        
        
        
//       init Five VC
        let SBNameArr = ["MainPage","Infomation","Product","Around","MyHomePage"];
        let SBIDArr = ["MainPageSBID","InfomationSBID","ProductSBID","AroundSBID","MyHomePageSBID"];
 
        self.tabBar.translucent = false;
        self.viewControllers = self.childViewControllerInit(SBNameArr, SBIDARR: SBIDArr) as? [UIViewController] ;
  
//        tabbar.items
        let titles = ["首页", "市场", "农场品", "周边", "我"];
        let images = ["ic_home_def","ic_information_def","ic_farm_produce_def","ic_perimeter_def","ic_my_def"];
        let selimages = ["ic_home_sel","ic_information_sel","ic_farm_produce_sel","ic_perimeter_sel","ic_my_sel"];
        ((self.tabBar.items)!as NSArray).enumerateObjectsUsingBlock { (item, index, stop) in
            let tempItem = item as! UITabBarItem;
            tempItem.title = titles[index];
            tempItem.image = UIImage(named: images[index])?.imageWithRenderingMode(.AlwaysOriginal);
            tempItem.selectedImage = UIImage(named: selimages[index])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            tempItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.colorWithHexString("FFFAA8")], forState: .Selected);
            tempItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: .Normal);
            
        }
//        
        self.tabBar.barTintColor = UIColor.mainColor();

//    通知 selected
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YHTabBarVC.changePage), name: "tabbarSelected", object: nil);
    }
//  MARK:-  通知selected
    func changePage() -> Void {
        self.selectedIndex = 0;
    }
    
//  MARK : - 初始化5个VC
    func childViewControllerInit(sbNameArr:NSArray, SBIDARR SBIDarr:NSArray) -> NSArray {
        let tempArr = NSMutableArray(capacity: 5);
        for i in 0  ..< SBIDarr.count {
            let SBName = UIStoryboard(name: sbNameArr[i] as! String, bundle: nil);
            let vc = SBName.instantiateViewControllerWithIdentifier(SBIDarr[i] as! String) ;
            let Nav = UINavigationController.init(rootViewController: vc);
//            
            Nav.navigationBar.barTintColor = UIColor.mainColor();
            Nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()];
            tempArr.addObject(Nav);
        } 
        return tempArr;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
