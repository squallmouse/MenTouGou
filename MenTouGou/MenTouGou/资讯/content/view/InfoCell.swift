//
//  InfoCell.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/11.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var contentLab: UILabel!
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.img.contentMode = .ScaleAspectFill;
        self.img.clipsToBounds = true;
//        UIViewContentModeScaleAspectFill
    }

    func setCellWithModle(mo:InfoCellModle) -> Void {
        
        let utfStr =  Utils.SBImgChange(mo.Thumbnail);
        
        let  imgUlr = MTG + utfStr! ;
        
        self.img.sd_setImageWithURL(NSURL.init(string: imgUlr), placeholderImage: UIImage(named: DEFAULTPIC));
        self.titleLab.text = mo.Title;
        self.contentLab.text = mo.Description;
        
        if (mo.CreatorTime?.characters.count > 10){
            self.timeLab.text = mo.CreatorTime?.substringToIndex(mo.CreatorTime!.startIndex.advancedBy(10));
        }else{
            self.timeLab.text = "";
        }

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
