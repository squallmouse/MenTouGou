//
//  ProductModle.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/19.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class ProductModle: NSObject {

    var Id : NSNumber?;
    var Thumbnail:String?;
    var ImageUrl:String?;
    var Title:String?;
    var Price:NSNumber?;
    var Description:String?;
    var Specification:String?;
//    var ImageUrl:String?;
    
    init(withDic dic:NSDictionary!) {
        super.init();
        self.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
