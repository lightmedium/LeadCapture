//
//  WDCConfigDrivenTableViewCell.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDCPersistentModelProtocol.h"
@class WDCFormField;

@interface WDCConfigDrivenTableViewCell : UITableViewCell

// each cell is given a domain model and a field configuration.
// this is the domain model.
@property (nonatomic, strong) id<WDCPersistentModelProtocol> model;

// this is the field configuration model.
@property (nonatomic, strong) WDCFormField *fieldDefinition;

// designated initializer. Most cells end up needing to be
// subclassed, encapsulated, or else put up with a lot of noise in your
// tableView:cellForRowAtIndexPath: method. Personally, I prefer
// encapsulating that logic in the cell when it is abstract.
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(id<WDCPersistentModelProtocol>)model fieldDefinition:(WDCFormField *)fieldDef;


// This method must be implemented in the subclass.  It should return the value
// that the cell is collecting for persistence to the model.
- (id)valueForBoundProperty;

// Tell cell to validate the value it has collected against the model.boundProperty
- (BOOL)validateInput;

@end
