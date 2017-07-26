//
//  NetManager.m
//  test
//
//  Created by yanzhen on 16/6/7.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "NetManager.h"
#import "AFNetworking.h"

@implementation NetManager


+ (void)requestDataWithURLString:(NSString *)urlString finished:(GetDataFinishedBlock)finishedBlock failed:(GetDataFailedBlock)failedBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 12;
    //安全策略
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        finishedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failedBlock(error.localizedDescription);
    }];
}

+ (void)POSTWithURLString:(NSString *)urlString parameters:(id)parameters finished:(GetDataFinishedBlock)finishedBlock failed:(GetDataFailedBlock)failedBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finishedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error.localizedDescription);
    }];
}
@end
