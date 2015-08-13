//
//  HATrieNode.m
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "HATrieNode.h"

@implementation HATrieNode

-(instancetype) init {
    self = [super init];
    if (self) {
        _childNodes = [NSMutableDictionary dictionary];
        _count = 0;
    }
    return self;
}

-(BOOL) isEqual:(id)object {
    if (!object) {
        return NO;
    }
    if (![object isKindOfClass:[HATrieNode class]]) {
        return NO;
    }
    
    return self.count == ((HATrieNode*)object).colorComponent;
}

@end
