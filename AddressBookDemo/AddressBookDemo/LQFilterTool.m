
//
//  LQFiterTool.m
//  AddressBookDemo
//
//  Created by lizq on 16/7/27.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQFilterTool.h"

@implementation LQFilterTool


+ (NSMutableArray *)filteredArray:(NSArray *)sourceArray usingPredicate:(NSString *)predicate collationString:(NSString *)keyName {

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (id model in sourceArray) {
        NSString *value = [self transformChineseChar:[model valueForKey:keyName]];
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *pattern = [self matchStringFromPredicate:predicate];

        if ([self checkString:value withPatten:pattern]) {
            [array addObject:model];
        }
    }
    return array;
}

+ (NSString *)matchStringFromPredicate:(NSString *)predicate {

    NSArray *charsArray = [self charsFromString:[self transformChineseChar:predicate]];
    NSMutableString *matchString = [NSMutableString stringWithString:@".{0,}"];
    for (NSString *charString in charsArray) {
        [matchString appendString:charString];
        [matchString appendString:@".{0,}"];
    }
    return matchString;
}

+ (NSMutableArray *)charsFromString:(NSString *)string {

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    @autoreleasepool {
        for (int i = 0; i < string.length; i++) {
            NSString *charString = [string substringWithRange:NSMakeRange(i, 1)];
            [array addObject:charString];
        }
    }
    return array.mutableCopy;
}

+ (BOOL)checkString:(NSString *)string withPatten:(NSString *)pattern {

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

+ (NSString *)transformChineseChar:(NSString *)chinese {
    //汉字转拼音
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

@end
