//
//  HATrie.m
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "HATrie.h"

@interface HATrie()

@property (nonatomic, strong) HATrieNode *root;
@property (nonatomic, strong) HATrieNode *maxCountLeaf;

@end

@implementation HATrie

-(instancetype) init {
    self = [super init];
    if (self) {
        _root = [[HATrieNode alloc] init];
    }
    return self;
}

-(void) addColorComponents:(HAColorComponents*)colorComponents {
    [self addColorComponent:colorComponents toNode:self.root atLevel:1];
}

-(void) addColorComponent:(HAColorComponents*)colorComponents toNode:(HATrieNode*)parentNode atLevel:(NSUInteger)level {
    float component = -1;
    if (level == 1) {
        component = colorComponents.red;
    }
    else if (level == 2) {
        component = colorComponents.green;
    }
    else if (level == 3) {
        component = colorComponents.blue;
    }
    
    //search children of parent of a matching node if any
    NSMutableDictionary* children = parentNode.childNodes;
    HATrieNode* matchingChildNode = [children objectForKey:@(component)];
    if (!matchingChildNode) {
        matchingChildNode = [[HATrieNode alloc] init];
        matchingChildNode.parentNode = parentNode;
        matchingChildNode.colorComponent = component;
        [children setObject:matchingChildNode forKey:@(component)];
    }
    
    if (level < 3) {
        [self addColorComponent:colorComponents toNode:matchingChildNode atLevel:level+1];
    }
    else {
        //At the leaf
        
        matchingChildNode.count = matchingChildNode.count + 1;
        
        if (!self.maxCountLeaf) {
            self.maxCountLeaf = matchingChildNode;
        }
        else {
            if (self.maxCountLeaf.count < matchingChildNode.count) {
                self.maxCountLeaf = matchingChildNode;
            }
        }
    }
}

-(HAColorComponentsCount*) maxCountColorComponents {
    //Walk up the trie from the max leaf
    
    HAColorComponents *components = [[HAColorComponents alloc] init];
    components.blue = self.maxCountLeaf.colorComponent;
    components.green = self.maxCountLeaf.parentNode.colorComponent;
    components.red = self.maxCountLeaf.parentNode.parentNode.colorComponent;
    
    HAColorComponentsCount* componentCount = [[HAColorComponentsCount alloc] init];
    componentCount.components = components;
    componentCount.count = self.maxCountLeaf.count;
    
    return componentCount;
}

@end













