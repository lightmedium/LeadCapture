//
//  WDCLead.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestRequest.h"
#import "WDCPersistentModelProtocol.h"

@interface WDCLead : NSObject <WDCPersistentModelProtocol>

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

// a convenience class method for listing all of the WDCLeads from the service
// wraps the instance method on a shared instance of WDCLead
+ (void)listLeads:(void(^)(BOOL success, id response, NSError *error))callback;

// persist the instance to the service
// this method is a wrapper for the DAO
- (void)save:(void(^)(BOOL success, id response, NSError *error))callback;

// convenience method for retrieving the title and company
// concatenated, ex. "CEO, Widgets Inc"
- (NSString *)titleAndCompany;

// list all of the WDCLeads from the service
- (void)listLeads:(void(^)(BOOL success, id response, NSError *error))callback;

// public interface that allows the service layer to get
// the model formatted for persistence
- (NSDictionary *)serializedForSave;

// let the abstract code know whether or not
// the instance is new or existing.
- (BOOL)isNew;

@end
