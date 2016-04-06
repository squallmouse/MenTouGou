//
//  MyHomePageVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class MyHomePageVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate {

    let titleArr = ["","登陆邮箱","个性签名","性别","年龄","所在地","修改密码"] ;
    var contentArr:NSMutableArray! ;
    
    @IBOutlet weak var mtableView: UITableView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.contentArr = NSMutableArray(capacity: 0);
        
        for _ in 0 ..< 10 {
            self.contentArr.addObject("haohaohao");
        }
        
        
        
        self.mtableView.dataSource = self;
        self.mtableView.delegate = self;
        self.mtableView.separatorStyle = .None;
      
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell:MyHeadCell? = tableView.dequeueReusableCellWithIdentifier("MyHeadCellIden")as? MyHeadCell;
            if (cell == nil) {
                let tempArr = NSBundle.mainBundle().loadNibNamed("MyHeadCell", owner: self, options: nil) as NSArray;
                cell = tempArr.lastObject as? MyHeadCell;
            }
            return cell!;
            
        }else{
            var cell:MyOtherCell? = tableView.dequeueReusableCellWithIdentifier("MyOtherCellIden") as? MyOtherCell;
            if (cell == nil) {
                let tempArr = NSBundle.mainBundle().loadNibNamed("MyOtherCell", owner: self, options: nil) as NSArray;
                cell = tempArr.lastObject as? MyOtherCell;
                
            }
            if (indexPath.section == 1) {
                cell?.selectionStyle = .None;
                cell?.setCell(title: titleArr[indexPath.section], andContent:contentArr[indexPath.section] as! String, ImgHidden: true);
            }else{
                cell?.setCell(title: titleArr[indexPath.section], andContent:contentArr[indexPath.section] as! String, ImgHidden: false);
            }
            
            
            
            return cell!;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        let section = indexPath.section;
        switch section {
        case 2:
//      个性签名
            print("个性签名");
        case 3:
//      性别
            print("性别");
            self.chooseSex();
        case 4:
//      年龄
            print("年龄");
        case 5:
//      所在地
            print("所在地");
        case 6:
//      修改密码"
            print("修改密码");
        default:
            break;
        }
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 100;
        }else{
            return 60;
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return titleArr.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.01;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10;
    }
    
    
//   MARK:- 设置页面
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GoToSettingVC") {
            let setvc:SettingVC! = segue.destinationViewController as! SettingVC;
            setvc.title = "我屮艸芔茻";
        }
    }
    
    @IBAction func settingBtnClickDown(sender: AnyObject) {
        
//        跳转设置页面
        
        self .performSegueWithIdentifier("GoToSettingVC", sender: self);
        
    }
//    MARK:- tableview 点击的跳转
    
//  MARK:-  性别
    func chooseSex() -> Void {
        let sheet:UIActionSheet = UIActionSheet(title: "请您选择性别", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "男", "女");
        sheet.showInView(self.view);
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex);
//        男 1 女 2
        var sex:String!;
        if (buttonIndex == 1) {
            sex = "男"
        }else if(buttonIndex == 2){
            sex = "女";
        }
        self.contentArr.replaceObjectAtIndex(3, withObject: sex);
        self.mtableView.reloadData();
//        数据上传
        
    }
    
 //  MARK:-  年龄
    //  MARK:-  所在地

    
    
//    MARK:- other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
