//
//  RegisterVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/9.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var eMailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var AGPasswordTextField: UITextField!
    
    @IBOutlet weak var updateBtn: UIButton!
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册";
        self.updateBtn.layer.masksToBounds = true;
        self.updateBtn.layer.cornerRadius = 5;
        self.updateBtn.backgroundColor = UIColor.mainColor();
        self.passwordTextField.secureTextEntry = true;
        self.AGPasswordTextField.secureTextEntry = true;
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true);
    }
//  MARK:-  提交按钮
    
    @IBAction func updateBtnClickDown(sender: AnyObject) {
        if (self.userNameTextField.text?.characters.count < 4
            || self.userNameTextField.text?.characters.count > 16 ) {
            let hud:MBProgressHUD = Utils.creatHUD();
            hud.labelText = "用户名长度不符";
            hud.hide(true, afterDelay: 1);
            return;
        }
        
        if( self.userNameTextField.text?.characters.count == 0
        || self.eMailTextField.text?.characters.count == 0
        || self.passwordTextField.text?.characters.count == 0
            ){
            let hud:MBProgressHUD = Utils.creatHUD();
            hud.labelText = "请完整填写信息";
            hud.hide(true, afterDelay: 1);
            return;
        }
        
        if (self.passwordTextField.text != self.AGPasswordTextField.text) {
            let hud:MBProgressHUD = Utils.creatHUD();
            hud.labelText = "两次密码填写不一样";
            hud.hide(true, afterDelay: 1);
            return;
        }
        let paramters = [
            "Email": self.eMailTextField.text!,
        "Password": self.passwordTextField.text!,
        "PhoneNumber": "",
        "UserName": self.userNameTextField.text!
            
        ] as [String:AnyObject];

        print(MTG+REGIEST);
        
        let hud:MBProgressHUD = Utils.creatHUD();
        
        YHAlamofire.PostJson(urlStr: MTG + REGIEST , paramters: paramters, success: { (res) in
            let dic = res as! NSDictionary;
            print(dic);
            
            if(dic["ErrCode"]as? String == "0"){
                let user = NSUserDefaults.standardUserDefaults();
                user.setValue(dic["Id"], forKey: "userID");
                user.setValue(dic["UserName"], forKey: "UserName");
                if ((dic["Id"]as! String).characters.count > 0 ){
                    user.setValue(self.eMailTextField.text!, forKey: dic["Id"]as! String);
                }
                user.synchronize();
                
                NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "refreshUser", object: nil));
                hud.labelText =  "注册成功";
                hud.hide(true, afterDelay: 1);
                self.navigationController?.popToRootViewControllerAnimated(false);
            }else{
               
                hud.labelText = dic["ErrMsg"]as? String;
                hud.hide(true, afterDelay: 1);
            }
            }) { (failedRes) in
                
        }
        
        
    }
   
    
//  MARK:-  other
    
    
    
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
