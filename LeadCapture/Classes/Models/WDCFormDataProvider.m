//
//  WDCFormDataProvider.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCFormDataProvider.h"
#import "WDCFormSection.h"
#import "WDCFormField.h"

@implementation WDCFormDataProvider

+ (id)initWithFormDefinition:(NSDictionary *)formDef;
{
    WDCFormDataProvider *dp = [[WDCFormDataProvider alloc] init];
    [dp setCells:[NSMutableDictionary dictionary]];
    
    NSArray *rawSections = [formDef valueForKey:@"sections"];
    
    NSMutableArray *sections = [NSMutableArray array];
    
    [rawSections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WDCFormSection *s = [WDCFormSection initWithSectionDefinition:(NSDictionary*)obj];
        [sections addObject:s];
    }];
    [dp setSections:sections];
    return dp;
}

#pragma mark - Form Data Access Helpers
- (WDCFormSection *)sectionModelForIndexPath:(NSIndexPath *)indexPath
{
    return [[self sections] objectAtIndex:indexPath.section];
}

- (WDCFormField *)fieldModelForIndexPath:(NSIndexPath *)indexPath
{
    WDCFormSection *section = [self sectionModelForIndexPath:indexPath];
    return [[section fields] objectAtIndex:indexPath.row];
}

@end
