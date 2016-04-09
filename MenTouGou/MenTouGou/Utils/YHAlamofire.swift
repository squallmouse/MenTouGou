//
//  YHAlamofire.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/8.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import Alamofire


class YHAlamofire: NSObject {
//
    
    class func YHGetAlamofire(
             urlStr url:String!,
             paramters parameters:[String : AnyObject]?,
             success:(AnyObject?) -> Void,
             OrFailure failed:(AnyObject?) -> Void) -> Void
    {

        Alamofire.request(.GET, url, parameters: parameters).response { (request, response, data, error) in
            do{
                let res:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) ;
                    success(res);
            }catch{
                failed(error as? AnyObject);
            }
        }
    
    }
    
//    
    class func YHPostAlamofire(urlStr url:String!, paramters parameters:[String : AnyObject]?, success:(AnyObject?) -> Void, OrFailure failed:(AnyObject?) -> Void) -> Void{
    
        Alamofire.request(.GET, url, parameters: parameters).response { (request, response, data, error) in
            do{
                let res:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) ;
                success(res);
            }catch{
                failed(error as? AnyObject);
            }
        }
    }

    
}
