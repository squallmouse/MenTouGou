//
//  SignatureVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/6.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

typealias contentChangeBlock = (String?)->Void;

class SignatureVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var mtextField: UITextField!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var TitleLab: UILabel!
    
    var myBlock = contentChangeBlock?();
    var titleLabStr:String!;
//
    
     deinit{
        print("123321");
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        设置按钮样式
        self.confirmBtn.layer.masksToBounds = true;
        self.confirmBtn.layer.cornerRadius = 5;
        self.confirmBtn.backgroundColor = UIColor.mainColor();
        
        self.mtextField.placeholder = titleLabStr;
        self.TitleLab.text = titleLabStr.substringFromIndex(titleLabStr.startIndex.advancedBy(3));
        
    }
    
// 点击确定按钮
    @IBAction func confirmBtnClickDown(sender: AnyObject) {
//        上传数据，完成后退出
        if self.mtextField.text!.isEmpty {
             let hud = Utils.creatHUD();
                hud.labelText = "提交不能为空";
            hud.hide(true, afterDelay: 1);
            return;
        }


        var content:[String:AnyObject]!;
        if self.title == "个性签名" {
            content = ["name" : self.mtextField.text! as String];
        }else{
            content = ["location" : self.mtextField.text! as String];
        }
        let hud = Utils.creatHUD();
        
        let temp = MTG + UPDATEUSER + Utils.getOwnID() ;

        YHAlamofire.Get(urlStr: temp, paramters: content, success: { (res) in
            print(res);
            hud.hide(true, afterDelay: 1);
            self.navigationController?.popViewControllerAnimated(true);
            }) { (failedRes) in
             print(failedRes);
                hud.hide(true, afterDelay: 1);
            self.navigationController?.popViewControllerAnimated(true);
        }

        self.myBlock?(self.mtextField.text);
        
    }
    
//    
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
