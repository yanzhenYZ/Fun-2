//
//  NSObject+General.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "NSObject+General.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

static void * key = (void *)@"AppName";
@implementation NSObject (General)
-(void)setAppName:(NSString *)appName{
    objc_setAssociatedObject(self, key, appName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)appName{
    return objc_getAssociatedObject(self, key);
}

@end

#pragma mark - NSString
@implementation NSString (General)
+ (NSString *)dateWithTimeInterval:(NSTimeInterval)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format stringFromDate:date];
}
+ (NSString *)currentTime
{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    long long currentLonglongTime=(long long)currentTime;
    NSString *urlString=[NSString stringWithFormat:@"%lld",currentLonglongTime];
    return urlString;
}

-(long long)timeStringToLongLong{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [format dateFromString:self];
    return (long long)[date timeIntervalSince1970];
}

- (BOOL)isURLOrNot{
    NSString *regulaStr = @"(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?))'>((?!<\\/a>).)*<\\/a>|(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?))";
    NSRange range = [self rangeOfString:regulaStr options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) return NO;
    return YES;
}

- (NSInteger)fileSize{
    NSInteger fileSize = 0;
    NSFileManager *fileManage = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exist = [fileManage fileExistsAtPath:self isDirectory:&isDir];
    if (exist) {
        if (isDir) {
            NSArray *subPaths = [fileManage subpathsAtPath:self];
            for (NSString *subpath in subPaths) {
                NSString *path = [self stringByAppendingPathComponent:subpath];
                BOOL isDirectory = NO;
                [fileManage fileExistsAtPath:path isDirectory:&isDirectory];
                if (!isDirectory) {
                    fileSize += [[fileManage attributesOfItemAtPath:path error:nil][NSFileSize] integerValue];
                }
            }
        }else{
            fileSize = [[fileManage attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
        }
    }
    return fileSize;
}
- (void)writeLogToFile:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createFileAtPath:path contents:nil attributes:nil];
    }
    FILE *fp=fopen(path.UTF8String,"a+");
    fseek(fp, 0, SEEK_END);
    fwrite(self.UTF8String, strlen(self.UTF8String), 1, fp);
    fwrite("\n", strlen("\n"), 1, fp);
    fclose(fp);
}
@end

#pragma mark - UIView
@implementation UIView (General)
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint cenetr = self.center;
    cenetr.x = centerX;
    self.center = cenetr;
}

-(CGFloat)centerY{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint cenetr = self.center;
    cenetr.y = centerY;
    self.center = cenetr;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}


-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

-(CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}

-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

-(UIColor *)borderColor{
    return objc_getAssociatedObject(self, @selector(borderColor));
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}

#pragma mark - ****
//-(void)setBorderWidth:(CGFloat)borderWidth{
//    self.layer.borderWidth = borderWidth;
//}
//
//-(CGFloat)borderWidth{
//    return self.layer.borderWidth;
//}
//
//-(void)setBorderColor:(UIColor *)borderColor{
//    self.layer.borderColor = borderColor.CGColor;
//}
//
//-(UIColor *)borderColor{
//    return [UIColor colorWithCGColor:self.layer.borderColor];
//}

- (void)corner
{
    [self layoutIfNeeded];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.width/2;
}
- (void)borderWidthAndCorner:(CGFloat)borderWidth
{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.width/2;
    self.layer.borderWidth=borderWidth;
    self.layer.borderColor=YZColor(89, 76, 102).CGColor;
}
- (void)lockManageBorderWidth:(CGFloat)borderW
{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.width/2;
    self.layer.borderWidth=borderW;
    self.layer.borderColor=YZColor(93, 187, 210).CGColor;
}

@end

#pragma mark - UIImageView
@implementation UIImageView (General)
- (void)yz_setImageWithURL:(NSString *)urlString placeholderImage:(NSString *)imageName{
    NSURL *url = [NSURL URLWithString:urlString];
    UIImage *image = [UIImage imageNamed:imageName];
    [self sd_setImageWithURL:url placeholderImage:image];
}
@end

#pragma mark - UIImage
@implementation UIImage (General)

+ (UIImage *)imageNamedWithHZW:(NSString *)name{
    NSString *imageName = [@"YZSource.bundle/HZW/" stringByAppendingString:name];
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)imageNamedWithFunny:(NSString *)name{
    NSString *imageName = [@"YZSource.bundle/Funny/" stringByAppendingString:name];
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)imageNamedWithTabBar:(NSString *)name{
    NSString *imageName = [@"YZSource.bundle/TabBar/" stringByAppendingString:name];
    return [UIImage imageNamed:imageName];
}


+ (instancetype)imageWithCaptureView:(UIView *)view{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 渲染控制器view的图层到上下文
    // 图层只能用渲染不能用draw
    [view.layer renderInContext:ctx];
    
    // 获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
