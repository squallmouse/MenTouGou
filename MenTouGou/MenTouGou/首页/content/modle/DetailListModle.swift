//
//  DetailListModle.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/18.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class DetailListModle: NSObject {

    var Id:NSNumber?;
    var Type:NSNumber?;
    var Ares:String?;
    var Thumbnail:String?;
    var ImageUrl:String?;
    var Title:String?;
    var Detail:String?;
    var NaviUrl:String?;
    var Coordinate:String?
    var PV: NSNumber?
    var ServiceType:String?
    var ServiceLevel:NSNumber?;
    var CreditRank:NSNumber?
    var Slogan:String?
    var Creator:String?;
    var Tel:String?
    var Address:String?
    var CreatorTime:String?;
    
    var distanct:String?;//距离转换后存起来
    
    
    init(dic:NSDictionary) {
        super.init();

        self.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
        self.distanct = "99";
        if self.Coordinate != nil {
            self.distanct = Utils.distanceConversion(self.Coordinate);
            if self.distanct?.characters.count == 0 {
                self.distanct = "99";
            }
        }

    }
    
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
