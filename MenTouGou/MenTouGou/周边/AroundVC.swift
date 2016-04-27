//
//  AroundVC.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class AroundVC: UIViewController,BMKMapViewDelegate {
    var mapView:BMKMapView!
    var userLocation : BMKUserLocation?
    var dataArr : NSMutableArray!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "周边"
        self.view.backgroundColor = UIColor.whiteColor();
        self.dataArr = NSMutableArray(capacity: 0);
//        
        let item = UIBarButtonItem(image: UIImage(named: "ic_product_list"), style: .Plain, target: self, action: #selector(AroundVC.rightNavBtnClickDown));
        self.navigationItem.rightBarButtonItem = item;
        
        
//        初始化百度地图
        self.mapView = BMKMapView(frame:self.view.bounds);
        self.view.addSubview(self.mapView);
        self.mapView.showsUserLocation = true;
        self.mapView.delegate = self;
        
        
//        放大缩小按钮
        for i in 0 ..< 2{
            let btn = UIButton(type: .System);
            btn.tag = 8900 + i;
            
            if i == 0 {
                btn.frame = CGRectMake(s_width-140, s_height-110, 60, 40);
               btn.setTitle("-", forState: .Normal)
                
                let lineView = UIView(frame: CGRectMake(59 ,5 ,1,30));
                btn.addSubview(lineView);
                lineView.backgroundColor = UIColor.colorWithHexString("999999")
            }else{
                btn.frame = CGRectMake(s_width-80, s_height-110, 60, 40);
                btn.setTitle("+", forState: .Normal)
            }
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal);
            btn.titleLabel?.font = UIFont.systemFontOfSize(30);
            btn.backgroundColor = UIColor.whiteColor();
            btn.addTarget(self, action: #selector(AroundVC.btnClickDown), forControlEvents: .TouchUpInside);
            self.view.addSubview(btn);
        }
//
          self.userLocation =   ((UIApplication.sharedApplication().delegate)as! AppDelegate).userLocation
        

//       请求接口
        var latitude:NSString!;
        var longitude:NSString!;
        if (self.userLocation != nil) {
        self.mapView.updateLocationData(self.userLocation);

         latitude = NSString(format: "%f", (self.userLocation?.location.coordinate.latitude)!);
         longitude = NSString(format: "%f", (self.userLocation?.location.coordinate.longitude)!);

        }else{

            latitude = "39.988";
            longitude = "116.113";

            let hud = Utils.creatHUD();
            hud.labelText = "未定位成功";
            hud.hide(true, afterDelay: 1);
        }


        let urlStr = MTG + NEARLEISURELIST + (latitude as String)  + "/" + (longitude as String)  + "?";
        let paramters = [
            "count" : "10"
        ];

        YHAlamofire.Get(urlStr: urlStr, paramters: paramters, success: { (res) in
            let arr = res as! NSArray;
            self.parserDataWithArr(arr);
            print(arr);
        }) { (Failedres) in

        }
    }

//  MARK:-  按钮
    func btnClickDown(btn:UIButton) -> Void {
        var region = self.mapView.region;
        var span = region.span;
        if btn.tag == 8900 {
//       - 缩小地图
            span.latitudeDelta = span.latitudeDelta * 1.5;
            span.longitudeDelta = span.longitudeDelta * 1.5;
            
        }else{
//        +放大地图
            span.latitudeDelta = span.latitudeDelta * 0.6;
            span.longitudeDelta = span.longitudeDelta * 0.6;
           
        }
        
        region.span = span;
        
        self.mapView.setRegion(region, animated: true);
    }
    
    
//      添加大头针
    func addPoint() -> Void {
        
        for i in 0 ..< self.dataArr.count{
            let dic = self.dataArr[i];
            let annotation =  YHBMKPointAnnotation(with: i, withContentStr: (dic["Title"]as? String)!)

            
            let Coordinate = (dic["Coordinate"]as! String).componentsSeparatedByString(",") as NSArray;
            let lati = Coordinate[1].doubleValue;
            let long = Coordinate[0].doubleValue;
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: lati, longitude: long )
            
//            annotation.title = dic["Title"]as? String;

            self.mapView.addAnnotation(annotation as BMKAnnotation);
            
        }
    }

//    自定义大头针
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {

        let anno = annotation as! YHBMKPointAnnotation;
        
        let bmkView = YHCoustomAnnotationView(annotation: annotation, reuseIdentifier: "iden", withTitle: anno.contentStr,Withtag: anno.tag);
        bmkView.tapBlcok = {[weak self](tag) in
            let webDetail = WebDetailVC.init(withDataDic: self?.dataArr[tag]as! NSDictionary);
            
            webDetail.hidesBottomBarWhenPushed = true;
            self!.navigationController?.pushViewController(webDetail, animated: true);
            
        }
        
        return bmkView;
    }
    
//    数据解析
    func parserDataWithArr(arr:NSArray) -> Void {
        for i in 0 ..< arr.count {
            self.dataArr.addObject(arr[i]);
        }
        
        self.addPoint();
        self.theMapViewToLocate(self.dataArr);
    }
    
//    地图视角定位
    
    func theMapViewToLocate(arr:NSArray) -> Void {
        var lati:Double = 0;
        var long:Double = 0;
        for i in 0 ..< self.dataArr.count{

            let dic = self.dataArr[i];
            let Coordinate = (dic["Coordinate"]as! String).componentsSeparatedByString(",") as NSArray;
             lati += Coordinate[1].doubleValue;
             long += Coordinate[0].doubleValue;
        }
        
        lati /= Double(self.dataArr.count);
        long /= Double(self.dataArr.count);
        
        let region = BMKCoordinateRegion(center: CLLocationCoordinate2DMake(lati, long), span: BMKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25));
        
            self.mapView.setRegion(region, animated: true);
    }
    
    
    func rightNavBtnClickDown() -> Void {
        let vc = DetailVC();
        vc.chop1 = "0";
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
