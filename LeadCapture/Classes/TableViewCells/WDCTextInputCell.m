//
//  WDCTextInputCell.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDCTextInputCell.h"
#import "WDCFormField.h"

@implementation WDCTextInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(NSObject *)model fieldDefinition:(WDCFormField *)fieldDef;
{
    // part of this inverstion of control pattern means that definition of cell style is encpasulated in each cell type.
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier model:model fieldDefinition:fieldDef]))
    {
        _inputField = [[UITextField alloc] initWithFrame:CGRectZero];
        [_inputField setDelegate:self];
        [_inputField setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
        [_inputField setPlaceholder:[[self fieldDefinition] label]];
        [_inputField setText:[[self model] valueForKey:[[self fieldDefinition] boundProperty]]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int frameWidth = [self frame].size.width;
    int frameHeight = [self frame].size.height;
    int inputHeight = [[[self inputField] font] lineHeight];
    int inputWidth = frameWidth - 30;
    int inputX = 15;
    int inputY = (frameHeight - inputHeight + 2) / 2;
    [[self inputField] setFrame:CGRectMake(inputX, inputY, inputWidth, inputHeight)];
    
    [[self contentView] addSubview:[self inputField]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
