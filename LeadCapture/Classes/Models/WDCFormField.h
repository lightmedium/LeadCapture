//
//  WDCFormField.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCFormField : NSObject

// fields generally always have a label
@property (nonatomic, strong) NSString *label;

// we use the type to build the classname of the cell
// that will render this field.
@property (nonatomic, strong) NSString *type;

// the bound property is the property on the model that this
// field is displaying/providing the ability to edit.
@property (nonatomic, strong) NSString *boundProperty;

// for cells that have actions, like the submit button, this
// is the action that will be performed. It will be transformed
// into a selector at runtime.
@property (nonatomic, strong) NSString *action;


// let the config define the default row height for the cell
@property (nonatomic) NSNumber *rowHeight;

+ (id)initWithFieldDefinition:(NSDictionary*)dict;

@end
