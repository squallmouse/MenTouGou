//
//  InfoWebVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/19.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import WebKit

class InfoWebVC: UIViewController {

    var web:WKWebView!;
    var proID:String!;
    init(withID ID:String){
        super.init(nibName: nil, bundle: nil);
        self.proID = ID;
        self.web = WKWebView(frame: CGRectMake(0, 64, s_width, s_height - 64));
        self.view.addSubview(self.web);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        let url = "http://mtg.ritontech.com/Detail/" + self.proID;
        
        self.web.loadRequest(NSURLRequest(URL: NSURL.init(string: url)!));
        
        
    }

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
