//
//  MainPageVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class MainPageVC: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var carSc: UIView!
    
    @IBOutlet weak var mtableView: UITableView!
    
    var carVC:NewCarouselVC!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页";
        self.view.backgroundColor = UIColor.whiteColor();
        self.automaticallyAdjustsScrollViewInsets = false;
        print("width = \(s_width)");
        
//        tableView
        self.mtableView.delegate = self;
        self.mtableView.dataSource = self;
        self.mtableView.backgroundColor = UIColor.whiteColor();
        self.mtableView.separatorStyle = .None;
        self.mtableView.showsVerticalScrollIndicator = false;
       
//   轮播图

            print("33333333333 = \(self.carSc.bounds.size.width)");
            self.carVC = NewCarouselVC.init(frame: CGRectMake(0, 0, s_width, 140), withPicArr: ["1.jpg","1.jpg","1.jpg"], andimageType: imagename);
            self.addChildViewController(self.carVC);
            self.carSc.frame = CGRectMake(0, 64, s_width, 140);
            self.carSc.addSubview(self.carVC.view);
        
    }

//   MARK:- tableview代理
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell = tableView .dequeueReusableCellWithIdentifier("HeadCellIden");
            if (cell == nil) {
                let tempArr = NSBundle.mainBundle().loadNibNamed("HeadCell", owner: self, options: nil) as NSArray;
                cell = tempArr.lastObject as! HeadCell;
               
            }
                return cell!;
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("FullImageCellIden");
            if (cell == nil) {
                let tempArr = NSBundle.mainBundle().loadNibNamed("FullImageCell", owner: self, options: nil) as NSArray;
                cell = tempArr.lastObject as! FullImageCell;
            }
            return cell!;
        }
//        return nil;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0) {
            return;
        }else{
            print("section did selected = \(indexPath.section)");
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150;
    }
    
//    MARK: - other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
