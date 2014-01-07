//
//  WDCFormFieldTests.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WDCFixtureLoader.h"
#import "WDCFormField.h"
#import "WDCLead.h"
#import "WDCConfigDrivenTableViewCell.h"

@interface WDCFormFieldTests : XCTestCase @end

@implementation WDCFormFieldTests

// + (id)initWithFieldDefinition:(NSDictionary*)dict;
- (void)testInitWithFieldDefinition_initsFromFixture
{
    // setup
    NSDictionary *fieldDefinition = [WDCFixtureLoader loadFixtureNamed:@"fieldDefinition"];
    NSString *expectedLabel = @"First Name:";
    NSString *expectedType = @"textInput";
    NSString *expectedBoundProperty = @"firstName";
    NSNumber *expectedRowHeight = @44;
    
    // execution
    WDCFormField *field = [WDCFormField initWithFieldDefinition:fieldDefinition];
    
    // assertion
    XCTAssertNotNil(fieldDefinition, @"We should have gotten a field definition from our fixture.");
    XCTAssertNotNil(field, @"We should have gotten a WDCFormField instance.");
    
    NSString *actualLabel = [field label];
    NSString *actualType = [field type];
    NSString *actualBoundProperty = [field boundProperty];
    NSNumber *actualRowHeight = [field rowHeight];
    XCTAssertTrue([actualLabel isEqualToString:expectedLabel], @"The label did not match between our fixture and our WDCFormField instance.");
    XCTAssertTrue([actualType isEqualToString:expectedType], @"The type did not match between our fixture and our WDCFormField instance.");
    XCTAssertTrue([actualBoundProperty isEqualToString:expectedBoundProperty], @"The boundProperty did not match between our fixture and our WDCFormField instance.");
    XCTAssertEqualObjects(expectedRowHeight, actualRowHeight, @"The rowHeight did not match between our fixture and our WDCFormField instance.");
}

// - (UITableViewCell *)tableViewCell;
- (void)testTableViewCell_returnsExpectedNewAndCachedTableViewCells
{
    // setup
    NSDictionary *fieldDefinition = [WDCFixtureLoader loadFixtureNamed:@"fieldDefinition"];
    NSDictionary *leadDefinition = [WDCFixtureLoader loadFixtureNamed:@"lead01"];
    WDCFormField *field = [WDCFormField initWithFieldDefinition:fieldDefinition];
    WDCLead *lead = [WDCLead initWithDictionary:leadDefinition];
    [field setModel:lead];
    Class expectedClass = NSClassFromString(@"WDCTextInputCell");
    
    // execution
    WDCConfigDrivenTableViewCell *cell1 = [field tableViewCell];
    WDCConfigDrivenTableViewCell *cell2 = [field tableViewCell];
    
    // assertion
    XCTAssertNotNil(cell1, @"The WDCFormField failed to instantiate a UITableViewCell");
    XCTAssertNotNil(cell1, @"The WDCFormField failed to return a cached UITableViewCell");
    XCTAssertEqual(cell1, cell2, @"The WDCFormField failed to return the cached cell. We got a new instance");
    // this test will break if the project no longer includes the WDCInputFieldCell class.
    XCTAssertTrue([cell1 isKindOfClass:expectedClass], @"The WDCFormField didn't return the correct type of tableview cell.");
}

@end
