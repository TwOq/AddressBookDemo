//
//  UITableView+LQTableView.m
//  AddressBookDemo
//
//  Created by lizq on 16/7/28.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "UITableView+LQTableView.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation UITableView (LQTableView)

+ (void)load {

    Class class = [self class];
    SEL titleSelector = @selector(LQsectionIndexChangedToIndex:title:);
    Method titleMethod = class_getInstanceMethod(class, titleSelector);
    SEL touchSelector = @selector(LQsectionIndexTouchesEnded:);
    Method touchMethod = class_getInstanceMethod(class, touchSelector);

    unsigned int count;
    Method *mothods = class_copyMethodList(class, &count);
    for (int i = 0; i < count ;i++) {
        Method method = mothods[i];
        SEL methodSel = method_getName(method);
        const char *name = sel_getName(methodSel);
        NSString *methodString = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        if ([methodString isEqualToString:@"_sectionIndexChangedToIndex:title:"]) {
            Method originalMethod = class_getInstanceMethod(class, methodSel);
            method_exchangeImplementations(originalMethod, titleMethod);
        }
        if ([methodString isEqualToString:@"_sectionIndexTouchesEnded:"]) {
            Method originalMethod = class_getInstanceMethod(class, methodSel);
            method_exchangeImplementations(originalMethod, touchMethod);
        }
    }

}

- (void)LQsectionIndexTouchesEnded:(id)tableViewIndex {

    SEL touchSelector = @selector(LQsectionIndexTouchesEnded:);
    objc_msgSend(self, touchSelector, tableViewIndex);
    UILabel *titleLabel = [self.superview viewWithTag:100];
    [titleLabel removeFromSuperview];
}

- (void)LQsectionIndexChangedToIndex:(NSInteger)index title:(NSString *)title{

    SEL changeSelector = @selector(LQsectionIndexChangedToIndex:title:);
    objc_msgSend(self, changeSelector, index, title);
    [self showSectionTitle:title];
}

- (void)showSectionTitle:(NSString *)title {

    UILabel *titleLabel = [self.superview viewWithTag:100];
    if (titleLabel == nil) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        titleLabel.center = self.center;
        titleLabel.layer.cornerRadius = 5;
        titleLabel.layer.masksToBounds = YES;
        titleLabel.tag = 100;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:25];
        titleLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        [self.superview addSubview:titleLabel];
        [self.superview bringSubviewToFront:titleLabel];
    }
    if ([title isEqualToString:@""]) {
        [titleLabel removeFromSuperview];
        return;
    }
    titleLabel.text = title;
}


@end
