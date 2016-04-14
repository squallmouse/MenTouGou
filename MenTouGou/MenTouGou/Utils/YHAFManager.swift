//
//  YHAFManager.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/7.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
typealias removeViewGuestViewBlock = ()->Void

typealias httpSuccessBlock = (AnyObject?)->Void
typealias httpFaildBlock = (AnyObject?)->Void

class YHAFManager: NSObject {
//  MARK:-  GET请求
/**
  get请求   
*/
//        let URL = NSURL.init(string: url.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!);
//        let request = NSURLRequest.init(URL: URL!);
    
   class func yhGet(urlStr url:String!, parameters parmeters:AnyObject?, success:(AnyObject?)  -> Void , OrFailure    failed:(AnyObject?) -> Void) -> Void {
    
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        
        let manager = AFURLSessionManager(sessionConfiguration: configuration );
    
    let URL = NSURL.init(string: url + self.changeParmetersToString(parmeters)!);
    

   let request =  NSURLRequest.init(URL: URL!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 20);
        let dataTask = manager.dataTaskWithRequest(request) { (response:NSURLResponse, responseObject:AnyObject?, error:NSError?) in
            if((error) == nil){
                success(responseObject);
            }else{
                failed(error);
            }
        }
        dataTask.resume();
    }
//  MARK:-  POST请求
/**
        post
*/
    class func yhPost(urlStr url:String!, parameters parmeters:AnyObject?, success:(AnyObject?)  -> Void , OrFailure    failed:(AnyObject?) -> Void) -> Void {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        
        let manager = AFURLSessionManager(sessionConfiguration: configuration );
//        name=云之遥的微店&intro=HHeh
        let URL = NSURL.init(string: url);

        let request = NSMutableURLRequest.init(URL: URL!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 20);
        let secData = self.changeParmetersToString(parmeters)?.dataUsingEncoding(NSUTF8StringEncoding);
        
        request.HTTPBody = secData;
        request.HTTPMethod = "POST";
        
        let dataTask = manager.dataTaskWithRequest(request) { (response:NSURLResponse, responseObject:AnyObject?, error:NSError?) in
            if((error) == nil){
                success(responseObject);
            }else{
                failed(error);
            }
        }
        dataTask.resume();
    }
//  MARK:-  把输入的参数变成字符串
/**
     把输入的参数变成字符串
*/
 class func changeParmetersToString(parmeters:AnyObject?) -> String? {
//        为空就返回
        if (parmeters == nil) {
            return "";
        }
//        
        var returnStr:String = "?";
        
        if (parmeters is String) {
            
            return parmeters as? String;
            
        }else if (parmeters is NSDictionary){
            
            let dic = parmeters as! NSDictionary;
            
            for i in 0 ..< dic.allKeys.count {
                returnStr = returnStr + (dic.allKeys[i] as! String)  + "=" + (dic.objectForKey(dic.allKeys[i] as! String) as? String)!
                if (i != dic.allKeys.count - 1)  {
                    returnStr += "&";
                }
            }
            return returnStr;
        }
       return "";
   
    }
//  MARK:-  把含有中文的链接转转码
/**
     把含有中文的链接转转码
*/
    
 
   
}
