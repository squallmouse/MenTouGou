//
//  ProductMainCell.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/19.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

typealias cellShopCarBlock = ()->Void;

class ProductMainCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var priceLab: UILabel!

    @IBOutlet weak var shopCarBtn: UIButton!

    var shopCarBlock:cellShopCarBlock?;
//
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func shopCarBtnClickDown(sender: AnyObject) {

        self.shopCarBlock?();
    }

    func setCellWithModle(mo:ProductModle)->Void{
        
        let utfStr =  Utils.SBImgChange(mo.Thumbnail);
        
        let  imgUlr = MTG + utfStr! ;
        
        self.img.sd_setImageWithURL(NSURL.init(string: imgUlr), placeholderImage: UIImage(named: DEFAULTPIC));
        self.titleLab.text = mo.Title;
//        let nn = mo.Price?.integerValue
        let num = NSString(format: "%@", mo.Price!)as String ;
        self.priceLab.text = "￥" + num;
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
