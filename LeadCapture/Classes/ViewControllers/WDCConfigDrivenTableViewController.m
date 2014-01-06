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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[self tableView] setDelegate:self];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    WDCFormField *field = [self fieldModelForIndexPath:indexPath];
    NSMutableString *CellIdentifier = [[field type] mutableCopy];
    
    // construct cell class name from the field definition's type property
    NSString *cellClassName = [NSString stringWithFormat:@"WDC%@Cell", [CellIdentifier capitalize]];
    
    // get somethign we can instantiate
    Class CellClass = NSClassFromString(cellClassName);
    
    // instantiate it
    WDCConfigDrivenTableViewCell *cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:[self model] fieldDefinition:field];
    
    // save it to the data provider
    NSString *cellInstanceId = [NSString stringWithFormat:@"%@_%@", [[self model] class], [field boundProperty]];
    [[[self dataProvider] cells] setObject:cell forKey:cellInstanceId];
    
    if (![cell isKindOfClass:[UITableViewCell class]])
    {
        NSLog(@"\n\n\nWe didn't create a UITableViewCell!!\n\n\n");
    }
    
    return (UITableViewCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDCFormField *field = [self fieldModelForIndexPath:indexPath];
    return [[field rowHeight] floatValue];
}


#pragma mark - Form Data Access Helpers
- (WDCFormSection *)sectionModelForIndexPath:(NSIndexPath *)indexPath
{
    return [[[self dataProvider] sections] objectAtIndex:indexPath.section];
}

- (WDCFormField *)fieldModelForIndexPath:(NSIndexPath *)indexPath
{
    WDCFormSection *section = [self sectionModelForIndexPath:indexPath];
    return [[section fields] objectAtIndex:indexPath.row];
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
