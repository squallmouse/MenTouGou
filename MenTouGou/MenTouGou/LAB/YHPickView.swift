//
//  YHPickView.swift
//  YHPickView
//
//  Created by 袁昊 on 16/4/22.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

typealias YHPickViewBlock = (item:String) -> Void;

class YHPickView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var mpickView: UIPickerView!

    @IBOutlet var contentView: UIView!
    var componentArr:NSArray!;
    var rowArr:NSArray!;
    var yhpickview_block:YHPickViewBlock? ;

    var comStr:String!;
    var rowStr:String!;
    var result:String!;

//初始化
    init(withComponentArr componentarr:NSArray,androwArr rowArr:NSArray) {
        super.init(frame: UIScreen.mainScreen().bounds);
        self.componentArr = componentarr;
        self.rowArr = rowArr;
        self.awakeFromNib();

        self.comStr = "3";
        self.rowStr = "5";

        self.result = self.comStr + self.rowStr ;
        self.mpickView.delegate = self;
        self.mpickView.dataSource = self;
        self.mpickView.selectRow(2, inComponent: 0, animated: false);
        self.mpickView.selectRow(5, inComponent: 1, animated: false);
    }

    override func awakeFromNib() {
        self.contentView = (NSBundle.mainBundle().loadNibNamed("YHPickView", owner: self, options: nil)as NSArray).lastObject as! UIView;
        self.contentView.frame = self.bounds;
        self.addSubview(self.contentView);

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//  MARK:-  pickview delegate

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2;
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return self.componentArr.count;
        }else{
            return self.rowArr.count;
        }
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return (self.componentArr[row]as! String);
        }else{
            return self.rowArr[row]as? String;
        }
    }

    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40;
    }

    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100;
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
//            let rangeq = Range.init(start: self.result.startIndex, end: self.result.startIndex.advancedBy(1));
//            let range = Range.init(self.result.startIndex...self.result.startIndex.advancedBy(1));
//            self.result.replaceRange(range, with: self.componentArr[row]as! String);

            self.comStr = self.componentArr[row]as! String;
        }else{
//            let range = Range.init(self.result.startIndex.advancedBy(1) ... self.result.startIndex.advancedBy(2));
//            self.result.replaceRange(range, with: self.rowArr[row]as! String);
            self.rowStr = self.rowArr[row]as! String;
        }

        self.result = self.comStr + self.rowStr ;

    }

    
//  MARK:-  按钮点击事件
//    取消按钮
    @IBAction func confirmBtnClickDown(sender: AnyObject) {
        self.yhpickview_block?(item:self.result);
        self.removeFromSuperview();

    }

//    确认按钮
    @IBAction func cancleBtnClickDown(sender: AnyObject) {
        self.removeFromSuperview();

    }

}
