//
//  WDCFormDataProviderTests.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WDCFormDataProvider.h"
#import "WDCFixtureLoader.h"
#import "WDCFormSection.h"
#import "WDCFormField.h"

@interface WDCFormDataProviderTests : XCTestCase
@property (nonatomic, strong) WDCFormDataProvider *dataProvider;
@end

@implementation WDCFormDataProviderTests

- (void)setUp
{
    [super setUp];
    NSDictionary *formDefinition = [WDCFixtureLoader loadFixtureNamed:@"formDefinition"];
    [self setDataProvider:[WDCFormDataProvider initWithFormDefinition:formDefinition]];
}

- (void)tearDown
{
    [self setDataProvider:nil];
    [super tearDown];
}

// + (id)initWithFormDefinition:(NSDictionary *)formDef;
- (void)testInitWithFormDefinition_serializesSections
{
    // setup
    NSDictionary *formDefinition = [WDCFixtureLoader loadFixtureNamed:@"formDefinition"];
    int expectedSectionCount = 3;
    
    // execution
    WDCFormDataProvider *dataProvider = [WDCFormDataProvider initWithFormDefinition:formDefinition];
    int actualSectionCount = [[dataProvider sections] count];
    
    // assertion
    XCTAssertEqual(expectedSectionCount, actualSectionCount, @"We didn't get all of the sections that we expected from the fixture.");
}

// - (WDCFormSection *)sectionModelForIndexPath:(NSIndexPath *)indexPath
- (void)testSectionModelForIndexPath_loadsCorrectSectionModel
{
    // setup
    WDCFormSection *expectedSection0 = [[[self dataProvider] sections] objectAtIndex:0];
    WDCFormSection *expectedSection1 = [[[self dataProvider] sections] objectAtIndex:1];
    WDCFormSection *expectedSection2 = [[[self dataProvider] sections] objectAtIndex:2];
    
    // execution
    WDCFormSection *actualSection0 = [[self dataProvider] sectionModelForIndexPath:[NSIndexPath indexPathForRow:999 inSection:0]];
    WDCFormSection *actualSection1 = [[self dataProvider] sectionModelForIndexPath:[NSIndexPath indexPathForRow:999 inSection:1]];
    WDCFormSection *actualSection2 = [[self dataProvider] sectionModelForIndexPath:[NSIndexPath indexPathForRow:999 inSection:2]];
    
    // assertion
    XCTAssertEqualObjects(expectedSection0, actualSection0, @"The WDCFormSection instance returned by the table view was not what we have in the data provider");
    XCTAssertEqualObjects(expectedSection1, actualSection1, @"The WDCFormSection instance returned by the table view was not what we have in the data provider");
    XCTAssertEqualObjects(expectedSection2, actualSection2, @"The WDCFormSection instance returned by the table view was not what we have in the data provider");
}

// - (WDCFormField *)fieldModelForIndexPath:(NSIndexPath *)indexPath
- (void)testFieldModelForIndexPath_loadsCorrectFieldModel
{
    // setup
    WDCFormSection *section0 = [[[self dataProvider] sections] objectAtIndex:0];
    WDCFormField *expectedField0_0 = [[section0 fields] objectAtIndex:0];
    WDCFormField *expectedField0_1 = [[section0 fields] objectAtIndex:1];
    
    WDCFormSection *section1 = [[[self dataProvider] sections] objectAtIndex:1];
    WDCFormField *expectedField1_0 = [[section1 fields] objectAtIndex:0];
    WDCFormField *expectedField1_2 = [[section1 fields] objectAtIndex:2];
    
    WDCFormSection *section2 = [[[self dataProvider] sections] objectAtIndex:2];
    WDCFormField *expectedField2_0 = [[section2 fields] objectAtIndex:0];
    WDCFormField *expectedField2_3 = [[section2 fields] objectAtIndex:3];
    
    // execution
    WDCFormField *actualField0_0 = [[self dataProvider] fieldModelForIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    WDCFormField *actualField0_1 = [[self dataProvider] fieldModelForIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    WDCFormField *actualField1_0 = [[self dataProvider] fieldModelForIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    WDCFormField *actualField1_2 = [[self dataProvider] fieldModelForIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    
    WDCFormField *actualField2_0 = [[self dataProvider] fieldModelForIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    WDCFormField *actualField2_3 = [[self dataProvider] fieldModelForIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
    
    // assertion
    XCTAssertEqualObjects(expectedField0_0, actualField0_0, @"The WDCFormField instance returned by the table view was not what we have in the data provider");
    XCTAssertEqualObjects(expectedField0_1, actualField0_1, @"The WDCFormField instance returned by the table view was not what we have in the data provider");
    XCTAssertEqualObjects(expectedField1_0, actualField1_0, @"The WDCFormField instance returned by the table view was not what we have in the data provider");
    XCTAssertEqualObjects(expectedField1_2, actualField1_2, @"The WDCFormField instance returned by the table view was not what we have in the data provider");
    XCTAssertEqualObjects(expectedField2_0, actualField2_0, @"The WDCFormField instance returned by the table view was not what we have in the data provider");
    XCTAssertEqualObjects(expectedField2_3, actualField2_3, @"The WDCFormField instance returned by the table view was not what we have in the data provider");
}

@end
