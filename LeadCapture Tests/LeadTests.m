//
//  LeadTests.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "OCMock.h"
#import "WDCLead.h"
#import "WDCFixtureLoader.h"

@interface LeadTests : XCTestCase @end

@implementation LeadTests

// + (NSArray *)initWithArray:(NSArray *)rawLeads;
- (void)testInitWithArray_returnsExpectedArray
{
    // setup
    NSDictionary *fixture = [WDCFixtureLoader loadFixtureNamed:@"leadsArray"];
    NSArray *leadsArray = [fixture objectForKey:@"leads"];
    
    // execution
    NSArray *leads = [WDCLead initWithArray:leadsArray];
    
    // assertion
    XCTAssertNotNil(leadsArray, @"We should have loaded an array called \"leads\" from the loaded fixture");
    XCTAssertTrue(([leadsArray count] == 3), @"We should have had 3 leads in the leads array");
    [leads enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *rawLead = [leadsArray objectAtIndex:idx];
        NSString *rawLeadFirstName = [rawLead objectForKey:@"FirstName"];
        WDCLead *lead = (WDCLead *)obj;
        XCTAssertTrue([rawLeadFirstName isEqualToString:[lead firstName]], @"The leads do not have the same first name. dict::WDCLead %@::%@", rawLeadFirstName, [lead firstName]);
    }];
}

// + (WDCLead *)initWithDictionary:(NSDictionary *)rawLead;
- (void)testInitWithDictionary_returnsExpectedWDCLeadInstance
{
    // setup
    NSDictionary *fixture = [WDCFixtureLoader loadFixtureNamed:@"lead01"];
    NSString *expectedFName = [fixture objectForKey:@"FirstName"];
    NSString *expectedLName = [fixture objectForKey:@"LastName"];
    NSString *expectedTitle = [fixture objectForKey:@"Title"];
    NSString *expectedCompany = [fixture objectForKey:@"Company"];
    NSString *expectedPhone = [fixture objectForKey:@"Phone"];
    NSString *expectedEmail = [fixture objectForKey:@"Email"];
    
    // execution
    WDCLead *lead = [WDCLead initWithDictionary:fixture];
    
    // assertion
    XCTAssertNotNil(fixture, @"We should have fixture to work with");
    XCTAssertNotNil(lead, @"We should have received a lead from WDCLead initWithDictionary:");
    
    NSString *actualFName = [lead firstName];
    NSString *actualLName = [lead lastName];
    NSString *actualTitle = [lead title];
    NSString *actualCompany = [lead company];
    NSString *actualPhone = [lead phone];
    NSString *actualEmail = [lead email];
    XCTAssertTrue([actualFName isEqualToString:expectedFName], @"The First Names did not match between the fixture and the WDCLead instance");
    XCTAssertTrue([actualLName isEqualToString:expectedLName], @"The Last Names did not match between the fixture and the WDCLead instance");
    XCTAssertTrue([actualTitle isEqualToString:expectedTitle], @"The Title did not match between the fixture and the WDCLead instance");
    XCTAssertTrue([actualCompany isEqualToString:expectedCompany], @"The Company did not match between the fixture and the WDCLead instance");
    XCTAssertTrue([actualPhone isEqualToString:expectedPhone], @"The Phone did not match between the fixture and the WDCLead instance");
    XCTAssertTrue([actualEmail isEqualToString:expectedEmail], @"The Email did not match between the fixture and the WDCLead instance");
    
}

// - (NSString *)titleAndCompany;
- (void)testTitleAndCompany_concatenatesTitleAndCompany
{
    // setup
    NSDictionary *fixture = [WDCFixtureLoader loadFixtureNamed:@"lead01"];
    WDCLead *lead = [WDCLead initWithDictionary:fixture];
    NSString *expectedTitleAndCompany = @"El Presidente, Smith Brothers Hardware";
    
    // execution
    NSString *actualTitleAndCompany = [lead titleAndCompany];
    
    // assertion
    XCTAssertTrue([actualTitleAndCompany isEqualToString:expectedTitleAndCompany], @"The concatenation of title and company didn't work the way we expected it to.");
}


@end