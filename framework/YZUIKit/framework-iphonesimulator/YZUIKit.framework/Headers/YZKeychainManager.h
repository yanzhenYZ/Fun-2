//
//  YZKeychainManager.h
//
//  Created by yanzhen.
//

#import <Foundation/Foundation.h>

@interface YZKeychainManager : NSObject
/*!
 @abstract 第一次获取设备UUID，会自动生成一个UUID然后保存到keychain。
 @param bundleID 可以是APP的Bundle identifier也可以设置一个标识符
 @result 返回结果是一个UUID。如果你不删除，或者重置UUID，当你删除APP之后，这个UUID不会丢失。
 */
+ (NSString * _Nonnull)getDeviceUUIDWithBundleID:(NSString  * _Nonnull)bundleID;

/*!
 @abstract 通过一个标识符存储一些数据到keychain
 @param item 存储在keychain的数据,如果是一个OC对象必须遵守NSCoding协议
 @param identifier 自定义的一个标识符
 */
+ (void)saveKeyChainItem:(id _Nonnull)item identifier:(NSString * _Nonnull)identifier;

/*!
 @abstract 通过一个标识符获取存储在keychain的数据
 @param identifier 自定义的一个标识符
 @result 返回结果是标识符对应的数据
 */
+ (id __nullable)getKeyChainItemWithIdentifier:(NSString * _Nonnull)identifier;

/*!
 @abstract 通过一个标识符删除存储在keychain的数据
 @param identifier 自定义的一个标识符
 */
+ (void)deleteKeyChainItemWithIdentifier:(NSString * _Nonnull)identifier;
@end
