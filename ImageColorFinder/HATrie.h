//
//  HATrie.h
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HATrieNode.h"
#import "HAColorComponents.h"
#import "HAColorComponentsCount.h"

@interface HATrie : NSObject

-(void) addColorComponents:(HAColorComponents*)colorComponents;

-(HAColorComponentsCount*) maxCountColorComponents;

@end
