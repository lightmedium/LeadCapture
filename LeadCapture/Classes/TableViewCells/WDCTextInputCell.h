//
//  WDCTextInputCell.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDCConfigDrivenTableViewCell.h"

@interface WDCTextInputCell : WDCConfigDrivenTableViewCell <UITextFieldDelegate>

// for editing the field
@property (nonatomic, strong) UITextField *inputField;

@end
