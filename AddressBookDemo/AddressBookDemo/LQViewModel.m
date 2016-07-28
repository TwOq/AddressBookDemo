//
//  LQViewModel.m
//  AddressBookDemo
//
//  Created by lizq on 16/7/26.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQViewModel.h"

@implementation LQViewModel

- (void)getDataWithCount:(NSInteger)count {


    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"楚",@"卫",@"蒋",@"沈",@"韩",@"杨",@"郭"];
    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯",@"纯"];
    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山",@"纯"];

    for (int i = 0; i < count; i++) {
        NSString *name = xings[arc4random_uniform((int)xings.count)];
        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
        name = [name stringByAppendingString:ming];
        if (arc4random_uniform(10) > 3) {
            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
            name = [name stringByAppendingString:ming];
        }
        LQAddressBookModel *model = [LQAddressBookModel new];
        model.name = name;
        int number = arc4random()%24;
        model.iconName = [NSString stringWithFormat:@"%d.jpg",number];
        [self.dataArray addObject:model];
    }
    self.searchSource = self.dataArray.mutableCopy;
    [self setUpTableSection];
}

- (void)setUpTableSection {

    //初始化本地索引工具
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    //初始化一个数组newSectionsArray用来存放最终的数据: @[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        //初始化27个空数组加入newSectionsArray
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }

    for (LQAddressBookModel *model in self.dataArray) {
        //根据名字首字母，查找在27个字母中的索引
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(name)];
        [newSectionArray[sectionIndex] addObject:model];
    }

    for (NSUInteger index=0; index<numberOfSections; index++) {
        //给每个分组深度排序
        NSMutableArray *personsForSection = newSectionArray[index];
//        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
//        newSectionArray[index] = sortedPersonsForSection;

        [personsForSection sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            LQAddressBookModel *m1 = (LQAddressBookModel*) obj1;
            LQAddressBookModel *m2 = (LQAddressBookModel*) obj2;
            return [m1.name localizedCompare:m2.name];
        }];
    }

    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitlesArray = [NSMutableArray new];

    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            //记录为空的数组
            [temp addObject:arr];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    //删除为空的数组
    [newSectionArray removeObjectsInArray:temp];

    NSMutableArray *operrationModels = [NSMutableArray new];
    NSArray *dicts = @[@{@"name" : @"新的朋友", @"imageName" : @"plugins_FriendNotify"},
                       @{@"name" : @"群聊", @"imageName" : @"add_friend_icon_addgroup"},
                       @{@"name" : @"标签", @"imageName" : @"Contact_icon_ContactTag"},
                       @{@"name" : @"公众号", @"imageName" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts) {
        LQAddressBookModel *model = [LQAddressBookModel new];
        model.name = dict[@"name"];
        model.iconName = dict[@"imageName"];
        [operrationModels addObject:model];
    }
    [newSectionArray insertObject:operrationModels atIndex:0];
    [self.sectionTitlesArray insertObject:@"" atIndex:0];
    [self.sectionTitlesArray addObject:@""];
    self.dataArray = newSectionArray;
}



#pragma mark  getter or setter

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (void)setSearchSource:(NSMutableArray *)searchSource {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [searchSource sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            LQAddressBookModel *m1 = (LQAddressBookModel*) obj1;
            LQAddressBookModel *m2 = (LQAddressBookModel*) obj2;
            return [m1.name localizedCompare:m2.name];
        }];
        _searchSource = searchSource.copy;
    });
}

@end
