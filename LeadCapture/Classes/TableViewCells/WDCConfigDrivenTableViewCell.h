//
//  WDCConfigDrivenTableViewCell.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDCFormField;

@interface WDCConfigDrivenTableViewCell : UITableViewCell <UITextFieldDelegate>

// each cell is given a domain model and a field configuration.
// this is the domain model.
@property (nonatomic, strong) NSObject *model;

// this is the configuration model.
@property (nonatomic, strong) WDCFormField *fieldDefinition;

// designated initializer. Most cells end up needing to be
// subclassed, or else put up with a lot of noise in your
// tableView:cellForRowAtIndexPath: method
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(NSObject *)model fieldDefinition:(WDCFormField *)fieldDef;


// This method must be implemented in the subclass.  It should return the value
// that the cell is collecting for persistence to the model.
- (id)valueForBoundProperty;

@end
