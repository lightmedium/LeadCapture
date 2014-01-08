//
//  WDCPersistentModelProtocol.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/7/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WDCPersistentModelProtocol <NSObject>
@required

// models need to be able to be saved
- (void)save:(void(^)(BOOL success, id response, NSError *error))callback;

// We need to know if the record is editable
- (BOOL)isMutable;

// We need to know if the record is new
- (BOOL)isNew;

// Models need to serialize themselves into a dictionary for saving
// TODO: this can probably be abstracted out because the process of
//       comparing the object prototype to the model is not (yet) model-specific.
- (NSDictionary *)serializedForSave;

// We need to be able to tell the model to skip validation in certain
// UX scenarios, like canceling from a form
- (void)setSkipValidation:(BOOL)val;

// Since KVC is an informal protocol, let's make it formal for our models.
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;
- (BOOL)validateValue:(id *)ioValue forKey:(NSString *)key error:(NSError **)outError;

@end
