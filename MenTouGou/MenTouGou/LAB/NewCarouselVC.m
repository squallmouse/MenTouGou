//
//  CarouselVC.m
//  iosapp
//
//  Created by 袁昊 on 16/2/16.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import "NewCarouselVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewCarouselVC ()<UIScrollViewDelegate>
{
    NSTimer *_timer;
    NSArray *_urlArr;
}
@property(nonatomic,strong)UIScrollView *sc;


@property(nonatomic,strong)UIImageView *img1;
@property(nonatomic,strong)UIImageView *img2;
@property(nonatomic,strong)UIImageView *img3;
@property(nonatomic,strong)UIPageControl *pagec;
@property(nonatomic,assign)int page;

@property(nonatomic,assign)CGFloat lastX;

@end

@implementation NewCarouselVC
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"car WillDisappear");
}

-(void)dealloc{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(instancetype)initWithFrame:(CGRect)frame WithPicArr:(NSArray*)picArr withUrlArr:(NSArray*)urlArr {
    self = [super init];
    if (self) {
        self.type = imageurl;
        self.rect = frame;
        self.arr = [[NSArray alloc]initWithArray:picArr];
        self.view.frame = self.rect;
        _urlArr = [[NSArray alloc]initWithArray:urlArr];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame WithPicArr:(NSArray*)picArr andimageType:(imagetype)type{
    self = [super init];
    if (self) {
        self.type = type;
        self.rect = frame;
        self.arr = [[NSArray alloc]initWithArray:picArr];
        self.view.frame = self.rect;
        
        
    }
    return  self;
}
-(void)replaceWithUrlArr:(NSArray*)urlArr WithImgArr:(NSArray*)imgArr{
    self.arr = imgArr;
    _urlArr = urlArr;
//[self setPageWithScroll:self.sc];
}
-(void)setTimeWithSecond:(int)second{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        _timer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(timeRun) userInfo:nil            repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//        [[NSRunLoop currentRunLoop] run];
//    });
    
}
-(void)timeRun{
//    NSLog(@"1111= %f",self.sc.contentOffset.x);
    if (abs((int)(self.sc.contentOffset.x - self.rect.size.width)) < 10) {

        [self.sc setContentOffset:CGPointMake(self.sc.contentOffset.x+self.rect.size.width, 0) animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setPageWithScroll:self.sc];
        });
    }
      
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.sc = [[UIScrollView alloc]initWithFrame:self.rect];
    self.sc.contentSize = CGSizeMake(self.sc.frame.size.width*3, self.sc.frame.size.height);
    self.sc.bounces = NO;
    
    self.sc.pagingEnabled = true;
//    self.sc.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.sc];
    self.sc.delegate = self;
    
    _img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.sc.frame.size.width*0, 0, self.sc.frame.size.width, self.sc.frame.size.height)];

    _img2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.sc.frame.size.width*1, 0, self.sc.frame.size.width, self.sc.frame.size.height)];
//    
 
//    
    _img3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.sc.frame.size.width*2, 0, self.sc.frame.size.width, self.sc.frame.size.height)];
    _img1.contentMode = UIViewContentModeScaleAspectFill;
    _img2.contentMode = UIViewContentModeScaleAspectFill;
    _img3.contentMode = UIViewContentModeScaleAspectFill;
    
    
