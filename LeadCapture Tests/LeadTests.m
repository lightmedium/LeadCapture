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

- (void)testPresenceValidation
{
    // setup
    WDCLead *lead = [[WDCLead alloc] init];
    [lead setSkipValidation:NO];
    NSArray *propertyKeys = @[@"firstName",
                              @"lastName",
                              @"company",
                              @"title",
                              @"phone"];
    
    [propertyKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // validate against empty string
        NSError *emptyStringError = nil;
        NSString *emptyString = @"";
        BOOL emptyStringIsValid = [lead validateValue:&emptyString forKey:obj error:&emptyStringError];
        XCTAssertFalse(emptyStringIsValid, @"An empty %@ should not have been valid", obj);
        XCTAssertNotNil(emptyStringError, @"An empty %@ should have generated an error", obj);
        
        // validate against nil string
        NSError *nilStringError = nil;
        NSString *nilString = nil;
        BOOL nilStringIsValid = [lead validateValue:&nilString forKey:obj error:&nilStringError];
        XCTAssertFalse(nilStringIsValid, @"A nil %@ should not have been valid", obj);
        XCTAssertNotNil(nilStringError, @"A nil %@ should have generated an error", obj);
        
        // validate against valid string
        NSError *validStringError = nil;
        NSString *validString = @"Something valid";
        BOOL validStringIsValid = [lead validateValue:&validString forKey:obj error:&validStringError];
        XCTAssertTrue(validStringIsValid, @"A valid %@ should have been valid", obj);
        XCTAssertNil(validStringError, @"A valid %@ should have generated an error", obj);
    }];
}

- (void)testEmailValidation
{
    // setup
    WDCLead *lead = [[WDCLead alloc] init];
    [lead setSkipValidation:NO];
    NSString *obj = @"email";
    
    // sorry for the change in style, trying to get this out the door.
    // validate against empty string
    NSError *emptyStringError = nil;
    NSString *emptyString = @"";
    BOOL emptyStringIsValid = [lead validateValue:&emptyString forKey:obj error:&emptyStringError];
    XCTAssertFalse(emptyStringIsValid, @"An empty %@ should not have been valid", obj);
    XCTAssertNotNil(emptyStringError, @"An empty %@ should have generated an error", obj);
    
    // validate against nil string
    NSError *nilStringError = nil;
    NSString *nilString = nil;
    BOOL nilStringIsValid = [lead validateValue:&nilString forKey:obj error:&nilStringError];
    XCTAssertFalse(nilStringIsValid, @"A nil %@ should not have been valid", obj);
    XCTAssertNotNil(nilStringError, @"A nil %@ should have generated an error", obj);
    
    // validate against string without "@"
    NSError *atLessStringError = nil;
    NSString *atLessString = @"thereisnotAThere";
    BOOL atLessStringIsValid = [lead validateValue:&atLessString forKey:obj error:&atLessStringError];
    XCTAssertFalse(atLessStringIsValid, @"A nil %@ should not have been valid", obj);
    XCTAssertNotNil(atLessStringError, @"A nil %@ should have generated an error", obj);
    
    // validate against valid string
    NSError *validStringError = nil;
    NSString *validString = @"valid@valid.com";
    BOOL validStringIsValid = [lead validateValue:&validString forKey:obj error:&validStringError];
    XCTAssertTrue(validStringIsValid, @"A valid %@ should have been valid", obj);
    XCTAssertNil(validStringError, @"A valid %@ should have generated an error", obj);
}


@end