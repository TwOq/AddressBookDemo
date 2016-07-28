//
//  UIColor+hex.h
//  NoCardPay
//
//  Created by lizq on 16/5/13.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)
//十六进制生成颜色
+ (UIColor *)colorWithHexString:(NSString *)color;
@end