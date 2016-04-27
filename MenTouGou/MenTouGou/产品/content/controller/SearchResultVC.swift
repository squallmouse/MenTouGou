//
//  SearchResultVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/25.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class SearchResultVC: BaseTableViewVC {

    var keyWord:String!;

    init(withSearchKeyWord key:String!){
        super.init(nibName: nil, bundle: nil)
        self.keyWord = key;
        self.title = self.keyWord;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor.whiteColor();
        self.mtableView.frame = CGRectMake(0, 64, s_width, s_height - 64 - 49);

        self.getUrl = {[weak self](page) in
            let tempUrl = MTG + SEARCH_PRODUCT + (self?.keyWord)! ;
            let strUrl = Utils.urlStrConversion(urlStr: tempUrl);
            print(strUrl);
            let paramaters = [

                "pageIndex":String(self!.page),
                "pageSize":PAGESIZE
            ];

            return (strUrl,paramaters);
        }

        self.httpData(self.page);
    }

    //  MARK:-  数据解析
    override func parserResult(res: AnyObject?) {
        let arr = res as! NSArray
        for i in 0 ..< arr.count {
            let mo = ProductModle.init(withDic: arr[i]as! NSDictionary);
            self.dataArr.addObject(mo);
        }
    }

    //  MARK:-  tableView delegate
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count;
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ProductMainCell? = tableView.dequeueReusableCellWithIdentifier("ProductMainCellIden") as? ProductMainCell;
        if cell == nil {
            cell = (NSBundle.mainBundle().loadNibNamed("ProductMainCell", owner: self, options: nil)as NSArray).lastObject as? ProductMainCell;
        }
        cell?.setCellWithModle(self.dataArr[indexPath.row]as! ProductModle );
        return cell!;
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        super.tableView(tableView, didSelectRowAtIndexPath: indexPath);
        //    跳转
        let mo = self.dataArr[indexPath.row]as! ProductModle ;
        let ID =  NSString(format: "%@", mo.Id!)as String;
        let proVC = ProductDetailVC(withProductID: ID);
        //            .init(withProductModle: mo);
        proVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(proVC, animated: true);

    }


    //  MARK:-  Other func
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    


}
