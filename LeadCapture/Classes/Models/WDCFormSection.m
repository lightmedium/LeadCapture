//
//  WDCFormSection.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCFormSection.h"
#import "WDCFormField.h"

@implementation WDCFormSection

// traverse fields in the section, initializing WDCFormField models
+ (id)initWithSectionDefinition:(NSDictionary *)sectionDef;
{
    WDCFormSection *section = [[WDCFormSection alloc] init];
    
    NSArray *rawFields = [sectionDef valueForKey:@"fields"];
    
    NSMutableArray *fields = [NSMutableArray array];
    
    [rawFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WDCFormField *f = [WDCFormField initWithFieldDefinition:(NSDictionary*)obj];
        [fields addObject:f];
    }];
    [section setFields:fields];
    return section;
}

@end
