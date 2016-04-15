//
//  HTML.h
//  MenTouGou
//
//  Created by 袁昊 on 16/4/14.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTML : NSObject
+ (NSString *)HTMLWithData:(NSDictionary *)data usingTemplate:(NSString *)templateName;
@end
