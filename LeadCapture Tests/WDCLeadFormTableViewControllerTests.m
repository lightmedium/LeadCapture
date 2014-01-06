//
//  WDCLeadFormTableViewControllerTests.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WDCLeadFormTableViewController.h"

@interface WDCLeadFormTableViewController (tests)
- (NSMutableDictionary *)loadFormDefinition;
@end


@interface WDCLeadFormTableViewControllerTests : XCTestCase

@end

@implementation WDCLeadFormTableViewControllerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testLoadFormDefinition_returnsAMutableDict
{
//    WDCLeadFormTableViewController *vc = [WDCLeadFormTableViewController initWithStyle:UITableViewStylePlain];
    WDCLeadFormTableViewController *vc = [[WDCLeadFormTableViewController alloc] init];
    NSMutableDictionary *definition = [vc loadFormDefinition];
    XCTAssertNotNil(definition, @"The form definition failed to load.");
}

@end
