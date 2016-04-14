//
//  DetailView.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/13.
//  Copyright © 2016年 squallmouse. All rights reserved.
//
import Foundation
import UIKit

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
                    
                    
                    var utfStr = (tempArr[i]as! String).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet());
                    
                    if(!(utfStr! as NSString).hasPrefix("/")){
                        utfStr = "/" + utfStr! ;
                    }
                    
                   picArr.addObject(MTG + utfStr!);
                }
          }
            self.carSC = NewCarouselVC(frame: CGRectMake(0, 0, s_width, 180), withPicArr: picArr as [AnyObject], andimageType: imageurl);
            self.carView.addSubview(self.carSC.view);
        }
//        Title
        self.titleLab.text = dic["Title"]as? String;
//    服务类型
        
        var str:String = Utils.changeNullToEmptyStr(dic["ServiceType"]);
        self.serviceTypeLab.text = "服务类型: " + str;
//    服务级别图片
//        self.serviceLevelImg
//    星星评分
//        self.starsView
//   特色宣传
        str = Utils.changeNullToEmptyStr(dic["Slogan"]);
        self.characteristicLab.text = "特色宣传: " + str;
//   联系人
        str = Utils.changeNullToEmptyStr(dic["Creator"]);
        self.theContactLab.text = "联系人: " + str;
//  联系电话
         str = Utils.changeNullToEmptyStr(dic["Tel"]);
        self.theContactPhoneLab.text = "联系电话" + str;
//    地址
        str = Utils.changeNullToEmptyStr(dic["Address"]);
        self.addressLab.text = "地址: " + str;
        
        
    }
    
    
//

}
