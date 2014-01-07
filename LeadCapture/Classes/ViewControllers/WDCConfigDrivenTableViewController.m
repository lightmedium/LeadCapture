//
//  WDCConfigDrivenTableViewController.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCConfigDrivenTableViewController.h"
#import "WDCConfigDrivenTableViewCell.h"
#import "NSMutableString+Utilities.h"
#import "WDCFormSection.h"
#import "WDCFormField.h"
#import "MBProgressHUD.h"

@interface WDCConfigDrivenTableViewController ()

@end

@implementation WDCConfigDrivenTableViewController

- (id)initWithNibName:(NSString *)nibName model:(id<WDCPersistentModelProtocol>)model;
{
    if ((self = [super initWithNibName:nibName bundle:nil])) {
        _model = model;
        _formDefinition = [self loadFormDefinition];
        if (_formDefinition != nil)
        {
            // construct the data provider with the form definition loaded from the plist
            _dataProvider = [WDCFormDataProvider initWithFormDefinition:_formDefinition];
        }
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(saveTouched)];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouched)];
        
        // if this is an existing model, we disable the done button
        // TODO: create a model protocol for the fiew (just this one for now)
        //       properties that we need to access on the model.
        if (![[self model] isNew])
        {
            [done setEnabled:NO];
        }
        
        [[self navigationItem] setLeftBarButtonItem:cancel];
        [[self navigationItem] setRightBarButtonItem:done];
    }
    return self;
}

#pragma mark - Nav Bar Button Item Touch Handlers

- (void)saveTouched
{
    NSLog(@"done touched");
    // validate each cell
    
    if ([[self dataProvider] validateRequiredCells])
    {
        // TODO: this shouldn't be in the abstract view controller unless it's configurable
        // show the progress indicator
        MBProgressHUD *spinner = [MBProgressHUD showHUDAddedTo:[self view] animated:YES];
        [spinner setColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.92f]];
        [spinner setCornerRadius:0.0f];
        [spinner setLabelText:@"Loading Leads"];
        [spinner dimBackground];
        [spinner setYOffset:-20.0f];
        [spinner setMargin:8.0f];
        [spinner show:YES];
        
        // if valid, save the record
        [[self model] save:^(BOOL success, id response, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // hide the progress indicator
                [MBProgressHUD hideAllHUDsForView:[self view] animated:YES];
                
                if (success)
                {
                    // when save is done, go back
                    [[self navigationController] popViewControllerAnimated:YES];
                }
                else
                {
                    // alert the user
                }
            });
        }];
    }
    
    // else do nothing.
}

- (void)cancelTouched
{
    NSLog(@"cancel touched");
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return the number of sections in the data provider.
    return [[[self dataProvider] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of fields in the section of the data provider
    WDCFormSection *s = [[[self dataProvider] sections] objectAtIndex:section];
    return [[s fields] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // grab the field model
    WDCFormField *field = [[self dataProvider] fieldModelForIndexPath:indexPath];
    
    // set a reference to the domain model (the WDCLead instance) on the field model
    [field setModel:[self model]];
    
    // everything we need to know about instantiating the cell is encapsulated in the field model.
    // the field model caches its own cell instance.
    WDCConfigDrivenTableViewCell *cell = [field tableViewCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // height is a property loaded from the field definition in the plist
    WDCFormField *field = [[self dataProvider] fieldModelForIndexPath:indexPath];
    return [[field rowHeight] floatValue];
}

#pragma mark - Form Config Loading

- (NSMutableDictionary *)loadFormDefinition;
{
    // infer the name of the plist from the client view controller class name
    // this way, implementations of concrete view controllers don't need to
    // worry about loading their controller-specific plist. As long as the plist
    // is named "class name" + "Def" the view controller will be configured with it.
    NSMutableString *plistName = [NSStringFromClass([self class]) mutableCopy];
    [plistName appendString:@"Def"];
    
    // load the plist with the name we just assembled
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *config = [NSDictionary dictionaryWithContentsOfFile:path];
    return [config mutableCopy];
}

@end
