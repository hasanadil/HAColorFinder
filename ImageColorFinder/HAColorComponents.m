//
//  HAColorComponents.m
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "HAColorComponents.h"

@implementation HAColorComponents

-(instancetype) initWithRed:(float)red green:(float)green blue:(float)blue {
    self = [super init];
    if (self) {
        _red = red;
        _green = green;
        _blue = blue;
    }
    return self;
}

@end
