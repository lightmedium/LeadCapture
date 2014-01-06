//
//  NSMutableString_UtilitiesTests.m
//  GoodHaggle
//
//  Created by C. Michael Close on 12/16/13.
//  Copyright (c) 2013 LightMedium, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSMutableString+Utilities.h"

@interface NSMutableString_UtilitiesTests : XCTestCase

@end

@implementation NSMutableString_UtilitiesTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
//    [NSThread sleepForTimeInterval:.1];
    [super tearDown];
}

- (void)testCapitalize_capitalizesProperly
{
    // setup
    NSMutableString *expected = [@"CapitalizedString" mutableCopy];
    NSMutableString *actual = [@"capitalizedString" mutableCopy];
    
    // execution
    [actual capitalize];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been capitalied like this: %@", actual, expected);
}

- (void)testCapitalize_capitalizesOneLetterWordProperly
{
    // setup
    NSMutableString *expected = [@"I" mutableCopy];
    NSMutableString *actual = [@"i" mutableCopy];
    
    // execution
    [actual capitalize];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been capitalied like this: %@", actual, expected);
}

- (void)testCapitalize_capitalizesTwoLetterWordProperly
{
    // setup
    NSMutableString *expected = [@"Is" mutableCopy];
    NSMutableString *actual = [@"is" mutableCopy];
    
    // execution
    [actual capitalize];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been capitalied like this: %@", actual, expected);
}

- (void)testUnCapitalize_unCapitalizesProperly
{
    // setup
    NSMutableString *expected = [@"capitalizedString" mutableCopy];
    NSMutableString *actual = [@"CapitalizedString" mutableCopy];
    
    // execution
    [actual unCapitalize];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been capitalied like this: %@", actual, expected);
}

- (void)testUnCapitalize_unCapitalizesTwoLetterWordProperly
{
    // setup
    NSMutableString *expected = [@"is" mutableCopy];
    NSMutableString *actual = [@"Is" mutableCopy];
    
    // execution
    [actual unCapitalize];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been capitalied like this: %@", actual, expected);
}

- (void)testUnCapitalize_unCapitalizesOneLetterWordProperly
{
    // setup
    NSMutableString *expected = [@"i" mutableCopy];
    NSMutableString *actual = [@"I" mutableCopy];
    
    // execution
    [actual unCapitalize];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been capitalied like this: %@", actual, expected);
}

- (void)testLowerCamelCase_camelizesWithLowerCaseFirstCharacter
{
    // setup
    NSMutableString *expected = [@"thisIsALowerCamelCasedString" mutableCopy];
    NSMutableString *actual = [@"this_is_a_lower_camel_cased_string" mutableCopy];
    
    // execution
    [actual lowerCamelCase];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been camelized like this: %@", actual, expected);
}

- (void)testUpperCamelCase_camelizesWithUpperCaseFirstCharacter
{
    // setup
    NSMutableString *expected = [@"ThisIsAnUpperCamelCasedString" mutableCopy];
    NSMutableString *actual = [@"this_is_an_upper_camel_cased_string" mutableCopy];
    
    // execution
    [actual upperCamelCase];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been camelized like this: %@", actual, expected);
}

- (void)testComponentsSeparatedByCapitals_separatesStringIntoArrayOfItsCapitalizedComponents
{
    // setup
    NSMutableString *original = [@"thisCapitalizedStringHasSixComponents" mutableCopy];
    NSUInteger expectedCount = 6;
    
    // execution
    NSMutableArray *result = [original componentsSeparatedByCapitals];
    NSUInteger actualCount = [result count];
    
    // assertion
    XCTAssertEqual(expectedCount, actualCount, @"The expected and actual counts were not the same.");
}

- (void)testUnderscoreize_underscoreizes
{
    // setup
    NSMutableString *expected = [@"this_is_an_upper_camel_cased_string" mutableCopy];
    NSMutableString *actual = [@"ThisIsAnUpperCamelCasedString" mutableCopy];
    
    // execution
    [actual underscoreize];
    
    // assertion
    XCTAssertEqualObjects(expected, actual, @"The string %@ should have been camelized like this: %@", actual, expected);
}

@end
