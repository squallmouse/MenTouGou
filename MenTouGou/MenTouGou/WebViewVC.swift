//
//  WebViewVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/13.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController,WKNavigationDelegate {

    var web:WKWebView!;
    var urlstr:String!;
    var hud:MBProgressHUD!;

    override func viewWillDisappear(animated: Bool) {
            self.hud.hide(true);
    }


    init(url:String){
        super.init(nibName: nil, bundle: nil);
        self.urlstr = url;
        self.web = WKWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.web.navigationDelegate = self;
        self.view.addSubview(self.web);
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("wkwebview 加载成功!");
        self.title = webView.title;
        self.hud.hide(true);
    }
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        print("wkwebview 加载失败!");
        self.hud.labelText = "当前网络不好";
        self.hud.hide(true, afterDelay: 1);
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.web.loadRequest(NSURLRequest(URL: NSURL.init(string: self.urlstr)!));
        self.hud = Utils.creatHUD();
        self.hud.labelText = "网页加载中";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
