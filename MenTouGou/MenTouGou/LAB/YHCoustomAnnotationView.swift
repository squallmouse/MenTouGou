//
//  YHCoustomAnnotationView.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/18.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

typealias tapDownBlock = (tag:Int)-> Void ;

class YHCoustomAnnotationView: BMKAnnotationView {

    let picName = "bg_place_prompt9"
    
    var tapBlcok:tapDownBlock?;
    
    init!(annotation: BMKAnnotation!, reuseIdentifier: String!,withTitle title:String?,Withtag annotag:Int) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier);
        self.image = UIImage(named: picName);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 25);
        let lab = UILabel(frame: CGRectMake(5, 3, 90, 20));
        lab.tag = annotag;
        lab.text = title;
        lab.adjustsFontSizeToFitWidth = true;
//        self.backgroundColor = UIColor.redColor();
//        lab.backgroundColor = UIColor.orangeColor();
        
        self.userInteractionEnabled = true;
        lab.userInteractionEnabled = true;
        self.addTap(withView: lab);
        
        
        self.addSubview(lab);
    }
    
    
    func addTap(withView view:UIView) -> Void {
        let tap = UITapGestureRecognizer(target: self, action: #selector(YHCoustomAnnotationView.tapDown(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1;
        
        view.addGestureRecognizer(tap);
    }
    
    func tapDown(tap:UITapGestureRecognizer) -> Void {
//        tap.view?.tag
        self.tapBlcok?(tag:(tap.view?.tag)!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
