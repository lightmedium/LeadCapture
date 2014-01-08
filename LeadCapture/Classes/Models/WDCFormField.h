//
//  WDCFormField.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDCPersistentModelProtocol.h"
@class WDCConfigDrivenTableViewCell;

@interface WDCFormField : NSObject

// fields generally always have a label
@property (nonatomic, strong) NSString *label;

// we use the type to build the classname of the cell
// that will render this field.
@property (nonatomic, strong) NSString *type;

// the bound property is the property on the model that this
// field is displaying/providing the ability to edit.
@property (nonatomic, strong) NSString *boundProperty;

// let the config define the default row height for the cell
@property (nonatomic) NSNumber *rowHeight;

// the form field is a convenient place to provide access to the domain model
@property (nonatomic, strong) id<WDCPersistentModelProtocol> model;

// we cache the tableViewCell here.  This is not a good idea for dynamic lists,
// but since we're rendering a form with a finite number of fields, it's OK. We
// would need to revisit this and dequeuReusableCell if we need to present long forms,
// but we would also need to start using transient copies of the model for persisting
// data as the form is edited, so we don't lose data as cells scroll off the screen.
@property (nonatomic, strong) WDCConfigDrivenTableViewCell *tableViewCell;

+ (WDCFormField *)initWithFieldDefinition:(NSDictionary*)dict;

// Run the validateInput method on the field's cell
- (BOOL)validate;

@end
