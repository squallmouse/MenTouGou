//
//  FullImageCell.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/6.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class FullImageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(imgUrl url:String) -> Void {
        print(url);
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
