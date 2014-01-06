//
//  WDCConfigDrivenTableViewController.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDCConfigDrivenTableViewController : UITableViewController

// Designated initializer, takes an optional model object.
- (id)initWithStyle:(UITableViewStyle)style model:(NSObject *)model;

// This is the domain model that the form is representing
@property (nonatomic, strong) NSObject *model;

// This is the form definition that is loaded from the plist
@property (nonatomic, strong) NSMutableDictionary *formDefinition;

@end
