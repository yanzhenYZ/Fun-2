//
//  GlobalManager.h
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalManager : NSObject
HShareInstance(Manager)
-(void)saveImage:(UIImage *)image;
-(CGSize)labelSize:(NSString *)text font:(CGFloat)font width:(CGFloat)width;

+ (void)clearCache:(void (^)())block;
+ (NSUInteger)getCacheSize;
@end
