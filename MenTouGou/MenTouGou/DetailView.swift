//
//  DetailView.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/13.
//  Copyright © 2016年 squallmouse. All rights reserved.
//
import Foundation
import UIKit

typealias DVbtnBlock = (show:Bool) -> Void ;

class DetailView: UIView {

    @IBOutlet var contentView: UIView!
//  轮播图
    var carSC : NewCarouselVC!;
//    放轮播图的View
    @IBOutlet weak var carView: UIView!
//   Title
    @IBOutlet weak var titleLab: UILabel!
//    服务类型
    @IBOutlet weak var serviceTypeLab: UILabel!
//    服务级别图片
    @IBOutlet weak var serviceLevelImg: UIImageView!
//    星星评分
    @IBOutlet weak var starsView: YHStartMarkView!
//   特色宣传
    @IBOutlet weak var characteristicLab: UILabel!
//   联系人
    @IBOutlet weak var theContactLab: UILabel!
//  联系电话
    @IBOutlet weak var theContactPhoneLab: UILabel!
//    地址
    @IBOutlet weak var addressLab: UILabel!
    
    
    var DVbtnClickDownBlock:DVbtnBlock? ;
    
//    override init(frame: CGRect) {
//        super.init(frame: frame);
//    }
     init(frame: CGRect, withDic dic:NSDictionary) {
        
        super.init(frame: frame);
        self.awakeFromNib();
//        数据解析
        self.paraserWithDic(dic);
        
    }
    
    override func awakeFromNib() {
         self.contentView = (NSBundle.mainBundle().loadNibNamed("DetailView", owner: self, options: nil)as NSArray).lastObject as! UIView ;
        self.contentView.frame = self.bounds;
        self.addSubview(self.contentView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func paraserWithDic(dic:NSDictionary) -> Void {
//        图片字符串分割
        let picStr = dic["ImageUrl"] as? NSString;
        
        if (picStr?.length > 0) {
           let tempArr = (picStr?.componentsSeparatedByString(";"))!as NSArray ;
            
        let picArr = NSMutableArray(capacity: 0);
            
            for i in 0 ..< tempArr.count {
                if (tempArr[i]as! String).characters.count > 2 {
                    
                  let utfStr =  Utils.SBImgChange(tempArr[i]as? String)
                    
                   picArr.addObject(MTG + utfStr!);
                }
          }
            self.carSC = NewCarouselVC(frame: CGRectMake(0, 0, s_width, 230), withPicArr: picArr as [AnyObject], andimageType: imageurl);
            self.addSubview(self.carSC.view);
            self.carSC.img1.contentMode = .ScaleToFill;
            self.carSC.img2.contentMode = .ScaleToFill;
            self.carSC.img3.contentMode = .ScaleToFill;
        }
//        Title
        self.titleLab.text = dic["Title"]as? String;
//    服务类型
        
        var str:String = Utils.changeNullToEmptyStr(dic["ServiceType"]);
        self.serviceTypeLab.text = "服务类型: " + str;
//    服务级别图片
//        ServiceLevel int
//        self.serviceLevelImg
//    星星评分
//        self.starsView
        let starsNum = (dic["CreditRank"]as? NSNumber)!.floatValue / 5.0;
        self.starsView.setScore(starsNum, withAnimation: false, completion: nil);

//   特色宣传
        str = Utils.changeNullToEmptyStr(dic["Slogan"]);
        self.characteristicLab.text = "特色宣传: " + str;
//   联系人
        str = Utils.changeNullToEmptyStr(dic["Creator"]);
        self.theContactLab.text = "联系人: " + str;
//  联系电话
         str = Utils.changeNullToEmptyStr(dic["Tel"]);
        self.theContactPhoneLab.text = "联系电话: " + str;
//    地址
        str = Utils.changeNullToEmptyStr(dic["Address"]);
        self.addressLab.text = "地址: " + str;
        
        
    }
   
    @IBAction func contentBtnClickDown(sender: AnyObject) {
        let btn = sender as! UIButton;
        btn.selected = !btn.selected;
        self.DVbtnClickDownBlock?(show:btn.selected);
    }
    
//

}
