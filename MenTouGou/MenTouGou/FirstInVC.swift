//
//  FirstInVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/21.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class FirstInVC: UIViewController {

    let picNameArr:NSArray = ["s1.jpg","s2.jpg","s3.jpg"];

    var sc:UIScrollView!;
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.redColor();
        self.sc = UIScrollView(frame: self.view.bounds);
        self.view.addSubview(self.sc);
        self.sc.contentSize = CGSizeMake(s_width * 3, s_height);
        self.sc.showsVerticalScrollIndicator = false;
        self.sc.showsHorizontalScrollIndicator = false;
        self.sc.pagingEnabled = true;
        self.sc.bounces = false;
        self.addPicWithPicNameArr(self.picNameArr)
    }

    func addPicWithPicNameArr(nameArr:NSArray) -> Void {

        for i in 0 ..< nameArr.count{

            let imageView = UIImageView(frame: CGRectMake( s_width * CGFloat(i),0, s_width, s_height));
            self.sc.addSubview(imageView);

            if (i == nameArr.count-1) {
                imageView.userInteractionEnabled = true;
                self.addTap(imageView);

            }else{
            }

            imageView.image = UIImage(named: nameArr[i]as! String);
        }


    }

    /***********************************
     *function:添加点击事件
     *parmters:添加点击事件的View
     *return  :nil
     ************************************/
    func addTap(view:UIView!) -> Void {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FirstInVC.tapDown));
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;

        view.addGestureRecognizer(tap);
    }

    func tapDown() {

        print("第三章图片被点击");
        let rootSB = UIStoryboard.init(name: "Main", bundle: nil);
        let vc = rootSB.instantiateViewControllerWithIdentifier("YHTabBarVCSB");

        UIApplication.sharedApplication().delegate?.window!?.rootViewController = vc;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
