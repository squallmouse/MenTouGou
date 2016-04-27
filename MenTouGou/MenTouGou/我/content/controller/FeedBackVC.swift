//
//  FeedBackVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/21.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class FeedBackVC: UIViewController {

    @IBOutlet weak var updateBtn: UIButton!


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "意见反馈";

        self.updateBtn.layer.masksToBounds = true;
        self.updateBtn.layer.cornerRadius = 5;

    }

    @IBAction func updateBtnClickDown(sender: AnyObject) {

        let hud = Utils.creatHUD();
        hud.labelText = "提交成功";
        hud.hide(true, afterDelay: 1.5);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1), dispatch_get_main_queue()) { 
            self.navigationController?.popViewControllerAnimated(true);
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
