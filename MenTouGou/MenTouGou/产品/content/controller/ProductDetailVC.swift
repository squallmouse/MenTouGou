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
        self.web = UIWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
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
//        
        let strUrl = MTG + PRODUCT + self.productID  ;
        YHAlamofire.Get(urlStr: strUrl, paramters: nil, success: { (res) in
            let dic = res as! NSDictionary;
            self.modle = ProductModle(withDic: dic);
            self.parssserData();
            }) { (res) in
                
        }
        
        
        
       
    }
//  MARK:-  数据解析
    
    func parssserData()  {
        if self.modle == nil {
            self.navigationController?.popViewControllerAnimated(true);
        }else{
            var viewHight:CGFloat = 310;
            var haveHeadpic:Bool = true;
            var top = 310 + 5;
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
