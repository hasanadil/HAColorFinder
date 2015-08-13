//
//  HATrieNode.h
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HATrieNode : NSObject

@property (nonatomic, strong) HATrieNode* parentNode;

//[color component : node for it]
@property (nonatomic, strong) NSMutableDictionary* childNodes;

@property (nonatomic, assign) float colorComponent;

//For leaf level nodes only
@property (nonatomic, assign) NSUInteger count;

@end
