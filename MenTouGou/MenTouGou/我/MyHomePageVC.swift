//
//  MyHomePageVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class MyHomePageVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate {

    let titleArr = ["","登录邮箱","个性签名","性别","年龄","所在地","修改密码"] ;
    var contentArr:NSMutableArray! ;
    var dataDic:NSDictionary!;
    var nextPageTitle:String!;//个性签名 和 所在地
    var nextPageTag:String!;//下一页的标签
    var hud : MBProgressHUD!;
    @IBOutlet weak var mtableView: UITableView!;
    
    
    override func viewWillAppear(animated: Bool) {
        if Utils.getOwnID() == "0" {
            let SB = UIStoryboard.init(name: "Main", bundle: nil);
            let vc:LoginVC = (SB.instantiateViewControllerWithIdentifier("LoginVC") as? LoginVC)!;
            vc.navigationItem.setHidesBackButton(true, animated: false);
//            vc.navigationController?.navigationBar.
            self.navigationController?.pushViewController(vc, animated: false);

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.contentArr = NSMutableArray(capacity: 0);
        
        for _ in 0 ..< 10 {
            self.contentArr.addObject("");
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyHomePageVC.refreshSelf), name: "refreshUser", object: nil);
        
        self.mtableView.dataSource = self;
        self.mtableView.delegate = self;
        self.mtableView.separatorStyle = .None;


        if Utils.getOwnID() != "0" {

            self.refreshSelf();
        }
    }

//  MARK:-  通知
    func refreshSelf() -> Void {
//        
        print("refreshSelf");
        self.hud = Utils.creatHUD();
        YHAlamofire.Get(urlStr: MTG + USERINFO + Utils.getOwnID(), paramters: nil, success: { (res) in
            print(res);
            self.hud.hide(true, afterDelay: 0);
            self.dataDic = res as? NSDictionary;
            self.paraserWithDic(self.dataDic);
            self.mtableView.reloadData();
            }) { (failedRes) in
             self.hud.hide(true, afterDelay: 0);   
        }
        
    }
    func paraserWithDic(dic:NSDictionary) -> Void {
        self.contentArr.removeAllObjects();
//        用户名
    self.contentArr.addObject(Utils.changeNullToEmptyStr(self.dataDic["UserName"]));
//        邮箱
    self.contentArr.addObject(Utils.changeNullToEmptyStr(self.dataDic["Email"]));
//        个性签名
    self.contentArr.addObject(Utils.changeNullToEmptyStr(self.dataDic["Name"]));
//        性别
    self.contentArr.addObject(Utils.changeNullToEmptyStr(self.dataDic["Subject"]));
//        个性签名
    self.contentArr.addObject(Utils.changeNullToEmptyStr(self.dataDic["Grade"]));
//        所在地
    self.contentArr.addObject(Utils.changeNullToEmptyStr(self.dataDic["Professional"]));
//        修改密码
        self.contentArr.addObject("");


    }
    
//  MARK:-  tableView delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell:MyHeadCell? = tableView.dequeueReusableCellWithIdentifier("MyHeadCellIden")as? MyHeadCell;
            if (cell == nil) {
                let tempArr = NSBundle.mainBundle().loadNibNamed("MyHeadCell", owner: self, options: nil) as NSArray;
                cell = tempArr.lastObject as? MyHeadCell;
            }
            cell?.selectionStyle = .None;
            cell?.nameLab.text = contentArr[indexPath.section] as? String
            return cell!;
            
        }else{
            var cell:MyOtherCell? = tableView.dequeueReusableCellWithIdentifier("MyOtherCellIden") as? MyOtherCell;
            if (cell == nil) {
                let tempArr = NSBundle.mainBundle().loadNibNamed("MyOtherCell", owner: self, options: nil) as NSArray;
                cell = tempArr.lastObject as? MyOtherCell;
                
            }
            if (indexPath.section == 1) {
                cell?.selectionStyle = .None;
                cell?.setCell(title: titleArr[indexPath.section], andContent:contentArr[indexPath.section] as? String, ImgHidden: true);
                if (contentArr[indexPath.section] as? String)?.characters.count == 0{
                    let user = NSUserDefaults.standardUserDefaults();
                    let emailStr = user.objectForKey(Utils.getOwnID());
                    if emailStr != nil {
                        cell?.contentLab.text = emailStr as? String;
                    }
                }

            }else{
                cell?.setCell(title: titleArr[indexPath.section], andContent:(contentArr[indexPath.section] as! String), ImgHidden: false);
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
            nextPageTitle = "个性签名";
            self.performSegueWithIdentifier("GoToSignatureVC", sender: self);
            
        case 3:
//      性别
            print("性别");
            self.chooseSex();
        case 4:
//      年龄
            self.updateAge();
            print("年龄 用pickview");
        case 5:
//      所在地
            print("所在地");
            nextPageTitle = "所在地";
            self.performSegueWithIdentifier("GoToSignatureVC", sender: self);
        case 6:
//      修改密码"
            print("修改密码");
            self.performSegueWithIdentifier("GoToChangePasswordVC", sender: self);
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
    
    

//      MARK: - 界面变化
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if(segue.identifier == "GoToSignatureVC"){
            let signature:SignatureVC! = segue.destinationViewController as! SignatureVC;
            
            signature.title = nextPageTitle;
            if nextPageTitle == "个性签名" {
                signature.titleLabStr = "请输入个性签名";
            }else{
                signature.titleLabStr = "请输入所在地";
            }
            
            
            signature.myBlock = {[weak self](str) in
                if str == nil {
                    return;
                }
                if self!.nextPageTitle == "个性签名" {
                  self!.contentArr.replaceObjectAtIndex(2, withObject: str!);
                }else if( self!.nextPageTitle == "所在地"){
                    self!.contentArr.replaceObjectAtIndex(5, withObject: str!);
                }
                self!.mtableView.reloadData();
            }
            
        }
        
    }
    
 //   MARK:- 设置页面
    @IBAction func settingBtnClickDown(sender: AnyObject) {
        
//        跳转设置页面
        
        self.performSegueWithIdentifier("GoToSettingVC", sender: self);
        
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
        }else{
            return;
        }
        
       let content = ["sex" : sex];
       
    let temp = MTG + UPDATEUSER + Utils.getOwnID() ;
    
    YHAlamofire.Get(urlStr: temp, paramters: content, success: { (res) in
    print(res);
    
    }) { (failedRes) in
    print(failedRes);
    
    }
        self.contentArr.replaceObjectAtIndex(3, withObject: sex);
        self.mtableView.reloadData();
//        数据上传
        
    }
    
 //  MARK:-  年龄

    func updateAge() -> Void {

        let arr1 = ["1","2","3","4","5","6","7","8","9"];
        let arr2 = ["0","1","2","3","4","5","6","7","8","9"];
        let vjump =  YHPickView(withComponentArr: arr1, androwArr: arr2);
        self.view.addSubview(vjump);
        vjump.yhpickview_block = { [weak self](str:String) in

            print(str);

            let content = ["age" : str];

            let temp = MTG + UPDATEUSER + Utils.getOwnID() ;

            YHAlamofire.Get(urlStr: temp, paramters: content, success: { (res) in
                print(res);

            }) { (failedRes) in
                print(failedRes);

            }
            self!.contentArr.replaceObjectAtIndex(4, withObject: str);
            self!.mtableView.reloadData();

        };

    }

//  MARK:-  所在地

    
    
//    MARK:- other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
