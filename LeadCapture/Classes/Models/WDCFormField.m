//
//  WDCFormField.m
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import "WDCFormField.h"
#import "NSMutableString+Utilities.h"
#import "WDCConfigDrivenTableViewCell.h"

@implementation WDCFormField

+ (id)initWithFieldDefinition:(NSDictionary*)dict;
{
    // as long as the properties on our Lead model mirror the properties we receive from the
    // service, we won't have to touch this code as we add/remove mappings from the service.
    
    // instantiate the field instance that we will hydrate with the dictionary
    WDCFormField *field = [[WDCFormField alloc] init];
    
    // iterate over the properties in the dictionary and apply them to the lead model
    // if we can.
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // we want to filter out NSNulls and leave their associated properties nil
        // in order to maintain peace and happiness down stream.
        if (obj == (id)[NSNull null]) return;
        
        // if we aren't dealing with a string key, we can't handle it.
        if (! [key isKindOfClass:[NSString class]]) return;
        
        // turn the key into a setter that we'll check against the model object.
        NSMutableString *setterStr = [@"set" mutableCopy];
        NSMutableString *mutableKey = [key mutableCopy];
        [setterStr appendFormat:@"%@:", [mutableKey capitalize]];
        SEL setter = NSSelectorFromString(setterStr);
        
        // finally, if the model responds to the setter, set it.
        if ([field respondsToSelector:setter])
        {
            // we know that it's safe to suppress this memory leak warning because we are not
            // returning anything with memory implications that arc needs to worry about.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [field performSelector:setter withObject:obj];
#pragma clang diagnostic pop
        }
    }];
    
    return field;
}

// We're caching the WDCConfigDrivenTableViewCell used to present this form field
- (WDCConfigDrivenTableViewCell *)tableViewCell;
{
    if (_tableViewCell != nil)
    {
        return _tableViewCell;
    }
    
    // we didn't have a cell yet, let's create one based on the field config data
    NSMutableString *CellIdentifier = [[self type] mutableCopy];
    
    // construct cell class name from the field definition's type property
    NSString *cellClassName = [NSString stringWithFormat:@"WDC%@Cell", [CellIdentifier capitalize]];
    
    // get somethign we can instantiate
    Class CellClass = NSClassFromString(cellClassName);
    
    // instantiate it
    WDCConfigDrivenTableViewCell *cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:[self model] fieldDefinition:self];
    
    if (![cell isKindOfClass:[UITableViewCell class]])
    {
        // Helper log for when the config is incorrect.
        NSLog(@"\n\n\nWe didn't create a UITableViewCell!!\nWe created a %@\n\n\n", [cell class]);
    }
    
    // cache the cell in the field model
    [self setTableViewCell:cell];
    
    return cell;
}

// bucket-brigade calls to validate the cell's value
- (BOOL)validate;
{
    return [[self tableViewCell] validateInput];
}

@end
