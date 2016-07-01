//
//  MainPageVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import Alamofire


class MainPageVC: UIViewController,UITableViewDelegate,UITableViewDataSource,collectionViewCellDelegate,UMComLoginDelegate{
//

    var carSc:UIView!; //tableview headview
    @IBOutlet weak var mtableView: UITableView!
    
    var carVC:NewCarouselVC!;
    
    var adverlistArr:NSArray!;//焦点图
    var headHight :CGFloat = 220;
    
    
//    MARK:- ----------------------
    


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBarHidden = false;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页";
       
         UMComLoginManager.setLoginHandler(self);
        self.view.backgroundColor = UIColor.colorWithHexString("F5F6F7");
        self.automaticallyAdjustsScrollViewInsets = false;

        self.adverlistArr = NSArray();
        
        //        tableView
        self.mtableView.delegate = self;
        self.mtableView.dataSource = self;
        self.mtableView.backgroundColor = UIColor.whiteColor();
        self.mtableView.separatorStyle = .None;
        self.mtableView.showsVerticalScrollIndicator = false;
//        self.mtableView.bounces = false;
        self.headHight = s_width * self.headHight / CGFloat(375);
        self.carSc = UIView(frame: CGRectMake(0, 0, s_width, self.headHight));

        self.mtableView.tableHeaderView = self.carSc;
        self.mtableView.tableHeaderView?.clipsToBounds = false;
        self.mtableView.clipsToBounds = false;

        self.httpreq();

        self.mtableView.mj_header = MJRefreshHeader(refreshingBlock: { 
            self.httpreq();
            self.mtableView.mj_header.endRefreshing();
        });
////焦点图 下方
//       self.adverlistArr = NSArray();
//        
//        let advertlistUrl =  MTG + GETBANNERLIST ;
//
//        YHAlamofire.Get(urlStr: advertlistUrl, paramters: nil, success: { (res) in
//
//            self.adverlistArr = res as! NSArray;
//            print(self.adverlistArr)
//
//            self.mtableView.reloadData();
//
//        }) { (failedres) in
//
//            let hud = Utils.creatHUD();
//            hud.labelText = "当前网络不稳定，换个姿势试试";
//            hud .hide(true, afterDelay: 2);
//
//        }
//
//
//
////   轮播图
//
//        
////      轮播图http
//        let getBannerListURL = MTG + GETADVERTLIST;
//
//        YHAlamofire.Get(urlStr: getBannerListURL, paramters: nil, success: { (res) in
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
//            }) { (failedRes) in
//
//        }

    }

//  MARK:-  网络请求
    func httpreq()  {
        //焦点图 下方


        let advertlistUrl =  MTG + GETBANNERLIST ;

        YHAlamofire.Get(urlStr: advertlistUrl, paramters: nil, success: { (res) in

            self.adverlistArr = res as! NSArray;
            print(self.adverlistArr)

            self.mtableView.reloadData();

        }) { (failedres) in

            let hud = Utils.creatHUD();
            hud.labelText = "当前网络不稳定，换个姿势试试";
            hud .hide(true, afterDelay: 2);

        }


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



    }

//   MARK:- tableview代理
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
//        9个按钮

            var cell:MainListCell? = tableView.dequeueReusableCellWithIdentifier("MainListCellIden")as? MainListCell ;

            if (cell == nil) {
                cell = ((NSBundle.mainBundle().loadNibNamed("MainListCell", owner: self, options: nil)as NSArray ).lastObject as! MainListCell);
                cell?.delegate = self;

            }

            cell?.selectionStyle = .None;

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
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var tempView =  tableView.dequeueReusableHeaderFooterViewWithIdentifier("mainPageHeadViewIden");
//        if tempView == nil {
//            tempView = UITableViewHeaderFooterView.init();
//
//            tempView?.frame = CGRectMake(0, 0, 300, 10);
//            tempView?.backgroundColor = UIColor.redColor();
////            UIColor.colorWithHexString("F5F6F7");
//        }
//        return tempView as? UIView;
//    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0;
        }
        return 7;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.adverlistArr.count + 1;
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return 180;
        }
        return (s_width * CGFloat(15) / CGFloat(32));
    }

    func back(btnTag: Int) {
        print("\(btnTag)")


        switch btnTag {
        case 2000:
//           聚焦三农
            let  vc =  InfomationVC();
            vc.chop1 = "7";
            vc.title = "聚焦三农";
            vc.hidesBottomBarWhenPushed = true;
            
            self.navigationController?.pushViewController(vc, animated: true);

        case 2001:
//            休闲农业
            let  vc =  DetailVC();
            vc.chop1 = "0";
            vc.title = "休闲农业";
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);

        case 2002:
//            旅游导航
            let  vc =  InfomationVC();
            vc.chop1 = "2";
            vc.title = "旅游导航";
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);


        case 2003:
//            微相册
            let  vc =  InfomationVC();
            vc.chop1 = "6";
            vc.title = "微相册";
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);

        case 2004:
//            特产超市
            let  vc =  ProductVC();
            vc.typeValue = "";
            vc.title = "特产超市";
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);

        case 2005:
//            京西拾取
            let  vc =  InfomationVC();
            vc.chop1 = "8";
            vc.title = "京西拾趣";
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);
        case 2006:
//            媒体聚焦
            let  vc =  InfomationVC();
            vc.chop1 = "5";
            vc.title = "媒体聚焦";
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);

        case 2007:
//          微社区

            let vc = UMCommunity.getFeedsModalViewController();
//            let rootVC = UINavigationController(rootViewController: vc);
            self.presentViewController(vc, animated: true, completion: nil);
        default:
            break;
            
        }


    }

    func presentLoginViewController(viewController: UIViewController!, finishResponse completion: ((AnyObject!, NSError!) -> Void)!) {
        print("微社区登录");
        let SB = UIStoryboard.init(name: "Main", bundle: nil);
        let logVC:LoginVC = SB.instantiateViewControllerWithIdentifier("LoginVC")as! LoginVC;
        logVC.vcType = "微社区";

        let appRootVC = UIApplication.sharedApplication().keyWindow?.rootViewController;
        var topVC = appRootVC;
        if (topVC?.presentedViewController != nil) {
            topVC = topVC?.presentedViewController;
        }

        topVC?.presentViewController(logVC, animated: true, completion: nil);

    }

//    MARK: - other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
