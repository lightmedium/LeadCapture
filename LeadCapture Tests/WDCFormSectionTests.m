//
//  WDCFormSectionTests.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WDCFixtureLoader.h"
#import "WDCFormSection.h"

@interface WDCFormSectionTests : XCTestCase @end

@implementation WDCFormSectionTests

// + (id)initWithSectionDefinition:(NSDictionary *)sectionDef;
- (void)testInitWithSectionDefinition_createsTheExpectedNumberOfFields
{
    // setup
    NSDictionary *sectionDefinition = [WDCFixtureLoader loadFixtureNamed:@"sectionDefinition"];
    int expectedFieldCount = 2;
    
    // execution
    WDCFormSection *section = [WDCFormSection initWithSectionDefinition:sectionDefinition];
    int actualFieldCount = [[section fields] count];
    
    // assertion
    XCTAssertEqual(expectedFieldCount, actualFieldCount, @"We didn't get all of the fields that we expected from the fixture.");
}


@end
