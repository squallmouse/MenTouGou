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
        
//        初始化百度地图
        self.mapView = BMKMapView(frame:self.view.bounds);
        self.view = self.mapView;
        self.mapView.showsUserLocation = true;
        self.mapView.delegate = self;
        
//        放大缩小按钮
//        for i in 0 ..< 2{
//            print(11);
//        }
//
          self.userLocation =   ((UIApplication.sharedApplication().delegate)as! AppDelegate).userLocation
        

//       请求接口
        if (self.userLocation != nil) {
            
        self.mapView.updateLocationData(self.userLocation);
        let latitude = NSString(format: "%f", (self.userLocation?.location.coordinate.latitude)!);

        let longitude = NSString(format: "%f", (self.userLocation?.location.coordinate.longitude)!);
//            self.userLocation?.location.coordinate.longitude ;
        
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
        }else{
            let hud = Utils.creatHUD();
            hud.labelText = "未获取到用户当前位置";
            hud.hide(true, afterDelay: 1);
        }
    }

    func addPoint() -> Void {
        
        for i in 0 ..< self.dataArr.count{
//            let annotation =
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
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
//        let tempView = view as YHBMKPointAnnotation;
//        tempView.theTag
        print("sele");
    }
    
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
    func parserDataWithArr(arr:NSArray) -> Void {
        for i in 0 ..< arr.count {
            self.dataArr.addObject(arr[i]);
        }
        
        self.addPoint();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
