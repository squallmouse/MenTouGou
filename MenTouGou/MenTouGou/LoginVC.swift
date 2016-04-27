//
//  LoginVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/9.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录";
        self.loginBtn.layer.masksToBounds = true;
        self.loginBtn.layer.cornerRadius = 5;
        self.passwordTextfield.secureTextEntry = true;
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    
//  MARK:-  按钮们
//    登录按钮
    @IBAction func loginBtClickDown(sender: AnyObject) {
        if (self.userNameTextField.text?.characters.count < 4
            || self.userNameTextField.text?.characters.count > 16 ) {
            let hud:MBProgressHUD = Utils.creatHUD();
            hud.labelText = "用户名长度不符";
            hud.hide(true, afterDelay: 1);
            return;
        }
        
        if (self.passwordTextfield.text?.characters.count < 4
            || self.passwordTextfield.text?.characters.count > 16 ) {
            let hud:MBProgressHUD = Utils.creatHUD();
            hud.labelText = "密码长度不符";
            hud.hide(true, afterDelay: 1);
            return;
        }
        
        if( self.userNameTextField.text?.characters.count == 0
            || self.passwordTextfield.text?.characters.count == 0
            ){
            let hud:MBProgressHUD = Utils.creatHUD();
            hud.labelText = "请完整填写信息";
            hud.hide(true, afterDelay: 1);
            return;
        }
        
        let hud = Utils.creatHUD();
        hud.labelText = "登陆中";
        
        let name = self.userNameTextField.text! as String;
        let passWD = self.passwordTextfield.text! as String;
        let urlStr = MTG + LOGIN +  name + "/" + passWD ;
        YHAlamofire.Get(urlStr: urlStr, paramters: nil, success: { (res) in
            
            let dic = res as! NSDictionary;
            if (dic["ErrCode"]as? String != "1"){
                let user = NSUserDefaults.standardUserDefaults();
                user.setValue(dic["Id"], forKey: "userID");
                user.setValue(dic["UserName"], forKey: "UserName");
                user.synchronize();
            
            NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "refreshUser", object: nil));
                hud.hide(true);
            self.navigationController?.popToRootViewControllerAnimated(true);
                
            }else{
                
                hud.labelText = dic["ErrMsg"]as? String;
                hud.hide(true, afterDelay: 1);
            }
            
            }) { (failedRes) in
                
        }
        
        
        
    }
//   忘记密码
    @IBAction func forgetPasswordBtnClickDown(sender: AnyObject) {
        
        let SB = UIStoryboard.init(name: "MyHomePage", bundle: nil);
        let vc = SB.instantiateViewControllerWithIdentifier("ResetPasswordVC");
        self.navigationController?.pushViewController(vc, animated: true);

        
    }
//    我要注册
    @IBAction func regiestBtnClickDown(sender: AnyObject) {
        
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
