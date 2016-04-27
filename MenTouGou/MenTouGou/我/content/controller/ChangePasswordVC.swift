//
//  ChangePasswordVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/25.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var pass1: UITextField!

    @IBOutlet weak var pass2: UITextField!

    @IBOutlet weak var pass3: UITextField!

    @IBOutlet weak var updateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码";
        self.updateBtn.layer.masksToBounds = true;
        self.updateBtn.layer.cornerRadius = 5;
        self.updateBtn.backgroundColor = UIColor.mainColor();
        self.pass2.secureTextEntry = true;
        self.pass1.secureTextEntry = true;
        self.pass3.secureTextEntry = true;
    }



    @IBAction func updateBtnClickDown(sender: AnyObject) {

        if self.pass3.text != self.pass2.text {
            let hud = Utils.creatHUD();
            hud.labelText = "新密码输入不一致";
            hud.hide( true, afterDelay: 1);
            return;
        }

        if self.pass1.text?.characters.count == 0{
            let hud = Utils.creatHUD();
            hud.labelText = "请输入原密码";
            hud.hide( true, afterDelay: 1);
            return;
        }

        if self.pass2.text?.characters.count == 0{
            let hud = Utils.creatHUD();
            hud.labelText = "请输入新密码";
            hud.hide( true, afterDelay: 1);
            return;
        }

        let strurl = MTG + CHANGEPASSWORD + Utils.getOwnID() + "/" + self.pass1.text! + "/" + self.pass3.text!;

        YHAlamofire.Get(urlStr: strurl, paramters: nil, success: { (res) in
            let result = res as! String;
            if result == "false"{
                let hud = Utils.creatHUD();
                hud.labelText = "密码修改不成功";
                hud.hide( true, afterDelay: 1);
            }else{

            self.navigationController?.popViewControllerAnimated(true);
            }


            }) { (failedRes) in

        }



    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