//    _img1.backgroundColor = [UIColor orangeColor];
//    _img2.backgroundColor = [UIColor purpleColor];
//    _img3.backgroundColor = [UIColor blueColor];
    switch (self.type) {
        case imagename:
        {
            _img2.image = [UIImage imageNamed:self.arr[self.picNum]];
            
            if (self.picNum == self.arr.count-1) {
                 _img3.image = [UIImage imageNamed:self.arr[0]];
                
            }else{
                _img3.image = [UIImage imageNamed:self.arr[self.picNum+1]];
               
            }
            if (self.picNum == 0) {
                _img1.image = [UIImage imageNamed:self.arr[self.arr.count-1]];
               
            }else{
                _img1.image = [UIImage imageNamed:self.arr[self.picNum-1]];
                
            }

        }
            break;
        case imageurl:
        {
            [_img2 sd_setImageWithURL:[NSURL URLWithString:self.arr[self.picNum]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
            if (self.picNum == self.arr.count-1) {
                [_img3 sd_setImageWithURL:[NSURL URLWithString:self.arr[0]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
            }else{
                [_img3 sd_setImageWithURL:[NSURL URLWithString:self.arr[self.picNum+1]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
            }
            if (self.picNum == 0) {
                [_img1 sd_setImageWithURL:[NSURL URLWithString:self.arr[self.arr.count-1]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
            }else{
                [_img1 sd_setImageWithURL:[NSURL URLWithString:self.arr[self.picNum-1]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
            }
        }
            break;
        default:
            break;
    }
    
    
    [self.sc addSubview:_img1];
    [self.sc addSubview:_img2];
    [self.sc addSubview:_img3];
    self.sc.contentOffset = CGPointMake(self.sc.frame.size.width, 0);
    _page = self.picNum;
    self.sc.showsHorizontalScrollIndicator = NO;
    
    self.pagec = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.rect.size.height-15, self.sc.frame.size.width, 15)];
//    self.pagec.center = CGPointMake(self.rect.size.width/2, self.rect.size.height-30);
    [self.view addSubview:self.pagec];
    self.pagec.alpha = 1;
    self.pagec.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pagec.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    self.pagec.numberOfPages = self.arr.count;
    self.pagec.currentPage = _page;
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.sc addGestureRecognizer:tap];
    
    if (self.arr.count == 1) {
        self.sc.scrollEnabled = NO;
    }
    
    NSLog(@"%f",self.view.frame.size.width);
    
}


-(void)back{

    NSLog(@"%d",_page);
    
    if (self.picClickDown) {
        if (_urlArr.count > 0) {
            self.picClickDown(_urlArr[_page]);
        }
        
    }
}


-(void)setPageWithScroll:(UIScrollView*)scrollView{
    
    if (scrollView.contentOffset.x == self.rect.size.width) {
        return;
    }
    
    NSInteger imgnum1 = 0;
    NSInteger imgnum3 = 0;
    if (scrollView.contentOffset.x > scrollView.contentSize.width/2) {
//
        
        _page++;
        imgnum1 = _page-1;
        imgnum3 = _page+1;
        if (_page == (self.arr.count-1)) {
            imgnum3 = 0;
        }
        if (_page == self.arr.count) {
            _page = 0;
            imgnum3 = _page +1;
            imgnum1 = self.arr.count-1;
        }
        
    }else{
        
        _page--;
        imgnum1 = _page -1;
        imgnum3 = _page +1;
        if (_page == 0) {
            imgnum1 = self.arr.count -1;
        }
        if (_page < 0) {
            _page = (int)(self.arr.count-1);
            imgnum1 = _page -1;
            imgnum3 = 0;
        }
    }
    switch (self.type) {
        case imagename:
        {
            _img1.image = [UIImage imageNamed:self.arr[imgnum1]];
            _img2.image = [UIImage imageNamed:self.arr[_page]];
            _img3.image = [UIImage imageNamed:self.arr[imgnum3]];
        }
            break;
        case imageurl:
        {
            [_img1 sd_setImageWithURL:[NSURL URLWithString:self.arr[imgnum1]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
            [_img2 sd_setImageWithURL:[NSURL URLWithString:self.arr[_page]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
            [_img3 sd_setImageWithURL:[NSURL URLWithString:self.arr[imgnum3]]placeholderImage:[UIImage imageNamed:@"img_product_default.jpg"]];
        }
            break;
            
        default:
            break;
    }
    
    
    
    self.pagec.currentPage = _page;
    
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, scrollView.contentOffset.y);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"112233 = %f",scrollView.contentOffset.x);
    
    
    [self setPageWithScroll:scrollView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
