//
//  ResetPasswordVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/6.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var eMailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var AGPasswordTextField: UITextField!
    
    
    @IBOutlet weak var updateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateBtn.layer.masksToBounds = true;
        self.updateBtn.layer.cornerRadius = 5;
        self.updateBtn.backgroundColor = UIColor.mainColor();
        
        self.passwordTextField.secureTextEntry = true;
        self.AGPasswordTextField.secureTextEntry = true;
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true);
        
    }
    
//  MARK:-  111
    
    @IBAction func updateBtnClickDown(sender: AnyObject) {
        
        if(
            self.userNameTextField.text?.characters.count == 0
            || self.eMailTextField.text?.characters.count == 0
            || self.passwordTextField.text?.characters.count == 0
            ) {
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
            "UserName" : self.userNameTextField.text!,
            "Email" : self.eMailTextField.text!,
            "NewPassword":self.passwordTextField.text!
            
        ];
        
        YHAlamofire.PostJson(urlStr: MTG + FORGETPASSWORD, paramters: paramters, success: { (res) in
            print("密码找回成功 = \(res)");
            
            let hud:MBProgressHUD = Utils.creatHUD();
            hud.labelText = "密码找回成功";
            hud.hide(true, afterDelay: 1);
            self.navigationController?.popViewControllerAnimated(true);
            }) { (error) in
              self.navigationController?.popViewControllerAnimated(true);
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
