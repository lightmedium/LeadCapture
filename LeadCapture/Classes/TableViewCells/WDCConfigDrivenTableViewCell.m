//
//  WDCConfigDrivenTableViewCell.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/6/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCConfigDrivenTableViewCell.h"

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

@end
