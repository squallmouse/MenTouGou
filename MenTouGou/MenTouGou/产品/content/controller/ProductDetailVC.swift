//
//  ProductDetailVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/19.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import WebKit
class ProductDetailVC: UIViewController {

//    var web:WKWebView!;
    var web:UIWebView!;
    var modle:ProductModle!;
    var headView:ProductHeadView!;
    
    var productID : String!;
    
    init(withProductID ID:String){
        super.init(nibName: nil, bundle: nil);
        
//        self.web = WKWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.web = UIWebView(frame: CGRectMake(0, 64, s_width, s_height - 64 - 49));
        self.productID = ID;
        self.view.addSubview(self.web);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "特产详情";
        self.automaticallyAdjustsScrollViewInsets = false;
//购买关注按钮
        for i in 0...1 {

            let btn = UIButton(type: .Custom);
            btn.frame = CGRectMake((s_width/2) * CGFloat(i), s_height - 49, s_width/2, 49);
            self.view.addSubview(btn);
            if i == 0 {
                btn.backgroundColor = UIColor.blackColor();
                btn.setTitle("关注", forState: .Normal);
                btn.setImage(UIImage(named: "ic_favorite_two.9"), forState: .Normal);
            }else{

                btn.backgroundColor = UIColor.colorWithHexString("E63A41");
                btn.setTitle("立即购买", forState: .Normal);
            }

            btn.addTarget(self, action: #selector(ProductDetailVC.shoppingBtnClickDown), forControlEvents: .TouchUpInside);
        }

//        
        let strUrl = MTG + PRODUCT + self.productID  ;
        YHAlamofire.Get(urlStr: strUrl, paramters: nil, success: { (res) in
            let dic = res as! NSDictionary;
            self.modle = ProductModle(withDic: dic);
            self.parssserData();
            }) { (res) in
                
        }
        
        
        
       
    }

//  MARK:-  购买按钮
    func shoppingBtnClickDown(){
        print("跳转微信");

      let alert =  Utils.openWechat();
        self.presentViewController(alert, animated: true, completion: nil);

    }

//  MARK:-  数据解析
    
    func parssserData()  {
        if self.modle == nil {
            self.navigationController?.popViewControllerAnimated(true);
        }else{
            var viewHight:CGFloat = 350;
            var haveHeadpic:Bool = true;
            var top = 350 + 5;

            if self.modle.ImageUrl == nil {
                viewHight = 330 - 200;
                haveHeadpic = false;
                top = 135;
            }
            
            
            
            self.headView = ProductHeadView.init(frame: CGRectMake(0, 0, s_width, viewHight), withModle: self.modle, headPicIsHave: haveHeadpic);
            self.web.scrollView.addSubview(self.headView);
            self.headView.btnDownBlock = {[weak self](tag) in
                if tag == 5000 {
                    let st = (self!.modle.Description!);
                    
                    let temphtml:NSDictionary = [
                        "content":st,
                        "tophight":(top)
                    ];
                    //                var  htmlstr =
                    let html =  HTML.HTMLWithData(temphtml as [NSObject : AnyObject], usingTemplate: "article");
                    self!.web.loadHTMLString(html as String , baseURL: NSBundle.mainBundle().resourceURL);
                    
                }else{
                    let st = (self!.modle.Specification!);
                    
                    let temphtml:NSDictionary = [
                        "content":st,
                        "tophight":(top)
                    ];
                    
                    let html =  HTML.HTMLWithData(temphtml as [NSObject : AnyObject], usingTemplate: "article");
                    self!.web.loadHTMLString(html as String , baseURL: NSBundle.mainBundle().resourceURL);
                }
            };
            
            let st = (self.modle.Description!);
            
            let temphtml:NSDictionary = [
                "content":st,
                "tophight":(top)
            ];
            
            let html =  HTML.HTMLWithData(temphtml as [NSObject : AnyObject], usingTemplate: "article");
            self.web.loadHTMLString(html as String , baseURL: NSBundle.mainBundle().resourceURL);
        }
    }
//  MARK:-  other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
