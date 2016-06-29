//
//  MainListCell.swift
//  CollectionView_Demo
//
//  Created by 袁昊 on 16/6/24.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
protocol collectionViewCellDelegate {
    func back(btnTag : Int)->Void;
}

class MainListCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var McollectionView: UICollectionView!
    var delegate:collectionViewCellDelegate?;
//    let titleArr = ["京西动态","旅游导航","特产超市","休闲农业","聚焦三农","互动交流","纪录京西","媒体聚焦","京西故事"];
    let titleArr = ["聚焦三农","休闲农业","旅游导航","微相册","特产超市","京西拾趣","媒体聚焦","互动交流"];
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.McollectionView.delegate = self;
        self.McollectionView.dataSource = self;

        let layout = UICollectionViewFlowLayout.init();
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = CGSizeMake((UIScreen.mainScreen().bounds.size.width-20)/4, 90)

        self.McollectionView.collectionViewLayout = layout;
        self.McollectionView.registerNib(UINib.init(nibName: "ChooseBtnCell", bundle: nil), forCellWithReuseIdentifier: "ChooseBtnCellIden");
        self.McollectionView.backgroundColor = UIColor.colorWithHexString("F5F6F7");
        self.McollectionView.bounces = true;

    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:ChooseBtnCell? = collectionView.dequeueReusableCellWithReuseIdentifier("ChooseBtnCellIden", forIndexPath: indexPath) as? ChooseBtnCell;
        if cell == nil {
            cell = (NSBundle.mainBundle().loadNibNamed("ChooseBtnCell", owner: self, options: nil)as NSArray).lastObject as? ChooseBtnCell;
        }
        let value = indexPath.section * 4 + indexPath.row ;
        cell?.cellSetValueWith(titleArr[value], titleStr: titleArr[value]);
//        cell?.backgroundColor = UIColor.purpleColor();
        return cell!;
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2;
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let value = indexPath.section * 4 + indexPath.row + 2000;
        self.delegate?.back(value);
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
