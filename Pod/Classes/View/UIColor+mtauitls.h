//
//  UIColor+mtauitls.h
//  Pods
//
//  Created by 余卓 on 2017/9/13.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (mtauitls)

+ (UIColor *)nvColorWithHexString:(NSString *)hexString;

+ (UIColor *)nvColorWithIntRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;
+ (UIColor *)nvColorWithIntRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(NSInteger)a;

@end
