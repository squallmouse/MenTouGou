//
//  BaseTableViewVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/11.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

typealias GETUrl = (Int!) -> (String! , [String : AnyObject]?);

class BaseTableViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var mtableView:UITableView!;
    var page:Int!;
//    获取URL  Block
    var getUrl = GETUrl?();
    
//    装填数据的数组
    var dataArr:NSMutableArray!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.dataArr = NSMutableArray(capacity: 0);
        page = 1;
        
        self.mtableView = UITableView(frame: CGRectMake(0, 64 + 40 , s_width, s_height - 64 - 40 - 49));
        self.view.addSubview(self.mtableView);
        self.mtableView.delegate = self;
        self.mtableView.dataSource = self;
        self.mtableView.tableFooterView = UIView();
        
        self.mtableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.page = 1;
            self.mtableView.mj_footer.hidden = false;
            self.httpData(self.page);
        })
        self.mtableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.page = self.page + 1;
            self.httpData(self.page);
        })
        
        
    }
    
    
    
    func httpData(page:Int ) -> Void {
        let urlTuple = self.getUrl!(page);
        YHAlamofire.Get(urlStr: urlTuple.0, paramters: urlTuple.1, success: { (res) in
            
            self.stopRefresh();
            
            if(self.page == 1){
//                如果是刷新 就清空数据
                self.dataArr.removeAllObjects();
            }
            
            self.parserResult(res);
            if(res?.count == 0){
            self.mtableView.mj_footer.hidden = true;
            }
            self.mtableView.reloadData();
            }) { (failedRes) in
                self.stopRefresh();
                print("请求失败 = \(failedRes)");
        }
    }
//  MARK:-  子类重写解析方式
    
    
//子类重写解析方式
    func parserResult(res:AnyObject?) -> Void {
        print("进入解析 parserResult");
        
    }
    
    
//  MARK:-  需要在子类重写的方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
//   
//  MARK:-  停止刷新
    func stopRefresh() -> Void {
        if(self.mtableView.mj_header.isRefreshing()){
            self.mtableView.mj_header.endRefreshing();
        }
        if(self.mtableView.mj_footer.isRefreshing()){
            self.mtableView.mj_footer.endRefreshing();
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
