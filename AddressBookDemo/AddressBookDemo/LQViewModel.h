//
//  LQViewModel.h
//  AddressBookDemo
//
//  Created by lizq on 16/7/26.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQAddressBookModel.h"

@interface LQViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) NSMutableArray *searchSource;
@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;
@property (nonatomic, assign) BOOL isSearching;

- (void)getDataWithCount:(NSInteger)count;

@end
