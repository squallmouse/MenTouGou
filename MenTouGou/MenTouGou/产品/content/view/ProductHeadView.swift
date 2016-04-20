//
//  ProductHeadView.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/19.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

typealias  btnClickDownBlock = (tag:Int) -> Void

class ProductHeadView: UIView {
//
    
    @IBOutlet weak var guigeBtn: UIButton!
    @IBOutlet weak var productIntroBtn: UIButton!
    var btnDownBlock:btnClickDownBlock?;
    var carVC:NewCarouselVC!;
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var carView: UIView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var picHight: NSLayoutConstraint!
//    
    init(frame: CGRect,withModle mo:ProductModle,headPicIsHave have:Bool) {
        super.init(frame: frame);
        self.awakeFromNib();
        
        self.productIntroBtn.backgroundColor = UIColor.mainColor();
        self.productIntroBtn.layer.masksToBounds = true;
        self.productIntroBtn.layer.cornerRadius = 5;
        self.productIntroBtn.layer.borderColor = UIColor.blackColor().CGColor;
        self.productIntroBtn.layer.borderWidth = 1;
//        
        self.guigeBtn.layer.masksToBounds = true;
        self.guigeBtn.layer.cornerRadius = 5;
        self.guigeBtn.layer.borderColor = UIColor.blackColor().CGColor;
        self.guigeBtn.layer.borderWidth = 1;
        
        self.parserData(mo, haveHeadPic: have);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib();
        
        self.contentView = (NSBundle.mainBundle().loadNibNamed("ProductHeadView", owner: self, options: nil)as NSArray).lastObject as! UIView ;
        self.contentView.frame = self.bounds;
        self.addSubview(self.contentView);
        
    }
    
    func parserData(mo:ProductModle, haveHeadPic have:Bool) -> Void {
        
        if !have {
            self.picHight.constant = 0
        }else{
            let picStr = mo.ImageUrl! as NSString;
            
            if (picStr.length > 0) {
                let tempArr = (picStr.componentsSeparatedByString(";"))as NSArray ;
                
                let picArr = NSMutableArray(capacity: 0);
                
                for i in 0 ..< tempArr.count {
                    if (tempArr[i]as! String).characters.count > 2 {
                        
                        let utfStr =  Utils.SBImgChange(tempArr[i]as? String)
                        
                        picArr.addObject(MTG + utfStr!);
                    }
                }
                self.carVC = NewCarouselVC(frame: CGRectMake(0, 0, s_width, 200), withPicArr: picArr as [AnyObject], andimageType: imageurl);
//                self.carView.addSubview(self.carVC.view);
                self.addSubview(self.carVC.view);
            }
        }
        
        self.titleLab.text = mo.Title;
        
        self.priceLab.text = "￥" + (NSString(format: "%@", mo.Price!) as String)as String;
        
    }
    
    
    @IBAction func btnClickDown(sender: AnyObject) {
        let btn:UIButton! = sender as! UIButton;
        print(btn.tag);
        self.productIntroBtn.backgroundColor = UIColor.whiteColor();
        self.guigeBtn.backgroundColor = UIColor.whiteColor();
        btn.backgroundColor = UIColor.mainColor();
        
        self.btnDownBlock?(tag: btn.tag);
    }
}
