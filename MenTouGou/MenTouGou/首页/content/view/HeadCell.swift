//
//  HeadCell.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/6.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

typealias cellBtnClick = (tag:Int)->Void

class HeadCell: UITableViewCell {

    
    var btnClickDown : cellBtnClick?;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
//
    
    @IBAction func HeadCellBtnClickDown(sender: AnyObject) {
        
        let btn = sender as! UIButton;
//        print("btntag = \(btn.tag)");
        self.btnClickDown?(tag: btn.tag);
    }
    
    
//    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
