//
//  MyHeadCell.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/6.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class MyHeadCell: UITableViewCell {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImg.layer.masksToBounds = true;
        self.headImg.layer.cornerRadius = 30;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
