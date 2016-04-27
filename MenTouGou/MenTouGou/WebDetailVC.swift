//
//  WebDetailVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/13.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import WebKit

class WebDetailVC: UIViewController,WKNavigationDelegate {

//    var web:WKWebView!;
    var web:UIWebView!
    
    var detailView:DetailView!;
    
    var productID : String!;
    var dataDic:NSDictionary!;
    
    init(withProductID ID:String){
        super.init(nibName: nil, bundle: nil);
        self.productID = ID ;
//        self.web = WKWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.web = UIWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.view.addSubview(self.web);
    }
    
    init(withDataDic Dic:NSDictionary){
        super.init(nibName: nil, bundle: nil);
        self.dataDic = Dic;
//        self.web = WKWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.web = UIWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.view.addSubview(self.web);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;

        self.web.scrollView.bounces = false;
        
        if self.dataDic == nil {

            YHAlamofire.Get(urlStr: MTG + LEISURE + self.productID , paramters: nil,
            success: { (res) in
               
                let dic = res as! NSDictionary;
                print(dic)
                self.parserWithDic(dic);
            }) { (failedRes) in
                self.navigationController?.popViewControllerAnimated(true);
                
            }
        }else{
            self.parserWithDic(self.dataDic);
        }
        
        
    }

//  MARK:-  数据解析
    func parserWithDic(dic:NSDictionary){
        
        self.title = dic["Title"]as? String;
        let st = dic["Detail"]as! String;
        self.detailView = DetailView.init(frame: CGRectMake(0, 0, s_width, 400), withDic: dic);
        self.web.scrollView.addSubview(self.detailView);
        
        self.detailView.DVbtnClickDownBlock = {[weak self](show) in
            self!.webShowDetail(show, st: st);
        };
        
        self.webShowDetail(true, st: st);
        

        
    }
//    是否显示代码
    func webShowDetail(show:Bool,st:String) -> Void {
        
        
        let temphtml:NSDictionary = [
            "content":show ? st : " " ,
            "tophight":(400)
        ];
        //                var  htmlstr =
        let html =  HTML.HTMLWithData(temphtml as [NSObject : AnyObject], usingTemplate: "article");
        self.web.loadHTMLString(html as String , baseURL: NSBundle.mainBundle().resourceURL);
    }
    
    
//  MARK:-  other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
