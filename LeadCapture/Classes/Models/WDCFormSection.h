//
//  WDCFormSection.h
//  LeadCapture
//
//  Created by C. Michael Close on 1/5/14.
//  Copyright (c) 2014 LightMedium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCFormSection : NSObject

// an array of fields in the section
@property (nonatomic, strong) NSMutableArray *fields;


+ (id)initWithSectionDefinition:(NSDictionary *)sectionDef;
@end
