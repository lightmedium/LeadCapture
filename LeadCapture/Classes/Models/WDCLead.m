//
//  WDCLead.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCLead.h"
#import "WDCSalesForceDAO.h"
#import "NSMutableString+Utilities.h"

@implementation WDCLead

static WDCSalesForceDAO *dao;
static WDCLead *sharedInstance;
static NSDictionary *prototypeObject;

// create our static managed instance
+ (void)initialize
{
    dao = [[WDCSalesForceDAO alloc] init];
    sharedInstance = [[WDCLead alloc] init];
}

// class method for serializeing a list of leads from the servie
+ (NSArray *)initWithArray:(NSArray *)rawLeads;
{
    NSMutableArray *leads = [NSMutableArray array];
    [rawLeads enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WDCLead *lead = [WDCLead initWithDictionary:(NSDictionary *)obj];
        [leads addObject:lead];
    }];
    return leads;
}

// class method for serializing a single lead from the service
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
    
    // finally, save the keys of the rawLead to rehydrate the object for save
    prototypeObject = rawLead;
    
    return lead;
}

// a convenience class method for listing all of the WDCLeads from the service
// wraps the instance method on a shared instance of WDCLead
+ (void)listLeads:(void(^)(BOOL success, id response, NSError *error))callback;
{
    [sharedInstance listLeads:callback];
}

// convenience method for retrieving the title and company
// concatenated, ex. "CEO, Widgets Inc"
- (NSString *)titleAndCompany;
{
    NSMutableString *title = [[self title] mutableCopy];
    [title appendFormat:@", %@", [self company]];
    return title;
}

// persist the instance to the service
- (void)save:(void(^)(BOOL success, id response, NSError *error))callback;
{
    // set the status
    [self setStatus:@"Open - Not Contacted"];
    
    // call save on the DAO
    [dao saveLead:self withCallback:callback];
}

// list all of the WDCLeads from the service
- (void)listLeads:(void(^)(BOOL success, id response, NSError *error))callback;
{
    [dao listLeads:^(BOOL success, id response, NSError *error) {
//        NSLog(@"dao: %@", dao);
        callback(success, response, error);
    }];
}


// hydrate a dictionary to send to the service, containing the instances property values.
- (NSDictionary *)serializedForSave;
{
    NSMutableDictionary *fieldsForSave = [NSMutableDictionary dictionary];
    
    [prototypeObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSMutableString *mutableKey = [key mutableCopy];
        NSString *selectorString = [mutableKey unCapitalize];
        SEL getter = NSSelectorFromString(selectorString);
        if ([self respondsToSelector:getter])
        {
            id value = [self performSelector:getter];
            if (value)
            {
                [fieldsForSave setObject:value forKey:key];
            }
        }
    }];
    return fieldsForSave;
}

- (BOOL)isNew;
{
    BOOL retVal = ([self id] == nil) ? YES : NO;
    return retVal;
}

@end
