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

    var carSc:UIView!; //tableview headview
    @IBOutlet weak var mtableView: UITableView!
    
    var carVC:NewCarouselVC!;
    
    var adverlistArr:NSArray!;//焦点图
    var headHight :CGFloat = 220;
    
    
//    MARK:- ----------------------
    
/*
     
*/

    override func viewWillAppear(animated: Bool) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页";


        self.view.backgroundColor = UIColor.whiteColor();
        self.automaticallyAdjustsScrollViewInsets = false;

//焦点图 下方
       self.adverlistArr = NSArray();
        
        let advertlistUrl =  MTG + GETBANNERLIST ;

        YHAlamofire.Get(urlStr: advertlistUrl, paramters: nil, success: { (res) in

            self.adverlistArr = res as! NSArray;
            print(self.adverlistArr)

            self.mtableView.reloadData();

        }) { (failedres) in

        }

//        YHAFManager.yhGet(urlStr: advertlistUrl, parameters: nil, success: { (res) in
//            
//            self.adverlistArr = res as! NSArray;
//            print(self.adverlistArr)
//            
//            self.mtableView.reloadData();
//            })
//        { (failedres) in
//                
//        };

//        tableView
        self.mtableView.delegate = self;
        self.mtableView.dataSource = self;
        self.mtableView.backgroundColor = UIColor.whiteColor();
        self.mtableView.separatorStyle = .None;
        self.mtableView.showsVerticalScrollIndicator = false;

        self.headHight = s_width * self.headHight / CGFloat(375);
        self.carSc = UIView(frame: CGRectMake(0, 0, s_width, self.headHight));

        self.mtableView.tableHeaderView = self.carSc;
        self.mtableView.tableHeaderView?.clipsToBounds = false;
        self.mtableView.clipsToBounds = false;
//   轮播图

//
        
        
//      轮播图http
        let getBannerListURL = MTG + GETADVERTLIST;

        YHAlamofire.Get(urlStr: getBannerListURL, paramters: nil, success: { (res) in
            let tempArr = res as! NSArray;

            let urlArr = NSMutableArray(capacity: 0);
            let imgArr = NSMutableArray(capacity: 0);
            for i in 0 ..< tempArr.count
            {
                urlArr.addObject((tempArr[i] as! NSDictionary)["LinkUrl"] as! String );
                imgArr.addObject((tempArr[i] as! NSDictionary)["ImageUrl"] as! String );
            }
            self.carVC = NewCarouselVC.init(frame: CGRectMake(-5, 0, s_width + 10, self.headHight), withPicArr: imgArr as [AnyObject], withUrlArr: urlArr as [AnyObject]);

            self.carVC.type = imageurl;
            self.carVC.picClickDown = {[weak self](url)->Void in
                print(url);

                let LinkUrl = url as NSString;
                if LinkUrl.hasPrefix("http://") {
                    //                网页
                    let web = WebViewVC.init(url: url as String);
                    web.hidesBottomBarWhenPushed = true;
                    self!.navigationController?.pushViewController(web, animated: true);
                }else{
                    //                资讯详情页
                    let webDetail = WebDetailVC.init(withProductID: url as String);
                    webDetail.hidesBottomBarWhenPushed = true;
                    self!.navigationController?.pushViewController(webDetail, animated: true);

                }
            };
            self.addChildViewController(self.carVC);

            self.carSc.addSubview(self.carVC.view);
            self.carVC.setTimeWithSecond(4);
            }) { (failedRes) in

        }

//        YHAFManager.yhGet(urlStr: getBannerListURL, parameters: nil, success: { (res) in
//            let tempArr = res as! NSArray;
//            
//            let urlArr = NSMutableArray(capacity: 0);
//            let imgArr = NSMutableArray(capacity: 0);
//            for i in 0 ..< tempArr.count
//            {
//                urlArr.addObject((tempArr[i] as! NSDictionary)["LinkUrl"] as! String );
//                imgArr.addObject((tempArr[i] as! NSDictionary)["ImageUrl"] as! String );
//            }
//            self.carVC = NewCarouselVC.init(frame: CGRectMake(-5, 0, s_width + 10, self.headHight), withPicArr: imgArr as [AnyObject], withUrlArr: urlArr as [AnyObject]);
//    
//            self.carVC.type = imageurl;
//            self.carVC.picClickDown = {[weak self](url)->Void in
//                print(url);
//                
//                let LinkUrl = url as NSString;
//                if LinkUrl.hasPrefix("http://") {
//                    //                网页
//                    let web = WebViewVC.init(url: url as String);
//                    web.hidesBottomBarWhenPushed = true;
//                    self!.navigationController?.pushViewController(web, animated: true);
//                }else{
//                    //                资讯详情页
//                    let webDetail = WebDetailVC.init(withProductID: url as String);
//                    webDetail.hidesBottomBarWhenPushed = true;
//                    self!.navigationController?.pushViewController(webDetail, animated: true);
//                    
//                }
//            };
//            self.addChildViewController(self.carVC);
//
//            self.carSc.addSubview(self.carVC.view);
//            self.carVC.setTimeWithSecond(4);
//            })
//        { (failedRes) in
//            
//        }

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
            cell?.selectionStyle = .None;
            cell?.btnClickDown = {[weak self](tag)->Void in
                print("btn.tag = \(tag)");
                let vc = DetailVC();
                vc.chop1 = NSString(format: "%d", (tag - 1700 )) as String;
                vc.hidesBottomBarWhenPushed = true;
                self!.navigationController?.pushViewController(vc, animated: true);
            };
                return cell!;
        }else{
//        全图cell
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

        tableView.deselectRowAtIndexPath(indexPath, animated: true);

        if (indexPath.section == 0) {
            return;
        }else{
            print("section did selected = \(indexPath.section)");
           let dic = self.adverlistArr[indexPath.section - 1] as! NSDictionary;
            let LinkUrl = dic["LinkUrl"] as! NSString;

            if LinkUrl.hasPrefix("http://") {
//                网页

                let web = WebViewVC.init(url: dic["LinkUrl"] as! String);
                web.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(web, animated: true);
            }else{
//                详情页
                let webDetail = InfoWebVC.init(withID: dic["LinkUrl"] as! String);
//                    WebDetailVC.init(withProductID: dic["LinkUrl"] as! String);
                webDetail.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(webDetail, animated: true);
            
            }
            
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

        if indexPath.section == 0 {
            return 150;
        }
        return (s_width * CGFloat(15) / CGFloat(32));
    }


//    MARK: - other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
