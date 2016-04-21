//
//  SettingVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/6.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class SettingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mtableView: UITableView!
    var switchBtn:UISwitch!;
    var cacheLab:UILabel!;
    
    @IBOutlet weak var outBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.outBtn.layer.masksToBounds = true;
        self.outBtn.layer.cornerRadius = 5;
        
        self.mtableView.dataSource = self;
        self.mtableView.delegate = self;
        self.mtableView.bounces = false;
        self.mtableView.rowHeight = 50;
        self.mtableView.separatorStyle = .SingleLineEtched;
// 缓存
        cacheLab = UILabel();
        cacheLab.textAlignment = .Right;
        dispatch_async(dispatch_get_main_queue()) { 
//            获取缓存
            self.cacheLab.text = Utils.getCacheSize();
            
        };
        
//
        self.switchBtn = UISwitch();
        self.switchBtn.addTarget(self, action: #selector(SettingVC.switchBtnChange), forControlEvents: .ValueChanged);
        self.switchBtn.on = Utils.isRegiestNoti();
//        
        
    }
//    MARK: - SWITCH BTN
    func switchBtnChange() -> Void {
        if switchBtn.on {
        UMessage.registerForRemoteNotificationTypes([ .Badge, .Sound, .Alert ]);
          
            print("ononon");
        }else{
            print("closeclose");
            UMessage.unregisterForRemoteNotifications();
        }
    }
//  MARK:-  tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row;
        let titleArr = ["清理缓存","意见反馈","消息推送设置","关于我们"];
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: nil);
        
        cell.textLabel?.text = titleArr[row];
        
        if row == 0 {
            cacheLab.frame = CGRectMake(s_width - 100, 0, 85, 50);
            cell.addSubview(cacheLab);
        }else if row == 2{
                self.switchBtn.frame = CGRectMake(s_width - 60, 0, 60, 50);
            cell.addSubview(self.switchBtn);
        }else{
            cell.accessoryType = .DisclosureIndicator;
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        if indexPath.row == 0 {
//清理缓存  
            Utils.clearCache();
            self.cacheLab.text = "0.0M";
        }
    }
    
//  MARK:-  other
    
    @IBAction func outBtnClickDown(sender: AnyObject) {
        
        print("退出按钮按下");
        let user = NSUserDefaults.standardUserDefaults();
        user.setValue("0", forKey: "userID");
        user.synchronize();
//        刷新首页
        NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "refreshUser", object: nil));
//        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "tabbarSelected", object: nil));
//        
        self.navigationController?.popToRootViewControllerAnimated(false);
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
