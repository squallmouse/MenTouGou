//
//  Utils.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import Foundation


let s_width = UIScreen .mainScreen().bounds.size.width;

let s_height = UIScreen .mainScreen().bounds.size.height;


class Utils: NSObject {

//    MARK: - 创建一个HUD
   class func creatHUD() -> MBProgressHUD {
        let window = ((UIApplication.sharedApplication().windows) as NSArray).lastObject as! UIWindow ;
        let hud = MBProgressHUD.init(window: window);
        hud.detailsLabelFont = UIFont.systemFontOfSize(16);
        window.addSubview(hud);
        hud.show(true);
        hud.removeFromSuperViewOnHide = true;
        return hud;
    }
   
//    MARK: - 
    
    class func getOwnID() -> String{
        let user = NSUserDefaults.standardUserDefaults();
      let  userID =  user.valueForKey("userID") as? String;
        if (userID == nil) {
            return "0";
        }else{
            return userID! ;
        }
        
    }
//  MARK:-  NSDate 转换成时间串
   class func dateConversionToString(date:NSDate?) -> String {
        let da1 = NSDateFormatter();
        da1.dateFormat = "yyyy-MM-dd";
        return da1.stringFromDate(date!);
    }
//  MARK:-  把null换成""
//
    class func changeNullToEmptyStr(value:AnyObject?)->String
    {
        if value is NSNull {
            return ""
        }else{
            return value as! String;
        }
        
    }
    
    
    func change(parmeters:AnyObject?) -> String? {
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
//  MARK:-  中文转码
//
    class  func urlStrConversion(urlStr urlStr:String!) -> String {

//   let data = urlStr.dataUsingEncoding(NSUTF8StringEncoding)
//    return String(data: data!, encoding: NSUTF8StringEncoding)!;
        print("中文转码");
//
        return urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
        
    }
//  MARK:-  html 
//    class func HTMLWithDic(dic:NSDictionary, useingTemplate templateName:String)->NSString{
//        let templatePath = NSBundle.mainBundle().pathForResource(templateName, ofType: "html", inDirectory: "html");
//        do{
//            let template = try NSString.init(contentsOfFile: templatePath!, encoding: NSUTF8StringEncoding);
//            
//        
////            GRMustache
//            return "";
//        }catch{
//            print("html失败了！！！！！！")
//            return "";
//        }
//        
//    }
//    
    
    
    
    
    
    
    
    
    
    

    
}
