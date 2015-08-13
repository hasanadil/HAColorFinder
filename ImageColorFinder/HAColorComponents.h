//
//  HAColorComponents.h
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAColorComponents : NSObject

@property (nonatomic, assign) float red;
@property (nonatomic, assign) float green;
@property (nonatomic, assign) float blue;

-(instancetype) initWithRed:(float)red green:(float)green blue:(float)blue;

@end
