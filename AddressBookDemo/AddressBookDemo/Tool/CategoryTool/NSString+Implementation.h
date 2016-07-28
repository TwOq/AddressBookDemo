//
//  NSString+Implementation.h
//  NoCardPay
//
//  Created by lizq on 16/5/24.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Implementation)
//银行卡号处理转换：前8后4，中间*
+ (NSString*)cardStringFromNormal:(NSString *)string;
//判断是否为空
+(BOOL)hasLength:(NSString*)string;
//url编码   需要编码的字符要根据项目接口要求重设
- (NSString*)urlEncodedString;
@end
