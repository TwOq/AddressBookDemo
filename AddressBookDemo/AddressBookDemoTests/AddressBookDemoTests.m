//
//  AddressBookDemoTests.m
//  AddressBookDemoTests
//
//  Created by lizq on 16/7/26.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LQFilterTool.h"
@interface AddressBookDemoTests : XCTestCase


@end

@implementation AddressBookDemoTests

- (void)setUp {
    [super setUp];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {

    BOOL isOK = [LQFilterTool checkString:@"WEICHUNBING" withPatten:@".{0,}C.{0,}"];
    NSLog(@"%d", isOK);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
