//
//  WDCFormDataProvider.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCFormDataProvider : NSObject

// array of sections in the form
@property (nonatomic, strong) NSMutableArray *sections;

// A cache of cells. We are working with a short form.  Also,
// since forms are typically not long lists, this is OK.
// This can be configurable to avoid memory issues for
// ridonculously long forms.
@property (nonatomic, strong) NSMutableDictionary *cells;

+ (id)initWithFormDefinition:(NSDictionary *)formDef;

@end
