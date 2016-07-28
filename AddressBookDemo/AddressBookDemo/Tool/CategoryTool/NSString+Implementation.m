//
//  NSString+Implementation.m
//  NoCardPay
//
//  Created by lizq on 16/5/24.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import "NSString+Implementation.h"

@implementation NSString (Implementation)

+ (NSString *)cardStringFromNormal:(NSString *)string{
    NSRange range = NSMakeRange(8, string.length - 12);
    NSString *newString = [string stringByReplacingCharactersInRange:range withString:@"***"];
    return newString;
}
+(BOOL)hasLength:(NSString*)string{
    
    if (string == nil || string == NULL) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    
    if(!string)
    {
        return NO;
    }
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"\"null\""]) {
        return NO;
    }
    return YES;
}

//根据项目对编码的字符进行重新设置(该方法对" " 不进行编码，直接替换成“＋”）
- (NSString*)urlEncodedString {
    
    NSString *resultStr = self;
    CFStringRef originalString = (__bridge CFStringRef) self;
    CFStringRef leaveUnescaped = CFSTR(" "); //不需要进行编码的字符
    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");  // 需要进行编码的字符
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped,
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    
    if(escapedStr)
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // 将空字符替换成"+"
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@"+"
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    return resultStr;
}




@end
