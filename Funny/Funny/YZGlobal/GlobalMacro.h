//
//  GlobalMacro.h
//  Funny
//
//  Created by yanzhen on 16/7/13.
//  Copyright © 2016年 Y&Z. All rights reserved.
//


#define DocumentsPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define isIpad() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define SYSTEMVERSON ([[UIDevice currentDevice].systemVersion floatValue])
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define YZWeakSelf(type) __weak typeof(type) weak##type = type;
#define YZBlockSelf(type) __block typeof(type) block##type = type;
#define YZStrongSelf(type) __strong typeof(type) strong##type = type;
#define YZColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define FunnyColor [UIColor colorWithRed:1.0 green:133/255.0 blue:25/255.0 alpha:1]

#define HOMEIMAGEPATH [DocumentsPath stringByAppendingPathComponent:@"homeBackGroundImage/image.data"]

UIKIT_EXTERN NSString *const YZ;
UIKIT_EXTERN NSString *const PassWordOne;
UIKIT_EXTERN NSString *const PassWordTwo;
UIKIT_EXTERN NSString *const PasswordIsYES;
UIKIT_EXTERN NSString *const PasswordIsWrong;
UIKIT_EXTERN NSString *const NoteLockPassword;

UIKIT_EXTERN NSString *const HOMEBACKGROUNDIMAGENAME;

#pragma mark - Content
UIKIT_EXTERN const CGFloat CONTENTSPACE;
UIKIT_EXTERN const CGFloat COMMENTVIEWSPACE;
UIKIT_EXTERN const CGFloat USERVIEWHEIGHT;

UIKIT_EXTERN CGFloat const USERNAMELABELFONT;
UIKIT_EXTERN CGFloat const CREATTIMELABELFONT;
UIKIT_EXTERN CGFloat const USERTEXTMAINLABELFONT;

#pragma mark - Root
UIKIT_EXTERN const CGFloat RootTopSpace;
UIKIT_EXTERN const CGFloat IconWidth;
UIKIT_EXTERN const CGFloat IconHeight;

#pragma mark - NOTE
UIKIT_EXTERN NSString *const NOTEPASSWORD;

#pragma mark - NOTE
UIKIT_EXTERN NSString *const MANAGERPASSWORD;


