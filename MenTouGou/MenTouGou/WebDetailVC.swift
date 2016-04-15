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

    var web:WKWebView!;
    var detailView:DetailView!;
    
    var productID : String!;
    
    init(withProductID ID:String){
        super.init(nibName: nil, bundle: nil);
        self.productID = ID ;
        self.web = WKWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.view.addSubview(self.web);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    test
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("hhhhhhhhhhh");
        print("ffff = \(s_height)");
        print(self.web.scrollView.contentSize.height);
    }
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        print("---------------");
        print(self.web.scrollView.contentSize.height);
    }
    
//    test
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;

//        let
        
        YHAlamofire.Get(urlStr: MTG + LEISURE + self.productID , paramters: nil,
            success: { (res) in
               
                let dic = res as! NSDictionary;
                print(dic)
                self.title = dic["Title"]as? String;
//                self.detailView = DetailView.init(frame: CGRectMake(0, -360, s_width, 350), withDic: dic);
                self.detailView = DetailView.init(frame: CGRectMake(0, 0, s_width, 350), withDic: dic);
                self.web.scrollView.addSubview(self.detailView);
//
//                self.web.scrollView.contentInset = UIEdgeInsetsMake(360, 0, -330, 0);
//                self.web.scrollView.contentInset = UIEdgeInsetsMake(360, 0, 0, 0);
//                self.web.loadRequest(NSURLRequest(URL: NSURL.init(string: "https://www.baidu.com")!));
                self.web.navigationDelegate = self;
                let st = dic["Detail"]as! String;
                
                let temphtml:NSDictionary = [
                    "content":st + st + st
                ];
//                var  htmlstr =
                let html =  HTML.HTMLWithData(temphtml as [NSObject : AnyObject], usingTemplate: "article");
                self.web.loadHTMLString(html as String , baseURL: NSBundle.mainBundle().resourceURL);
//                self.web.loadHTMLString(st + st + st + st + st , baseURL: nil);
                
//                self.web.loadHTMLString(st , baseURL: nil);
//                self.web.scrollView.bounces = false;
                print("---------");
            print(self.web.scrollView.contentSize.height);
                print("1111111");
                
            }) { (failedRes) in
                self.navigationController?.popViewControllerAnimated(true);
                
        }
        
        
    }

//  MARK:-  数据解析
    func parserWithDic(dic:NSDictionary){
        
        
        
    }
    
//  MARK:-  other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
