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

// crawl over the form definition dictionary and serialize data into
// a WDCFormDataProvider and its models
+ (WDCFormDataProvider *)initWithFormDefinition:(NSDictionary *)formDef;
{
    WDCFormDataProvider *dp = [[WDCFormDataProvider alloc] init];
    
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

- (BOOL)validateRequiredCells;
{
    BOOL __block isValid = YES;
    
    // traverse the sections and fields. as soon as we find one that is invalid, stop and return NO.
    [[self sections] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WDCFormSection *section = (WDCFormSection *)obj;
        
        [[section fields] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            WDCFormField *field = (WDCFormField *)obj;
            
            // we tell the fields to validate.
            // fields tell their cells to validate.
            // the cell is the junction of configuration, domain model, and current state.
            // ordinarily this would be a violation of MVC, but I don't see it that
            // way since there is no view-specific logic present that wouldn't still
            // be present should the validation logic be orchestrated by a controller.
            if (![field validate])
            {
                isValid = NO;
                *stop = YES;
            }
        }];
        if (!isValid) *stop = YES;
    }];
    return isValid;
}

@end
