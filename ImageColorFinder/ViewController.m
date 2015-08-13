//
//  ViewController.m
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

//http://www.catehuston.com/blog/2013/08/26/extracting-the-dominant-color-from-an-image-in-processing/

#import "ViewController.h"
#import "HAColorFinder.h"

@implementation ViewController

-(void) dealloc {
    [self.imageView removeObserver:self forKeyPath:@"image"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.colorWell setHidden:YES];
    self.colorWell.layer.cornerRadius = 32;
    
    [self.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
}

-(HAColorFinder*) colorFinder {
    if (!colorFinder) {
        colorFinder = [[HAColorFinder alloc] init];
    }
    return colorFinder;
}

#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isEqual:self.imageView] && [keyPath isEqualToString:@"image"]) {
        
        [self.infoLabel setHidden:YES];
        [self.colorWell setHidden:YES];
        [self.progressIndicator startAnimation:nil];
        
        __weak typeof(self) weakMe = self;
        [self.colorFinder fetchDominantColorFromImage:self.imageView.image withCompletion:^(NSColor *color, NSTimeInterval processingTime) {
            NSLog(@"%@ in %f", color, processingTime*1000);
            
            weakMe.colorWell.color = color;
            [weakMe.colorWell setHidden:NO];
            [weakMe.progressIndicator stopAnimation:nil];
        }];
    }
}

@end
