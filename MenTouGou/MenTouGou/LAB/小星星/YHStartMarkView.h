//
//  YHStartMarkView.h
//  小星星评分
//
//  Created by 袁昊 on 15/12/8.
//  Copyright © 2015年 squallmouse. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YHStartMarkView;
@protocol StarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(YHStartMarkView *)view score:(float)score;

@end


@interface YHStartMarkView : UIView

@property(nonatomic,assign,readonly)NSInteger numberOfStar;

@property(nonatomic,assign)id<StarRatingViewDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)frame;

- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;

@end
