//
//  YHBMKPointAnnotation.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/19.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class YHBMKPointAnnotation: BMKPointAnnotation {
    
    var contentStr:String!;
    var tag:Int!;
    
    init( with tag:Int,withContentStr str:String) {
        super.init();
        self.tag = tag;
        self.contentStr = str;
    }
    
}
