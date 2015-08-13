//
//  HAColorFinder.h
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface HAColorFinder : NSObject

-(void) fetchDominantColorFromImage:(NSImage*)image withCompletion:(void(^)(NSColor *color, NSTimeInterval processingTime))completion;

@end
