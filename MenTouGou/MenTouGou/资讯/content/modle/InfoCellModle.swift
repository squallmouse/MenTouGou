//
//  InfoCellModle.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/11.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class InfoCellModle: NSObject {
    
        var Id:NSNumber?;
        var Type:NSNumber?;
        var Thumbnail:String?;
        var ImageUrl:String?;
        var Title:String?;
        var Description:String?;
        var PV:NSNumber?;
        var Creator:String?;
        var CreatorTime:String?;
    
    var timeText:String?;//时间转换后存起来
    
    
    init(dic:NSDictionary) {
        super.init();
        self.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
