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
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    
//  MARK:-  按钮们
//    登录按钮
    @IBAction func loginBtClickDown(sender: AnyObject) {
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
