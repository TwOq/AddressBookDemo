//
//  LQAddressBookDelegateManager.m
//  AddressBookDemo
//
//  Created by lizq on 16/7/26.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQAddressBookDelegateManager.h"
#import "LQViewModel.h"
#import "LQFilterTool.h"
#import "LQAddressBookCell.h"

@interface LQAddressBookDelegateManager()

@property (nonatomic, strong) LQViewModel *viewModel;
@end

@implementation LQAddressBookDelegateManager


#pragma mark tableView datasoruce方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.viewModel.isSearching) {
        return 1;
    }
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.viewModel.isSearching) {
        return self.viewModel.searchArray.count;
    }
    NSArray *sectionArray = (NSArray *)self.viewModel.dataArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LQAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[LQAddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    LQAddressBookModel *model = nil;
    if (self.viewModel.isSearching) {
        model = self.viewModel.searchArray[indexPath.row];
    }else {
        NSArray *sectionArray = self.viewModel.dataArray[indexPath.section];
        model = sectionArray[indexPath.row];
    }

    cell.iconImage = [UIImage imageNamed:model.iconName];
    cell.name = model.name;
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.viewModel.isSearching) {
        return nil;
    }
    return self.viewModel.sectionTitlesArray;
}


#pragma mark tableView delegate方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (self.viewModel.isSearching || section == 0) {
        return 0.001;
    }
    return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.viewModel.isSearching) {
        return nil;
    }
    return  [self createHeaderViewInSection:section];
}

#pragma mark searchViewcontroller delegate 方法

- (void)willPresentSearchController:(UISearchController *)searchController {
    self.viewModel.isSearching = YES;


}
- (void)willDismissSearchController:(UISearchController *)searchController {
    self.viewModel.isSearching = NO;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSString *searchString = [searchController.searchBar text];
    //过滤数据
    self.viewModel.searchArray= [NSMutableArray arrayWithArray:[LQFilterTool filteredArray:self.viewModel.searchSource
                                                                            usingPredicate:searchString
                                                                           collationString:@"name"]];
    //刷新表格
    [LQNotificationCenter postNotificationName:RELOADTABLEVIEW object:nil];
}



#pragma mark searchBar delegate 方法

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    searchBar.showsCancelButton = YES;
    for(id view in [searchBar.subviews[0] subviews])
    {
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)view;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}


#pragma mark getter or setter

- (LQViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[LQViewModel alloc] init];
        [_viewModel getDataWithCount:30];
    }
    return _viewModel;
}

- (UIView *)createHeaderViewInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 18)];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    label.text = [NSString stringWithFormat:@"  %@",self.viewModel.sectionTitlesArray[section]];
    label.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    return label;
}

@end
