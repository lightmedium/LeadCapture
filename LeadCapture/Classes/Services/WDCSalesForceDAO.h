//
//  WDCSalesForceDAO.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/7/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//
//  A simple DAO for accessing Lead data from the SFRestAPI.

#import <Foundation/Foundation.h>
#import "WDCLead.h"
#import "SFRestRequest.h"

@interface WDCSalesForceDAO : NSObject <SFRestDelegate>

// requests the list of leads from the SFRestAPI.
// response will either be a WDCLead or an NSArray of WDCLeads
- (SFRestRequest *)listLeads:(void(^)(BOOL success, id response, NSError *error))callback;

// saves the lead to the SFRestAPI.
// response lead is the updated record with the new id added.
- (SFRestRequest *)saveLead:(WDCLead *)lead withCallback:(void(^)(BOOL success, id response, NSError *error))callback;

// the callback block that is executed when the service responds.
// we aren't typedefing these because it is more helpful when calling
// methods that accept these blocks to have them defined in the method sig.
@property (nonatomic, copy) void (^callback)(BOOL success, id response, NSError *error);

@end
