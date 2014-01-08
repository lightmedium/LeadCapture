//
//  WDCSalesForceDAO.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/7/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCSalesForceDAO.h"
#import "SFRestAPI.h"
#import "SFRestRequest.h"

int const kTimeoutErrorCode = 999;
int const kCancellationErrorCode = 998;
int const kRequestInFlightErrorCode = 997;

@implementation WDCSalesForceDAO

// requests the list of leads from the SFRestAPI.
// response will either be a WDCLead or an NSArray of WDCLeads
- (SFRestRequest *)listLeads:(void(^)(BOOL success, id response, NSError *error))callback;
{
    // we can only handle one request at a time with this code.
    // this isn't a problem now becuase the only requests we make are blocking.
    // TODO: Use a block-enabled interface of SFRestAPI if it exists,
    //       otherwise wrangle multiple requests.
    if ([self requestInFlight:callback]) return nil;
    
    // hold on to the callback and execute it when the request is finished
    [self setCallback:callback];
    
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Id, Name, FirstName, LastName, Company, Title, Email, Phone FROM Lead WHERE Status = 'Open - Not Contacted'"];
    [[SFRestAPI sharedInstance] send:request delegate:self];
    return request;
}

// saves the lead to the SFRestAPI.
// response lead is the updated record with the new id added.
- (SFRestRequest *)saveLead:(WDCLead *)lead withCallback:(void(^)(BOOL success, id response, NSError *error))callback;
{
    if ([self requestInFlight:callback]) return nil;
    
    [self setCallback:callback];
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForCreateWithObjectType:@"Lead" fields:[lead serializedForSave]];
    [[SFRestAPI sharedInstance] send:request delegate:self];
    return request;
}

- (BOOL)requestInFlight:(void(^)(BOOL success, id response, NSError *error))callback;
{
    // we return an error if there is a request in flight
    if ([self callback])
    {
        NSMutableDictionary *errorInfo = [NSMutableDictionary dictionary];
        [errorInfo setValue:@"There is already a request in flight." forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"WDCNetworkError" code:kRequestInFlightErrorCode userInfo:errorInfo];
        callback(NO,nil,error);
        return YES;
    }
    return NO;
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse
{
    // SUCCESS!
    [self callback](YES,jsonResponse,nil);
    [self setCallback:nil];
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error
{
    // Failed with a service error, hand that error off to the client
    [self callback](NO,nil,error);
    [self setCallback:nil];
}

- (void)requestDidCancelLoad:(SFRestRequest *)request
{
    // no error provided for cancellation.
    // create one and let the client decide what to do with it.
    NSMutableDictionary *errorInfo = [NSMutableDictionary dictionary];
    [errorInfo setValue:@"Request was cancelled." forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"WDCNetworkError" code:kCancellationErrorCode userInfo:errorInfo];
    [self callback](NO,nil,error);
    [self setCallback:nil];
}

- (void)requestDidTimeout:(SFRestRequest *)request
{
    // no error provided for timeout.
    // create one and let the client decide what to do with it.
    NSMutableDictionary *errorInfo = [NSMutableDictionary dictionary];
    [errorInfo setValue:@"Request timed out." forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"WDCNetworkError" code:kTimeoutErrorCode userInfo:errorInfo];
    [self callback](NO,nil,error);
    [self setCallback:nil];
}

@end
