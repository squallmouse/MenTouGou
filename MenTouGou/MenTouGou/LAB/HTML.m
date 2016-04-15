//
//  HTML.m
//  MenTouGou
//
//  Created by 袁昊 on 16/4/14.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

#import "HTML.h"
#import "GRMustache.h"

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

@end
