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

/*
 Add a new color's RGB values to the trie.
 */
-(void) addColorComponents:(HAColorComponents*)colorComponents;

/*
 Returns the color that has the most number of counts
 */
-(HAColorComponentsCount*) maxCountColorComponents;

@end
