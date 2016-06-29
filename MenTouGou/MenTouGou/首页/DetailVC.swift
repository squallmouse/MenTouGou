//
//  DetailVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/18.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class DetailVC: BaseTableViewVC,LMComBoxViewDelegate {
    let option1:NSMutableArray = ["全部","休闲农业园","乡村观光旅游","农产品加工",];
    let option2:NSMutableArray = ["全部","潭柘寺镇","永定镇","龙泉镇","军庄镇","雁翅镇","斋堂镇","清水镇","妙峰山镇","王平镇",];
    let option3:NSMutableArray = ["不限","0-3KM","3-5KM","5-10KM",">10KM"];
    let option4:NSMutableArray = ["升序","降序"];
    
    var chooseOptionDict : NSMutableDictionary!;
    var resArr:NSMutableArray!;
    
    var chop1:String!;//类型
    var chop2:String!;//区域
    var chop3:String!;//时间
    var chop4:String!;//人气

    var contentArr : NSMutableArray!;
    var hud:MBProgressHUD!;

    override func viewWillDisappear(animated: Bool) {
        self.hud.hide(true);
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.resArr = NSMutableArray(capacity: 0);
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor.whiteColor();
        self.contentArr = NSMutableArray(capacity: 0);

        self.mtableView.frame = CGRectMake(0, 64 + 40 , s_width, s_height - 64 - 40 );
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
//                    Utils.urlStrConversion(urlStr: self!.chop2),
                "pvOrder":self!.chop4,
                "pageIndex":String(self!.page),
                "pageSize":PAGESIZE
            ];
            
            
            print((strUrl,paramaters ))
            return (strUrl,paramaters );
        };

        self.httpData(self.page);
        self.hud = Utils.creatHUD();
        self.title = option1[Int(chop1)!] as? String;
        
       
    }
    
    
    override func parserResult(res: AnyObject?) {
        self.hud.hide(true, afterDelay: 1);
        let arr = res as! NSArray;
        print("111 = \(arr)");
        self.resArr.addObjectsFromArray(arr as [AnyObject]);
        if self.dataArr.count == 0{
            self.contentArr.removeAllObjects();
        }
        for i in 0 ..< arr.count {
            let mo = DetailListModle(dic: arr[i] as! NSDictionary);
            self.dataArr.addObject(mo);
            self.contentArr.addObject(mo);
        }

        
    }
    //  MARK:-  tableView delegate
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.contentArr != nil {
            return self.contentArr.count;
        }
        return 0;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:DetailListCell? = tableView.dequeueReusableCellWithIdentifier("DetailListCellIden") as? DetailListCell;
        if cell == nil {
            cell = (NSBundle.mainBundle().loadNibNamed("DetailListCell", owner: self, options: nil)as NSArray).lastObject as? DetailListCell;
        }
        cell?.setCellWithModle(self.contentArr[indexPath.row]as! DetailListModle );
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath);
        let mo = self.contentArr[indexPath.row]as! DetailListModle;
//        let webDetail = WebDetailVC.init(withDataDic: self.resArr[indexPath.row]as! NSDictionary);
        let strID = NSString(format:"%@", mo.Id!)
        let webDetail = WebDetailVC.init(withProductID: (strID as String))

        self.navigationController?.pushViewController(webDetail, animated: true);
        
    }
    
//  MARK:-  other
    func setUpBGScrollView() -> Void {
        let keys = ["option1","option2","option3","option4"];
        let title = ["类型","区域","距离","人气"]
        for i in 0 ..< keys.count {
            let comBox = LMComBoxView(frame: CGRectMake(s_width/4 * CGFloat(i),64,s_width/4,40));
            //            comBox.backgroundColor = UIColor.redColor();
            comBox.arrowImgName = "ic_indication_arrow";
            let temparr = self.chooseOptionDict[keys[i]] ;
            comBox.titlesList = temparr as! NSMutableArray;
            comBox.delegate = self;
            comBox.supView = self.view;
            comBox.defaultSettings();
            comBox.tag = 1900 + i;
            self.view .addSubview(comBox);
            comBox.titleLabel.text = title[i] as String;
        }
    }
    

    func selectAtIndex(index: Int32, inCombox _combox: LMComBoxView!) {
        let tag = _combox.tag;
        switch tag {
        case 1900:
                chop1 = String(index);
                self.title = option1[Int(index)] as? String;

        case 1901:
            if index == 0 {
                chop2 = "";
            }else{
                chop2 = option2[Int(index)] as? String;
            }

        case 1902:
                chop3 = option3[Int(index)] as? String;
//                
                self.contentArr.removeAllObjects();
                self.mtableView.mj_footer.hidden = true;
                if index == 0 {

                    self.contentArr.addObjectsFromArray(self.dataArr as [AnyObject]);
                    self.mtableView.reloadData();
                    if self.contentArr.count == 0{
                        let hud = Utils.creatHUD();
                        hud.labelText = "暂无数据";
                        hud.hide(true, afterDelay: 1);
                    }
                    return;
                }

                for item in self.dataArr {

                    let mo = item as! DetailListModle;
                    let dis = Double(mo.distanct!);

                    if dis <= 3 && index == 1{
                        print("0-3");
                        self.contentArr.addObject(item);
                    }else if dis <= 5 && index == 2{
                        print("3-5");
                        self.contentArr.addObject(item);
                    }else if dis <= 10 && index == 3{
                        print("5-10");
                        self.contentArr.addObject(item);
                    }else if(dis >= 10 && index == 4){
                        print(">10");
                        self.contentArr.addObject(item);
                    }

                }
                self.mtableView.reloadData();
                if self.contentArr.count == 0{
                    let hud = Utils.creatHUD();
                    hud.labelText = "暂无数据";
                    hud.hide(true, afterDelay: 1);
                }
                return;
        case 1903:
            if index == 0 {
                chop4 = "Asc";
            }else{
                chop4 = "Desc"
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
