//
//  WDCLead.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCLead.h"
#import "NSMutableString+Utilities.h"

@implementation WDCLead

+ (NSArray *)initWithArray:(NSArray *)rawLeads;
{
    NSMutableArray *leads = [NSMutableArray array];
    [rawLeads enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WDCLead *lead = [WDCLead initWithDictionary:(NSDictionary *)obj];
        [leads addObject:lead];
    }];
    return leads;
}

+ (WDCLead *)initWithDictionary:(NSDictionary *)rawLead;
{
    // for now, the properties on our Lead model can mirror the properties we receive from the
    // service.  As long as this is true, we won't have to touch this code.
    
    // instantiate the Lead instance that we will hydrate with the dictionary
    WDCLead *lead = [[WDCLead alloc] init];
    
    // iterate over the properties in the dictionary and apply them to the lead model
    // if we can.
    [rawLead enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // we want to filter out NSNulls and leave their associated properties nil
        // in order to maintain peace and happiness down stream.
        if (obj == (id)[NSNull null]) return;
        
        // if we aren't dealing with a string key, we can't handle it.
        if (! [key isKindOfClass:[NSString class]]) return;
        
        // turn the key into a setter that we'll check against the model object.
        NSMutableString *setterStr = [@"set" mutableCopy];
        NSMutableString *mutableKey = [key mutableCopy];
        [setterStr appendFormat:@"%@:", [mutableKey capitalize]];
        SEL setter = NSSelectorFromString(setterStr);
        
        // finally, if the model responds to the setter, set it.
        if ([lead respondsToSelector:setter])
        {
            // we know that it's safe to suppress this memory leak warning because we are not
            // returning anything with memory implications that arc needs to worry about.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [lead performSelector:setter withObject:obj];
#pragma clang diagnostic pop
        }
    }];
    
    return lead;
}

- (NSString *)titleAndCompany;
{
    NSMutableString *title = [[self title] mutableCopy];
    [title appendFormat:@", %@", [self company]];
    return title;
}

@end
