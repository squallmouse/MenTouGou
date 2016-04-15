//
//  CarouselVC.h
//  iosapp
//
//  Created by 袁昊 on 16/2/16.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    imagename,
    imageurl,
    
} imagetype;



@interface NewCarouselVC : UIViewController
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,assign)int picNum;
@property(nonatomic,assign)CGRect rect;
@property(nonatomic,assign)imagetype type;

@property(nonatomic,copy)void (^picClickDown)(NSString* url);
-(void)replaceWithUrlArr:(NSArray*)urlArr WithImgArr:(NSArray*)imgArr;
-(instancetype)initWithFrame:(CGRect)frame WithPicArr:(NSArray*)picArr andimageType:(imagetype)type;
-(instancetype)initWithFrame:(CGRect)frame WithPicArr:(NSArray*)picArr withUrlArr:(NSArray*)urlArr;

-(void)setTimeWithSecond:(int)second;
@end
