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

@interface WDCConfigDrivenTableViewController ()

- (NSMutableDictionary *)loadFormDefinition;

@end

@implementation WDCConfigDrivenTableViewController

- (id)initWithNibName:(NSString *)nibName model:(NSObject *)model;
{
    if ((self = [super initWithNibName:nibName bundle:nil])) {
        _model = model;
        _formDefinition = [self loadFormDefinition];
        if (_formDefinition != nil)
        {
            _dataProvider = [self hydrateDataProviderWithFormDefinition:_formDefinition];
        }
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneTouched)];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouched)];
        
        // if this is an existing model, we disable the done button
        // TODO: create a model protocol for the fiew (just this one for now)
        //       properties that we need to access on the model.
        if ([[self model] valueForKey:@"id"])
        {
            [done setEnabled:NO];
        }
        
        [[self navigationItem] setLeftBarButtonItem:cancel];
        [[self navigationItem] setRightBarButtonItem:done];
    }
    return self;
}

#pragma mark - Nav Bar Button Item Touch Handlers

- (void)doneTouched
{
    NSLog(@"done touched");
    // validate each cell
    
    if ([[self dataProvider] validateRequiredCells])
    {
        // if valid, save the record
        [[self model] performSelector:@selector(save)];
        
        // when save is done, go back
        [[self navigationController] popViewControllerAnimated:YES];
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
    // Return the number of sections.
    return [[[self dataProvider] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WDCFormSection *s = [[[self dataProvider] sections] objectAtIndex:section];
    return [[s fields] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDCFormField *field = [[self dataProvider] fieldModelForIndexPath:indexPath];
    [field setModel:[self model]];
    WDCConfigDrivenTableViewCell *cell = [field tableViewCell];
    [cell setTableView:[self tableView]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDCFormField *field = [[self dataProvider] fieldModelForIndexPath:indexPath];
    return [[field rowHeight] floatValue];
}

#pragma mark - Form Config Loading

- (NSMutableDictionary *)loadFormDefinition;
{
    // infer the name of the plist from the client view controller class name
    NSMutableString *plistName = [NSStringFromClass([self class]) mutableCopy];
    [plistName appendString:@"Def"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *config = [NSDictionary dictionaryWithContentsOfFile:path];
    return [config mutableCopy];
}

- (WDCFormDataProvider *)hydrateDataProviderWithFormDefinition:(NSDictionary *)formDef
{
    WDCFormDataProvider *dp = [WDCFormDataProvider initWithFormDefinition:formDef];
    return dp;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
