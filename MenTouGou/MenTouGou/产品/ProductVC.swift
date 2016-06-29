//
//  ProductVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class ProductVC: BaseTableViewVC,UISearchBarDelegate {

    var msearch:UISearchBar!;
    var typeValue = "";
    var hud:MBProgressHUD!;


    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.msearch.resignFirstResponder();

            self.hud.hide(true);

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.title == "特产超市" {
            self.mtableView.frame = CGRectMake(0, 64, s_width, s_height - 64);
        }else{
            self.mtableView.frame = CGRectMake(0, 64, s_width, s_height - 64 - 49);
        }

        self.title = "农产品";
        self.msearch = UISearchBar();
        self.msearch.frame = CGRectMake(100, 20, s_width-200, 44);
        self.navigationItem.titleView = self.msearch;

        self.msearch.delegate = self;
        self.msearch.placeholder = "搜索农产品";
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor.whiteColor();


        self.getUrl = {[weak self](page) in
            let strUrl = MTG + PRODUCTLIST + self!.typeValue;
            
            let paramaters = [
                
                "pageIndex":String(self!.page),
                "pageSize":PAGESIZE
            ];
            
            return (strUrl,paramaters);
        }
        
        self.httpData(self.page);
        self.hud = Utils.creatHUD();
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {

        if (searchBar.text?.characters.count  == 0) {
            return;
        }else{
            self.msearch.resignFirstResponder();
            let vc =  SearchResultVC(withSearchKeyWord: searchBar.text);
            self.navigationController?.pushViewController(vc, animated: true);
        }
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.msearch.resignFirstResponder();
    }


//  MARK:-  数据解析
    override func parserResult(res: AnyObject?) {
        self.hud.hide(true, afterDelay: 1);
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
        cell?.shopCarBlock = {[weak self]() in
            let alert = Utils.openWechat();
            self!.presentViewController(alert, animated: true, completion: nil);

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
