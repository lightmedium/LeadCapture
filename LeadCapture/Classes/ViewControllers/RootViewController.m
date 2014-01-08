/*
 Copyright (c) 2011, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "RootViewController.h"
#import "WDCLead.h"
#import "WDCLeadFormTableViewController.h"
#import "MBProgressHUD.h"

@interface RootViewController()
@property (nonatomic, strong) UIView *spinnerContainer;
@end

@implementation RootViewController

#pragma mark Misc

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    self.dataRows = nil;
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Your Leads";
    
    // add the [+] button to the navbar for creating a new lead
    UIBarButtonItem *addNew = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addNewLead)];
    [[self navigationItem] setRightBarButtonItem:addNew];
    
    // don't want cell selection hanging around
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // create a container for the spinner
    [self setSpinnerContainer:[[UIView alloc] initWithFrame:[[self tableView] frame]]];
    [[self view] addSubview:[self spinnerContainer]];
    
    // show the spinner
    MBProgressHUD *spinner = [MBProgressHUD showHUDAddedTo:[self spinnerContainer] animated:YES];
    [spinner setColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.92f]];
    [spinner setCornerRadius:0.0f];
    [spinner setLabelText:@"Loading Leads"];
    [spinner dimBackground];
    [spinner setYOffset:-20.0f];
    [spinner setMargin:8.0f];
    [spinner show:YES];
    
    // load the list of Leads from the WDCLead model
    // the WDCLead model wraps a DAO layer.
    __weak RootViewController *weakSelf = self;
    [WDCLead listLeads:^(BOOL success, id response, NSError *error) {
        // somethign went wrong, alert the user
        if ([error localizedDescription] || !success)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"There was an error loading your leads. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }
        
        // capture the records as serialized WDCLeads
        NSArray *records = [response objectForKey:@"records"];
        [weakSelf setDataRows:[WDCLead initWithArray:records]];
        
        // UI to the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [[weakSelf tableView] reloadData];
            
            // hide the spinner
            [MBProgressHUD hideAllHUDsForView:[weakSelf spinnerContainer] animated:YES];
            [[weakSelf spinnerContainer] removeFromSuperview];
        });
    }];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataRows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *CellIdentifier = @"WDCLeadSummaryCell";

    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to show the data in the WDCLead instance.
	WDCLead *lead = [[self dataRows] objectAtIndex:indexPath.row];
    cell.textLabel.text = [lead name];
    cell.detailTextLabel.text = [lead titleAndCompany];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // grab the lead object (domain model) for the index path
    // instantiate the form view controller with the lead object
    // push the form view controller onto the navigationController
    WDCLead *lead = [[self dataRows] objectAtIndex:indexPath.row];
    WDCLeadFormTableViewController *vc = [[WDCLeadFormTableViewController alloc] initWithNibName:@"WDCLeadFormTableViewController" model:lead];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark - Button Handlers
- (void)addNewLead
{
    // instantiate an empty WDCLead object to hand off to the form
    // instantiate the form view controller with the lead object
    // push the form view controller onto the navigationController
    WDCLead *lead = [[WDCLead alloc] init];
    WDCLeadFormTableViewController *vc = [[WDCLeadFormTableViewController alloc] initWithNibName:@"WDCLeadFormTableViewController" model:lead];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
