//
//  InfomationVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//
//        let option1 = ["观光旅游","农产品加工","休闲农业园"];
//        let option2 = ["清水镇","斋堂镇","雁翅镇","王平镇","妙峰山镇","军庄镇","龙泉镇","永定镇","谭拓寺镇"];
import UIKit

class InfomationVC: BaseTableViewVC,LMComBoxViewDelegate {
    let option1:NSMutableArray = ["全部","产品资讯","旅游资讯","企业资讯"];
    let option2:NSMutableArray = ["升序","降序"];
    let option3:NSMutableArray = ["升序","降序"];
    
    var chooseOptionDict : NSMutableDictionary!;
    
    var chop1:String!;//类型
    var chop2:String!;//时间
    var chop3:String!;//人气

//    var url : (String! , [String : AnyObject]?)!;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor.whiteColor();
        self.chooseOptionDict = NSMutableDictionary.init(objects: [option1,option2,option3], forKeys: ["option1","option2","option3"]);
        print(self.chooseOptionDict);
        chop1 = "0";
        chop2 = "Desc";
        chop3 = "Desc";
        self.setUpBGScrollView();
//        url = ("http",["123":"321"]);
//        print(url.0);
//        print(url.1);
        
//        请求
        self.getUrl = {[weak self](page) in
            let strUrl = MTG + NEWLIST + self!.chop1 + "?" ;
            let paramaters = [

                "timeOrder":"Desc",
                "pvOrder":"Desc",
                "pageIndex":String(self!.page),
                "pageSize":PAGESIZE
                    ];
          
            
            print((strUrl,paramaters ))
            return (strUrl,paramaters );
        };
        
        self.httpData(self.page);
        
    }
//  MARK:-  解析数据
//解析数据
    
    override func parserResult(res: AnyObject?) {
        
        let arr = res as! NSArray;
        print("111 = \(arr)");
        for i in 0 ..< arr.count {
            let mo = InfoCellModle(dic: arr[i] as! NSDictionary);
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
    var cell:InfoCell? = tableView.dequeueReusableCellWithIdentifier("InfoCellIden") as? InfoCell;
    if cell == nil {
        cell = (NSBundle.mainBundle().loadNibNamed("InfoCell", owner: self, options: nil)as NSArray).lastObject as? InfoCell;
    }
    cell?.setCellWithModle(self.dataArr[indexPath.row]as! InfoCellModle );
    return cell!;
    }
    
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    super.tableView(tableView, didSelectRowAtIndexPath: indexPath);
//    跳转
    let mo = self.dataArr[indexPath.row]as! InfoCellModle ;
    let ID = NSString(format: "%@", mo.Id!) as String;
    let vc = InfoWebVC(withID: ID);
    vc.hidesBottomBarWhenPushed = true;
    self.navigationController?.pushViewController(vc, animated: true);
    
    }
    
//    MARK:- 下拉列表初始化 和 选择
    func setUpBGScrollView() -> Void {
        let keys = ["option1","option2","option3"];
        for i in 0 ..< keys.count {
            let comBox = LMComBoxView(frame: CGRectMake(s_width/3 * CGFloat(i),64,s_width/3,30));
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
        case 1901:
            if index == 0 {
                 chop2 = "Asc";
            }else{
                chop2 = "Desc"
            }
           
        case 1902:
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
    
    
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
