//
//  NSString+Utilities.m
//  GoodHaggle
//
//  Created by C. Michael Close on 12/16/13.
//  Copyright (c) 2013 LightMedium, LLC. All rights reserved.
//

#import "NSMutableString+Utilities.h"

@implementation NSMutableString (Utilities)

- (NSMutableString *)capitalize;
{
    NSRange range = NSMakeRange(0, 1);
    NSString *firstLetter = [self substringWithRange:range];
    [self replaceCharactersInRange:range withString:[firstLetter capitalizedString]];
    return self;
}

- (NSMutableString *)unCapitalize;
{
    NSRange range = NSMakeRange(0, 1);
    NSString *firstLetter = [self substringWithRange:range];
    [self replaceCharactersInRange:range withString:[firstLetter lowercaseString]];
    return self;
}

- (NSMutableString *)upperCamelCase;
{
    return [[self lowerCamelCase] capitalize];
}

- (NSMutableString *)lowerCamelCase;
{
    NSMutableArray *components = [[self componentsSeparatedByString:@"_"] mutableCopy];
    __block NSMutableString *tmp = [[components objectAtIndex:0] mutableCopy];
    [components removeObjectAtIndex:0];
    [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableString *component = [obj mutableCopy];
        [tmp appendString:[component capitalize]];
    }];
    [self replaceCharactersInRange:NSMakeRange(0, [self length]) withString:tmp];
    return self;
}

- (NSMutableString *)underscoreize;
{
    NSMutableArray *components = [self componentsSeparatedByCapitals];
    __block NSMutableString *tmp = [[[components objectAtIndex:0] mutableCopy] unCapitalize];
    [components removeObjectAtIndex:0];
    [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableString *component = [obj mutableCopy];
        [tmp appendString:@"_"];
        [tmp appendString:[component unCapitalize]];
    }];
    [self replaceCharactersInRange:NSMakeRange(0, [self length]) withString:tmp];
    return self;
}

- (NSMutableArray *)componentsSeparatedByCapitals;
{
    NSCharacterSet *cs = [NSCharacterSet uppercaseLetterCharacterSet];
    NSMutableArray *results = [NSMutableArray array];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSString *previousCapitalCharacter;
    while (! [scanner isAtEnd]) {
        NSLog(@"scan location: %lu", (unsigned long)[scanner scanLocation]);
        NSString *temp = [NSMutableString string];
        if ([scanner scanUpToCharactersFromSet:cs intoString:&temp]) {
            if (previousCapitalCharacter)
            {
                temp = [previousCapitalCharacter stringByAppendingString:temp];
            }
            [results addObject:[temp copy]];
        }
        if (! [scanner isAtEnd])
        {
            previousCapitalCharacter = [self substringWithRange:NSMakeRange([scanner scanLocation], 1)];
            [scanner setScanLocation:[scanner scanLocation] + 1];
        }
    }
    return results;
}

@end
