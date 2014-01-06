//
//  LeadFormViewController.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "LeadFormViewController.h"

@interface LeadFormViewController ()

@end

@implementation LeadFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self lead])
    {
        [self populateFieldsWithLead:[self lead]];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
