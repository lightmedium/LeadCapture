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

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *status;

+ (NSArray *)initWithArray:(NSArray *)rawLeads;
+ (WDCLead *)initWithDictionary:(NSDictionary *)rawLead;

- (NSString *)titleAndCompany;

- (void)save;

@end
