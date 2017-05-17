//
//  YZAVMark.h
//  YZPlayer
//
//  Created by yanzhen.
//

#import <UIKit/UIKit.h>

/*! see #import <UIKit/NSStringDrawing.h>
- (void)drawInRect:(CGRect)rect withAttributes:(nullable NSDictionary<NSString *, id> *)attrs;
 */
NS_CLASS_AVAILABLE_IOS(7_0) @interface YZAVMark : NSObject

@property (nonatomic) CGRect rect;

@property (nonatomic, copy) NSString *mark;

@property (nonatomic, strong) NSDictionary<NSString *, id> *attrs;

-(instancetype)initWithMark:(NSString *)mark rect:(CGRect)rect attributes:(NSDictionary<NSString *, id> *)attrs;
@end
