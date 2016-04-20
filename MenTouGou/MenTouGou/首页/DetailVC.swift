//
//  DetailVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/18.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class DetailVC: BaseTableViewVC,LMComBoxViewDelegate {
    let option1:NSMutableArray = ["全部","观光旅游","农产品加工","休闲农业园"];
    let option2:NSMutableArray = ["全部","清水镇","斋堂镇","雁翅镇","王平镇","妙峰山镇","军庄镇","龙泉镇","永定镇","谭拓寺镇"];
    let option3:NSMutableArray = ["升序","降序"];
    let option4:NSMutableArray = ["升序","降序"];
    
    var chooseOptionDict : NSMutableDictionary!;
    var resArr:NSMutableArray!;
    
    var chop1:String!;//类型
    var chop2:String!;//区域
    var chop3:String!;//时间
    var chop4:String!;//人气
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.resArr = NSMutableArray(capacity: 0);
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor.whiteColor();
        self.mtableView.frame = CGRectMake(0, 64 + 30 , s_width, s_height - 64 - 30 );
        self.chooseOptionDict = NSMutableDictionary.init(objects: [option1,option2,option3,option4], forKeys: ["option1","option2","option3","option4"]);
        chop2 = "";
        chop4 = "Desc";
        chop3 = "Desc";
        
        self.setUpBGScrollView();
        
        self.getUrl = {[weak self](page) in
            let strUrl = MTG + LEISURELIST + "/" + self!.chop1 + "?" ;
            let paramaters = [
//                接口少一个
                "area":self!.chop2,
                "pvOrder":self!.chop4,
                "pageIndex":String(self!.page),
                "pageSize":PAGESIZE
            ];
            
            
            print((strUrl,paramaters ))
            return (strUrl,paramaters );
        };
        
        self.httpData(self.page);
        self.title = option1[Int(chop1)!] as? String;
        
       
    }
    
    
    override func parserResult(res: AnyObject?) {
        
        let arr = res as! NSArray;
        print("111 = \(arr)");
        self.resArr.addObjectsFromArray(arr as [AnyObject]);
        for i in 0 ..< arr.count {
            let mo = DetailListModle(dic: arr[i] as! NSDictionary);
            self.dataArr.addObject(mo);
        }
        
        
    }
    //  MARK:-  tableView delegate
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DetailListCell? = tableView.dequeueReusableCellWithIdentifier("DetailListCellIden") as? DetailListCell;
        if cell == nil {
            cell = (NSBundle.mainBundle().loadNibNamed("DetailListCell", owner: self, options: nil)as NSArray).lastObject as? DetailListCell;
        }
        cell?.setCellWithModle(self.dataArr[indexPath.row]as! DetailListModle );
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath);
        //    跳转
//        let mo = self.dataArr[indexPath.row]as! DetailListModle ;
        let webDetail = WebDetailVC.init(withDataDic: self.resArr[indexPath.row]as! NSDictionary);
//        webDetail.dataDic = self.resArr[indexPath.row]as! NSDictionary;
//        webDetail.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(webDetail, animated: true);
        
    }
    
//  MARK:-  other
    func setUpBGScrollView() -> Void {
        let keys = ["option1","option2","option3","option4"];
        for i in 0 ..< keys.count {
            let comBox = LMComBoxView(frame: CGRectMake(s_width/4 * CGFloat(i),64,s_width/4,30));
            //            comBox.backgroundColor = UIColor.redColor();
            comBox.arrowImgName = "down_dark0.png";
            let temparr = self.chooseOptionDict[keys[i]] ;
            comBox.titlesList = temparr as! NSMutableArray;
            comBox.delegate = self;
            comBox.supView = self.view;
            comBox.defaultSettings();
            comBox.tag = 1900 + i;
            self.view .addSubview(comBox);
        }
    }
    

    func selectAtIndex(index: Int32, inCombox _combox: LMComBoxView!) {
        let tag = _combox.tag;
        switch tag {
        case 1900:
            chop1 = String(index);
            self.title = option1[Int(index)] as? String;
        case 1900:
            chop2 = String(index);
            self.title = chop1;
        case 1902:
            if index == 0 {
                chop2 = "Asc";
            }else{
                chop2 = "Desc"
            }
            
        case 1903:
            if index == 0 {
                chop3 = "Asc";
            }else{
                chop3 = "Desc"
            }
            
            
        default:
            break;
        }
        
        print("selected is \(chop1),\(chop2),\(chop3)");
        self.page = 1;
        self.httpData(self.page);
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
