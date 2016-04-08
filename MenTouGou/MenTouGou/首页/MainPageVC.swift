//
//  MainPageVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import Alamofire

class MainPageVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
//
    @IBOutlet weak var carSc: UIView!
    
    @IBOutlet weak var mtableView: UITableView!
    
    var carVC:NewCarouselVC!;
    
    var adverlistArr:NSArray!;//焦点图
    
    
    
//    MARK:- ----------------------
    
    func change(parmeters:AnyObject?) -> String? {
        //        为空就返回
        if (parmeters == nil) {
            return "";
        }
        //
        var returnStr:String = "?";
        
        if (parmeters is String) {
            
            return parmeters as? String;
            
        }else if (parmeters is NSDictionary){
            
            let dic = parmeters as! NSDictionary;
            
            for i in 0 ..< dic.allKeys.count {
                returnStr = returnStr + (dic.allKeys[i] as! String)  + "=" + (dic.objectForKey(dic.allKeys[i] as! String) as? String)!
                if (i != dic.allKeys.count - 1)  {
                    returnStr += "&";
                }
            }
            return returnStr;
        }
        
        
        return "";
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页";
        self.view.backgroundColor = UIColor.whiteColor();
        self.automaticallyAdjustsScrollViewInsets = false;
//        test
       Alamofire.request(.GET, MTG + GETADVERTLIST).responseJSON { (respon) in
        print("222222 = \(respon.description)");
        }
        
//        test
//焦点图下方
       self.adverlistArr = NSArray();
        
        let advertlistUrl = MTG + GETADVERTLIST;
        
        YHAFManager.yhGet(urlStr: advertlistUrl, parameters: nil, success: { (res) in
            
            self.adverlistArr = res as! NSArray;
            print(self.adverlistArr)
            
            self.mtableView.reloadData();
            })
        { (failedres) in
                
        };

        
//        print(Utils.getOwnID())
        
        
//        tableView
        self.mtableView.delegate = self;
        self.mtableView.dataSource = self;
        self.mtableView.backgroundColor = UIColor.whiteColor();
        self.mtableView.separatorStyle = .None;
        self.mtableView.showsVerticalScrollIndicator = false;
       
//   轮播图

//
        
        
//      轮播图http
        let getBannerListURL = MTG + GETBANNERLIST ;
        YHAFManager.yhGet(urlStr: getBannerListURL, parameters: nil, success: { (res) in
            let tempArr = res as! NSArray;
            
            let urlArr = NSMutableArray(capacity: 0);
            let imgArr = NSMutableArray(capacity: 0);
            for i in 0 ..< tempArr.count
            {
                urlArr.addObject((tempArr[i] as! NSDictionary)["LinkUrl"] as! String );
                imgArr.addObject((tempArr[i] as! NSDictionary)["ImageUrl"] as! String );
            }
            self.carVC = NewCarouselVC.init(frame: CGRectMake(0, 0, s_width, 140), withPicArr: imgArr as [AnyObject], withUrlArr: urlArr as [AnyObject]);
            self.carVC.type = imageurl;
            
            self.addChildViewController(self.carVC);
            self.carSc.frame = CGRectMake(0, 64, s_width, 140);
            self.carSc.addSubview(self.carVC.view);
            self.carVC.setTimeWithSecond(4);
            })
        { (failedRes) in
            
        }
        
    }

//   MARK:- tableview代理
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
//        三个按钮
            var cell:HeadCell? = tableView.dequeueReusableCellWithIdentifier("HeadCellIden")as? HeadCell;
            if (cell == nil) {
                let tempArr = NSBundle.mainBundle().loadNibNamed("HeadCell", owner: self, options: nil) as NSArray;
                cell = tempArr.lastObject as? HeadCell;
               
            }
                return cell!;
        }else{
//        全图
            var  cell:FullImageCell? = (tableView.dequeueReusableCellWithIdentifier("FullImageCellIden") as? FullImageCell);
            if cell == nil {
                let tempArr = NSBundle.mainBundle().loadNibNamed("FullImageCell", owner: self, options: nil) as NSArray;
                cell = (tempArr.lastObject as! FullImageCell);
            }
            cell?.setCell(imgUrl: (self.adverlistArr[indexPath.section - 1]as! NSDictionary)["ImageUrl"] as! String);
            return cell!;
            

        }

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
        return self.adverlistArr.count + 1;
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
