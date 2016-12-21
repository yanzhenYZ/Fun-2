//
//  GlobalManager.m
//  Funny
//
//  Created by yanzhen on 16/11/25.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "GlobalManager.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD+YZZ.h"

@implementation GlobalManager
MShareInstance(Manager)
-(void)saveImage:(UIImage *)image{
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != nil) {
        [MBProgressHUD showMessage:@"保存失败" success:NO stringColor:[UIColor redColor]];
    }else{
        [MBProgressHUD showMessage:@"已保存到相册" success:YES stringColor:[UIColor redColor]];
    }
}

-(CGSize)labelSize:(NSString *)text font:(CGFloat)font width:(CGFloat)width{
    CGSize oldSize = CGSizeMake(width, MAXFLOAT);
    return [text boundingRectWithSize:oldSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
}
#pragma mark - SDWebImageManager
+ (void)clearCache:(void (^)())block{
    SDWebImageManager *manage=[SDWebImageManager sharedManager];
    [manage cancelAll];
    [manage.imageCache clearMemory];
    [manage.imageCache clearDiskOnCompletion:^{
        if (block) {
            block();
        }
    }];
}

+ (NSUInteger)getCacheSize{
    SDWebImageManager *manage=[SDWebImageManager sharedManager];
    return [manage.imageCache getSize];
}
@end
