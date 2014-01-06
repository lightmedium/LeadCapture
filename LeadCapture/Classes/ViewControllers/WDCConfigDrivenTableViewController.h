//
//  WDCConfigDrivenTableViewController.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDCFormDataProvider.h"

@interface WDCConfigDrivenTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Designated initializer, takes an optional model object.
- (id)initWithNibName:(NSString *)nibName model:(NSObject *)model;

// The tableview to render the form in
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// This is the domain model that the form is representing
@property (nonatomic, strong) NSObject *model;

// This is the form definition that is loaded from the plist
@property (nonatomic, strong) NSMutableDictionary *formDefinition;

// This is the data provider for our form.  It is built form the plist.
// Why? Right now it's for fun, but this is one of the most re-usable ways
// I've found to build a form on iOS. This could just as easily be driven
// from a service, allowing the client to make many of the tweaks that would
// ordinarily require a re-upload of the app.
@property (nonatomic, strong) WDCFormDataProvider *dataProvider;

@end
