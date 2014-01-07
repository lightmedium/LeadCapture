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
//    WDCFormField *field = [[WDCFormField alloc] init];
//    
//    [field setLabel:[obj valueForKey:@"label"]];
//    [field setType:[obj valueForKey:@"type"]];
//    [field setBoundProperty:[obj valueForKey:@"boundProperty"]];
//    [field setAction:[obj valueForKey:@"action"]];
//    
//    return field;
    
    // for now, the properties on our Lead model can mirror the properties we receive from the
    // service.  As long as this is true, we won't have to touch this code.
    
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

- (UITableViewCell *)tableViewCell;
{
    if (_tableViewCell != nil)
    {
        return _tableViewCell;
    }
    
    NSMutableString *CellIdentifier = [[self type] mutableCopy];
    
    // construct cell class name from the field definition's type property
    NSString *cellClassName = [NSString stringWithFormat:@"WDC%@Cell", [CellIdentifier capitalize]];
    
    // get somethign we can instantiate
    Class CellClass = NSClassFromString(cellClassName);
    
    // instantiate it
    WDCConfigDrivenTableViewCell *cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:[self model] fieldDefinition:self];
    
    if (![cell isKindOfClass:[UITableViewCell class]])
    {
        NSLog(@"\n\n\nWe didn't create a UITableViewCell!!\n\n\n");
    }
    
    [self setTableViewCell:cell];
    
    return (UITableViewCell *)cell;

}
@end
