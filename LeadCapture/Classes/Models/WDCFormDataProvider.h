//
//  WDCFormDataProvider.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WDCFormSection;
@class WDCFormField;

@interface WDCFormDataProvider : NSObject

// array of sections in the form
@property (nonatomic, strong) NSMutableArray *sections;

// A cache of cells.
@property (nonatomic, strong) NSMutableDictionary *cells;

+ (id)initWithFormDefinition:(NSDictionary *)formDef;

- (WDCFormSection *)sectionModelForIndexPath:(NSIndexPath *)indexPath;
- (WDCFormField *)fieldModelForIndexPath:(NSIndexPath *)indexPath;

@end
