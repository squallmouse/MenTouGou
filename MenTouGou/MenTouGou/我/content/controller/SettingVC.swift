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
        
        cacheLab = UILabel();
        cacheLab.text = "3.3MB";
        cacheLab.textAlignment = .Right;
        
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
            cacheLab.frame = CGRectMake(s_width - 100, 0, 90, 50);
            cell.addSubview(cacheLab);
        }else if row == 2{
            
        }else{
            cell.accessoryType = .DisclosureIndicator;
        }
        
        return cell;
    }
//  MARK:-  other
    
    @IBAction func outBtnClickDown(sender: AnyObject) {
        
        print("退出按钮按下");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
