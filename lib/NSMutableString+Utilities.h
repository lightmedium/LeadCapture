//
//  NSString+Utilities.h
//  GoodHaggle
//
//  Created by C. Michael Close on 12/16/13.
//  Copyright (c) 2013 LightMedium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (Utilities)
- (NSMutableString *)capitalize;
- (NSMutableString *)unCapitalize;
- (NSMutableString *)upperCamelCase;
- (NSMutableString *)lowerCamelCase;
- (NSMutableString *)underscoreize;
- (NSMutableArray *)componentsSeparatedByCapitals;
@end
