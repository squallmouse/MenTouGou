//
//  YHStartMarkView.m
//  小星星评分
//
//  Created by 袁昊 on 15/12/8.
//  Copyright © 2015年 squallmouse. All rights reserved.
//

#import "YHStartMarkView.h"


#define kBACKGROUND_STAR @"icon_collected_seller_stars_default"
#define kFOREGROUND_STAR @"icon_collected_seller_stars_full"

@interface YHStartMarkView ()

@property(nonatomic,strong)UIView *backgroundStarView;
@property(nonatomic,strong)UIView *frontStarView;

@end


@implementation YHStartMarkView

//初始化

-(instancetype)initWithFrame:(CGRect)frame{

   self = [self initWithFrame:frame WithStarNumber:5];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _numberOfStar = 5;
    [self commonInit];
}


-(instancetype)initWithFrame:(CGRect)frame WithStarNumber:(NSInteger)number{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        [self commonInit];
    }
    return self;
}
//前景 背景View 初始化
- (void)commonInit
{
    self.backgroundStarView = [self buidlStarViewWithImageName:kBACKGROUND_STAR];
    self.frontStarView = [self buidlStarViewWithImageName:kFOREGROUND_STAR];
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.frontStarView];
}

//
- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}


- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion
{
//    NSAssert((score >= 0.0)&&(score <= 1.0), @"score must be between 0 and 1");
    
    if (score < 0)
    {
        score = 0;
    }
    
    if (score > 1)
    {
        score = 1;
    }
    
    CGPoint point = CGPointMake(score * self.frame.size.width, 0);
    
    if(isAnimate)
    {
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:0.2 animations:^
         {
             [weakSelf changeStarForegroundViewWithPoint:point];
             
         } completion:^(BOOL finished)
         {
             if (completion)
             {
                 completion(finished);
             }
         }];
    }
    else
    {
        [self changeStarForegroundViewWithPoint:point];
    }
}

/**
 *  通过坐标改变前景视图
 *
 *  @param point 坐标
 */
- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0)
    {
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    p.x = score * self.frame.size.width;
    self.frontStarView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)])
    {
        [self.delegate starRatingView:self score:score];
    }
}


@end
