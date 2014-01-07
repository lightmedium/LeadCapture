//
//  WDCConfigDrivenTableViewControllerTests.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WDCFixtureLoader.h"
#import "WDCConfigDrivenTableViewController.h"
#import "WDCFormDataProvider.h"
#import "WDCFormSection.h"
#import "WDCFormField.h"

@interface WDCConfigDrivenTableViewController(tests)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface WDCConfigDrivenTableViewControllerTests : XCTestCase
@property (nonatomic, strong) WDCFormDataProvider *dataProvider;
@property (nonatomic, strong) WDCConfigDrivenTableViewController *controller;
@end

@implementation WDCConfigDrivenTableViewControllerTests

- (void)setUp
{
    [super setUp];
    NSDictionary *formDefinition = [WDCFixtureLoader loadFixtureNamed:@"formDefinition"];
    [self setDataProvider:[WDCFormDataProvider initWithFormDefinition:formDefinition]];
    [self setController:[[WDCConfigDrivenTableViewController alloc] init]];
    [[self controller] setDataProvider:[self dataProvider]];
}

- (void)tearDown
{
    [self setDataProvider:nil];
    [self setController:nil];
    [super tearDown];
}

- (void)testNumberOfSectionsInTableView_returnsNumberOfSectionsInDataProvider
{
    // setup
    int expectedNumberOfSections = 3;
    
    // execution
    int actualNumberOfSections = [[self controller] numberOfSectionsInTableView:[[self controller] tableView]];
    
    // assertion
    XCTAssertEqual(actualNumberOfSections, expectedNumberOfSections, @"The view controller doesn't know how many sections it has in its data provider.");
}

- (void)testNumberOfRowsInSection_returnsNumberOfFieldsInSectionInDataProvider
{
    // setup
    int expectedNumberOfRowIn1 = 2;
    int expectedNumberOfRowIn2 = 3;
    int expectedNumberOfRowIn3 = 4;
    
    // execution
    int actualNumberOfRowIn1 = [[self controller] tableView:[[self controller] tableView] numberOfRowsInSection:0];
    int actualNumberOfRowIn2 = [[self controller] tableView:[[self controller] tableView] numberOfRowsInSection:1];
    int actualNumberOfRowIn3 = [[self controller] tableView:[[self controller] tableView] numberOfRowsInSection:2];
    
    // assertion
    XCTAssertEqual(expectedNumberOfRowIn1, actualNumberOfRowIn1, @"The view controller doesn't know how many rows are in section 0 of the data provider.");
    XCTAssertEqual(expectedNumberOfRowIn2, actualNumberOfRowIn2, @"The view controller doesn't know how many rows are in section 1 of the data provider.");
    XCTAssertEqual(expectedNumberOfRowIn3, actualNumberOfRowIn3, @"The view controller doesn't know how many rows are in section 3 of the data provider.");
}

- (void)testCellForRowAtIndexPath_instantiatesCorrectCellType
{
    // setup
    WDCFormSection *section = [[[self dataProvider] sections] objectAtIndex:1];
    WDCFormField *field = [[section fields] objectAtIndex:1];
    
    // execution
    id cell = [[self controller] tableView:[[self controller] tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    // assertion
    
}

@end
