//
//  WDCConfigDrivenTableViewCell.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCConfigDrivenTableViewCell.h"
#import "WDCFormField.h"

@implementation WDCConfigDrivenTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(NSObject *)model fieldDefinition:(WDCFormField *)fieldDef;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _model = model;
        _fieldDefinition = fieldDef;
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self validateInput];
}

- (BOOL)validateInput;
{
    NSError *error = nil;
    id value = [self valueForBoundProperty];
    BOOL fieldIsValid = [[self model] validateValue:&value forKey:[[self fieldDefinition] boundProperty] error:&error];
    
    if (fieldIsValid && (error == nil))
    {
        // TODO check that the setter exists.
        [[self model] setValue:value forKey:[[self fieldDefinition] boundProperty]];
        return YES;
    }
    return NO;
}

- (id)valueForBoundProperty;
{
    NSAssert(NO, @"\n\n\nYOU MUST IMPLEMENT (id)valueForBoundProperty in the cell\n\n\n");
    return nil;
}

@end
