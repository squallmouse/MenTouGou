//
//  ChooseBtnCell.swift
//  collectionViewDEMO
//
//  Created by 袁昊 on 16/6/27.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class ChooseBtnCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLab: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
//        self.img.
    }


    func cellSetValueWith(imageName:String!, titleStr title:String!) -> Void {
        self.img.image = UIImage.init(named: imageName)
        self.titleLab.text = title;
    }

}
