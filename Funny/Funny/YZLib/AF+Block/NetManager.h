//
//  NetManager.h
//  Y&Z
//
//  Created by yanzhen on 16/6/7.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define JSON @"application/json"
//#define XMLL @"text/html"
typedef void(^GetDataFinishedBlock)(id responseObj);
typedef void(^GetDataFailedBlock)(NSString *error);

@interface NetManager : NSObject
/**
 * @brief Get请求的方法
 *
 * @param urlString           网址
 * @param finishedBlock       请求成功
 * @param failedBlock         请求失败
 *
 */
+ (void)requestDataWithURLString:(NSString *)urlString finished:(GetDataFinishedBlock)finishedBlock failed:(GetDataFailedBlock)failedBlock;

/**
 * @brief POST请求的方法
 *
 * @param urlString           网址
 * @param finishedBlock       请求成功
 * @param failedBlock  请求失败
 *
 */
+ (void)POSTWithURLString:(NSString *)urlString parameters:(id)parameters finished:(GetDataFinishedBlock)finishedBlock failed:(GetDataFailedBlock)failedBlock;

@end
