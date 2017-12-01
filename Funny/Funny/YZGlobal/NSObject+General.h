//
//  NSObject+General.h
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (General)

@property (nonatomic, copy) NSString *appName;

@end
#pragma mark - NSString
@interface NSString (General)
+ (NSString *)dateWithTimeInterval:(NSTimeInterval)time;
+ (NSString *)currentTime;
-(long long)timeStringToLongLong;
- (BOOL)isURLOrNot;
- (NSInteger)fileSize;
- (void)writeLogToFile:(NSString *)path;
@end

#pragma mark - UIView

@interface UIView (General)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign, readonly) CGFloat maxX;
@property (nonatomic, assign, readonly) CGFloat maxY;

//可以在XIB keyPath设置属性
//@property (nonatomic, assign) CGFloat borderWidth;
//@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

- (void)corner;
- (void)borderWidthAndCorner:(CGFloat)borderWidth;
- (void)lockManageBorderWidth:(CGFloat)borderW;
@end

#pragma mark - UIImageView
@interface UIImageView (General)
- (void)yz_setImageWithURL:(NSString *)urlString placeholderImage:(NSString *)imageName;
- (void)yz_setImageWithURL:(NSString *)urlString;
@end

#pragma mark - UIImage
@interface UIImage (General)
+ (UIImage *)snapshotScreenInView:(UIView *)contentView;
+ (instancetype)imageWithCaptureView:(UIView *)view;
+ (UIImage *)imageNamedWithTabBar:(NSString *)name;
+ (UIImage *)imageNamedWithFunny:(NSString *)name;
+ (UIImage *)imageNamedWithHZW:(NSString *)name;
@end
