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

// We need to know if the record is new or not
- (BOOL)isNew;

// Models need to serialize themselves into a dictionary for saving
// TODO: this can probably be abstracted out because the process of
//       comparing the object prototype to the model is not (yet) model-specific.
- (NSDictionary *)serializedForSave;

@end
