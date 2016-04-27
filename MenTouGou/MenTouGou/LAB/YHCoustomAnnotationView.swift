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
    let fontSize:CGFloat = 13;
    let picName = "bg_place_prompt9"
    
    var tapBlcok:tapDownBlock?;
//  MARK:-  初始化方法
    init!(annotation: BMKAnnotation!, reuseIdentifier: String!,withTitle title:String?,Withtag annotag:Int) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier);
        self.image = UIImage(named: picName);
        let labWidth = self.labWidth(inStr: title);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labWidth + 10, 25);


        let lab = UILabel(frame: CGRectMake(5, 2,labWidth, 20));
        lab.tag = annotag;
        lab.text = title;
        lab.font = UIFont.systemFontOfSize(fontSize);
        lab.adjustsFontSizeToFitWidth = true;
     
        self.userInteractionEnabled = true;
        lab.userInteractionEnabled = true;
        self.addTap(withView: lab);
        
        
        self.addSubview(lab);
    }
    
    /***********************************
     *function:添加点击事件
     *parmters:需要被点击的view
     *return  :nil
     ************************************/
    func addTap(withView view:UIView) -> Void {
        let tap = UITapGestureRecognizer(target: self, action: #selector(YHCoustomAnnotationView.tapDown(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1;
        
        view.addGestureRecognizer(tap);
    }
    /***********************************
     *function:点击事件
     *parmters:手势
     *return  :nil
     ************************************/
    func tapDown(tap:UITapGestureRecognizer) -> Void {
        self.tapBlcok?(tag:(tap.view?.tag)!);
    }
//

    func labWidth(inStr str:String!) -> CGFloat {
        let attributeDic = [NSFontAttributeName:UIFont.systemFontOfSize(fontSize)];
        let rect = (str as NSString).boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT), 20), options: [NSStringDrawingOptions.UsesLineFragmentOrigin,.UsesFontLeading, .TruncatesLastVisibleLine], attributes: attributeDic, context: nil);
        return rect.size.width;
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
