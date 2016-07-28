//
//  LQFiterTool.h
//  AddressBookDemo
//
//  Created by lizq on 16/7/27.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFilterTool : NSObject
/**
 *  对模型数组中某个属性，按照某特正则条件进行过滤
 *
 *  @param sourceArray 模型数组
 *  @param predicate   正则条件表达式
 *  @param keyName     模型属性
 *
 *  @return 满足条件的模型数组
 */
+ (NSMutableArray *)filteredArray:(NSArray *)sourceArray usingPredicate:(NSString *)predicate collationString:(NSString *)keyName;


@end
