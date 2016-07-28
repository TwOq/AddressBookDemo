//
//  LQAddressBookDelegateManager.h
//  AddressBookDemo
//
//  Created by lizq on 16/7/26.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQAddressBookDelegateManager : NSObject
<
UITableViewDataSource,
UITableViewDelegate,
UISearchResultsUpdating,
UISearchControllerDelegate,
UISearchBarDelegate
>

@end
