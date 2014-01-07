//
//  WDCConfigDrivenTableViewCellTests.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "WDCFixtureLoader.h"
#import "WDCConfigDrivenTableViewCell.h"
#import "WDCLead.h"
#import "WDCFormField.h"

@interface WDCConfigDrivenTableViewCell(tests)
- (void)validateInput;
@end

@interface WDCConfigDrivenTableViewCellTests : XCTestCase

@end

@implementation WDCConfigDrivenTableViewCellTests

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

// - (void)validateInput
- (void)testValidateInput_updatesModelWithValidValue
{
    // *all values are valid, there are no validations set up.
    
    // setup
    // this is the value we expect the cell to update the model with:
    NSString *expectedFirstName = @"Mary";
    
    // load fixtures for the lead and the field definition
    NSDictionary *leadDefinition = [WDCFixtureLoader loadFixtureNamed:@"lead01"];
    XCTAssertNotNil(leadDefinition, @"Something went wrong loading our lead fixture.");
    NSDictionary *fieldDefinition = [WDCFixtureLoader loadFixtureNamed:@"fieldDefinition"];
    XCTAssertNotNil(fieldDefinition, @"Something went wrong loading our field definition fixture.");
    
    // instantiate the objects we need using the fixtures
    WDCLead *lead = [WDCLead initWithDictionary:leadDefinition];
    XCTAssertFalse([[lead firstName] isEqualToString:expectedFirstName], @"The names should not match yet. Did the fixture change? Is something hanging around in memory?");
    WDCFormField *field = [WDCFormField initWithFieldDefinition:fieldDefinition];
    
    // instantiate the cell we will be testing
    WDCConfigDrivenTableViewCell *cell = [[WDCConfigDrivenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"monkeys" model:lead fieldDefinition:field];
    
    // mock the method that must be overridden in subclasses
    id mockCell = [OCMockObject partialMockForObject:cell];
    [[[mockCell stub] andReturn:expectedFirstName] valueForBoundProperty];
    
    // execution
    // tell the cell to validate input.  Successfull validation means the model will be updated.
    [cell validateInput];
    
    // the model should now have a new firstName property - Mary
    NSString *actualFirstName = [lead firstName];
    
    // assertion
    XCTAssertTrue([actualFirstName isEqualToString:expectedFirstName], @"The cell did not persist its data to the model.");
}

- (void)testValidateInput_doesNotUpdateModelWithInvalidValue
{
    // TODO - validation
}

@end
