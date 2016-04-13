//
//  MyOtherCell.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/6.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var contentLab: UILabel!
    
    @IBOutlet weak var rightImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        let tempView =  UIView(frame: self.frame);

        self.selectedBackgroundView = tempView;
        self.selectedBackgroundView?.backgroundColor = UIColor.mainColor();
    }

//    设置cell
    func setCell(title title:String?, andContent content:String?, ImgHidden hidden:Bool) -> Void {
        
        self.titleLab.text = title;
        self.contentLab.text = content;
        self.rightImg.hidden = hidden;
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
