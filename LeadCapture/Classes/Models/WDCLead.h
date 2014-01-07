//
//  WDCLead.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>
// #import "SFRestRequest.h"

@interface WDCLead : NSObject <SFRestDelegate>
//@interface WDCLead : NSObject

// properties are the uncapitalized verions of the same properties from the service
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *status;

// class method for serializeing a list of leads from the servie
+ (NSArray *)initWithArray:(NSArray *)rawLeads;

// class method for serializing a single lead from the service
+ (WDCLead *)initWithDictionary:(NSDictionary *)rawLead;

// convenience method for retrieving the title and company
// concatenated, ex. "CEO, Widgets Inc"
- (NSString *)titleAndCompany;

// persist the instance to the service
- (void)save;

@end
