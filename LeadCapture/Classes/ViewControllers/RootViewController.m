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

#import "SFRestAPI.h"
#import "SFRestRequest.h"

#import "WDCLead.h"
#import "WDCLeadFormTableViewController.h"

@implementation RootViewController

@synthesize dataRows;

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
    [self listLeads];
}

// TODO: Move to WDCLead model
- (void)listLeads
{
    // load our leads from the SFRestAPI
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Id, Name, FirstName, LastName, Company, Title, Email, Phone FROM Lead WHERE Status = 'Open - Not Contacted'"];
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    // we have leads, let's serialize them in to WDCLead instances
    NSArray *records = [jsonResponse objectForKey:@"records"];
    self.dataRows = [WDCLead initWithArray:records];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
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
	WDCLead *lead = [dataRows objectAtIndex:indexPath.row];
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
    WDCLead *lead = [dataRows objectAtIndex:indexPath.row];
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
