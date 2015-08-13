//
//  ViewController.h
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HAColorFinder.h"

@interface ViewController : NSViewController {
    HAColorFinder* colorFinder;
}

//User interface
@property (nonatomic, weak) IBOutlet NSImageView* imageView;
@property (nonatomic, weak) IBOutlet NSColorWell* colorWell;
@property (nonatomic, weak) IBOutlet NSProgressIndicator* progressIndicator;

@end

