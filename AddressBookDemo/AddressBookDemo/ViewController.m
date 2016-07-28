//
//  ViewController.m
//  AddressBookDemo
//
//  Created by lizq on 16/7/26.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "ViewController.h"
#import "LQAddressBookDelegateManager.h"
#import "UITableView+LQTableView.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LQAddressBookDelegateManager *delegateManager;
@property (nonatomic, strong) UISearchController *searchVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [LQNotificationCenter addObserver:self selector:@selector(reloadTableView) name:RELOADTABLEVIEW object:nil];

}

#pragma mark 通知处理

- (void)reloadTableView {
    [self.tableView reloadData];
}

#pragma mark getter or setter

- (UITableView *)tableView {

    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:UITableViewStyleGrouped];
        _tableView.dataSource = self.delegateManager;
        _tableView.delegate = self.delegateManager;
        _tableView.sectionIndexColor = [UIColor colorWithWhite:0.4 alpha:1];
        _tableView.tableHeaderView = self.searchVC.searchBar;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (UISearchController *)searchVC {
    
    if (_searchVC == nil) {
        _searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchVC.searchResultsUpdater = self.delegateManager;
        _searchVC.delegate = self.delegateManager;
        _searchVC.dimsBackgroundDuringPresentation = NO;
        _searchVC.searchBar.showsBookmarkButton = YES;
        _searchVC.searchBar.delegate = self.delegateManager;
        _searchVC.searchBar.backgroundImage = [UIImage imageFromColor:[UIColor colorWithWhite:0.1 alpha:0.8]];
        [_searchVC.searchBar setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];

    }
    return _searchVC;
}

- (LQAddressBookDelegateManager *)delegateManager {
    if (_delegateManager == nil) {
        _delegateManager = [[LQAddressBookDelegateManager alloc] init];
    }
    return _delegateManager;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
