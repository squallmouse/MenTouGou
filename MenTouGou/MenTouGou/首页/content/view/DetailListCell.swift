//
//  DetailListCell.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/18.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class DetailListCell: UITableViewCell {
    @IBOutlet weak var dictanceLab: UILabel!

    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var contentLab: UILabel!
    
    @IBOutlet weak var contantLab: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    
    func setCellWithModle(mo:DetailListModle){
        let utfStr =  Utils.SBImgChange(mo.Thumbnail);
        
        let  imgUlr = MTG + utfStr! ;
        
        self.img.sd_setImageWithURL(NSURL.init(string: imgUlr), placeholderImage: UIImage(named: DEFAULTPIC));
        self.titleLab.text = mo.Title;
        self.contentLab.text = mo.Address;
        self.contantLab.text = "联系方式:" + mo.Tel!   + "   " + "联系人:" + mo.Creator! ;
        
        if mo.Coordinate != nil {
            
            self.dictanceLab.text = Utils.distanceConversion(mo.Coordinate);
        
        }else{
             self.dictanceLab.text = "";
        }
        

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.img.contentMode = UIViewContentMode.ScaleAspectFill;
        self.img.clipsToBounds = true;
        self.dictanceLab.adjustsFontSizeToFitWidth = true;
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
