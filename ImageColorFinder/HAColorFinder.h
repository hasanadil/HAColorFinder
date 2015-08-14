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

/*
 Return the color in the image that is most dominant. 
 Where dominant is defined as the most number of pixels which contain the same color.
 */
-(void) fetchDominantColorFromImage:(NSImage*)image
                     withCompletion:(void(^)(NSColor *color, NSTimeInterval processingTime))completion;

@end
