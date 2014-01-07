//
//  WDCLeadFormTableViewController.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCLeadFormTableViewController.h"

@interface WDCLeadFormTableViewController ()

@end

@implementation WDCLeadFormTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Lead Detail"];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
