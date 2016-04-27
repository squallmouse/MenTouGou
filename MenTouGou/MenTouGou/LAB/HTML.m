//
//  HTML.m
//  MenTouGou
//
//  Created by 袁昊 on 16/4/14.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

#import "HTML.h"
#import "GRMustache.h"
#import <UIKit/UIKit.h>

@implementation HTML

+ (NSString *)HTMLWithData:(NSDictionary *)data usingTemplate:(NSString *)templateName
{
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:templateName ofType:@"html" inDirectory:@"html"];
    NSString *template = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableDictionary *mutableData = [data mutableCopy];
//    [mutableData setObject:@(((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode)
//                    forKey:@"night"];
    
    return [GRMustacheTemplate renderObject:mutableData fromString:template error:nil];
}


//+ (UIImage *)imageWithColor:(UIColor *)color withImage:(UIImage*)image
//{
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
//    CGContextRefcontext = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 0, self.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    CGContextClipToMask(context, rect, self.CGImage);
//    [color setFill];
//    CGContextFillRect(context, rect);
//    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}

@end
