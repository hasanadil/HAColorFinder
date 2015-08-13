//
//  HAColorFinder.m
//  ImageColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

/*
 http://www.catehuston.com/blog/2013/08/26/extracting-the-dominant-color-from-an-image-in-processing/
 */

#import "HAColorFinder.h"
#import "HATrie.h"
#import "HATrieNode.h"
#import "HAColorComponents.h"
#import "HAColorComponentsCount.h"

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )

@interface HAColorFinder()

@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation HAColorFinder

-(instancetype) init {
    self = [super init];
    if (self) {
        self.concurrentQueue = dispatch_queue_create("workers", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

-(void) fetchDominantColorFromImage:(NSImage*)image withCompletion:(void(^)(NSColor *color, NSTimeInterval processingTime))completion {
    
    __block NSMutableDictionary* workerResults = [NSMutableDictionary dictionary];
    
    NSDate* startTime = [NSDate date];
    
    __weak typeof(self) weakMe = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [weakMe imageToPixels:image withCompletion:^(UInt32 *pixels, NSUInteger pixelCount) {
            
            
            /*
             NSLog(@"Brightness of image:");
             UInt32 * currentPixel = pixels;
             for (NSUInteger j = 0; j < height; j++) {
             for (NSUInteger i = 0; i < width; i++) {
             // 3.
             UInt32 color = *currentPixel;
             printf("%3.0f ", (R(color)+G(color)+B(color))/3.0);
             // 4.
             currentPixel++;
             }
             printf("\n");
             }
             */
            
            //Divide up the work among workers
            NSUInteger numberOfWorkers = 4;
            NSUInteger pixelsPerWorker = pixelCount/numberOfWorkers;
            
            for (NSUInteger worker = 0; worker < numberOfWorkers; worker++) {
                
                //Submit work blocks to be executed concurrently
                dispatch_async(weakMe.concurrentQueue, ^{
                    
                    //Add the colors result to a trie data strucuture whose leaf is the counter, O(1) baby
                    HATrie *trie = [[HATrie alloc] init];
                    
                    //Get the pixels to work on
                    NSUInteger workerOffset = worker * pixelsPerWorker;
                    
                    UInt32 * workerPixels;
                    workerPixels = (UInt32 *) calloc(pixelsPerWorker, sizeof(UInt32));
                    memcpy(workerPixels, pixels + workerOffset, pixelsPerWorker);
                    
                    //Loop over the pixels of interest
                    UInt32 * currentPixel = workerPixels;
                    for (NSUInteger j = 0; j < pixelsPerWorker; j++) {
                        UInt32 color = *currentPixel;
                        
                        float red = R(color);
                        float green = G(color);
                        float blue = B(color);
                        if ((red == 0 && green == 0 && blue == 0) || (red == 1 && green == 1 && blue == 1)) {
                            continue;
                        }
                        //NSLog(@"%f, %f, %f", red, green, blue);
                        HAColorComponents *components = [[HAColorComponents alloc] initWithRed:red green:green blue:blue];
                        [trie addColorComponents:components];
                        
                        currentPixel++;
                    }
                    
                    HAColorComponentsCount *maxColorComponentsCount = trie.maxCountColorComponents;
                    [workerResults setObject:maxColorComponentsCount forKey:@(worker)];
                });
            }
            
            //wait on everything to be completed
            dispatch_barrier_async(weakMe.concurrentQueue, ^{
                
                //Get the highest count amont the worker results
                NSArray* allCounts = [workerResults allValues];
                NSSortDescriptor* countSort = [[NSSortDescriptor alloc] initWithKey:@"count" ascending:NO];
                NSArray* sortedCounts = [allCounts sortedArrayUsingDescriptors:@[countSort]];
                HAColorComponentsCount* colorComponentCount = [sortedCounts firstObject];
                HAColorComponents *components = colorComponentCount.components;
                
                NSColor *dominantColor = [NSColor colorWithCalibratedRed:components.red/255.f green:components.green/255.f blue:components.blue/255.f alpha:1.0];
                
                NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startTime];
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(dominantColor, time);
                    });
                }
            });
        }];
    });
}

-(void) imageToPixels:(NSImage*)image withCompletion:(void(^)(UInt32 *pixels, NSUInteger pixelCount))completion {
    
    //Extract pixels from the image in a 1D array
    CFDataRef inputData = (__bridge CFDataRef)[image TIFFRepresentation];
    CGImageSourceRef inputSource = CGImageSourceCreateWithData(inputData, NULL);
    CGImageRef inputCGImage = CGImageSourceCreateImageAtIndex(inputSource, 0, NULL);
    NSUInteger width = CGImageGetWidth(inputCGImage);
    NSUInteger height = CGImageGetHeight(inputCGImage);
    NSUInteger numberOfPixels = height * width;
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    
    //Store all pixels in this array
    UInt32 * pixels;
    pixels = (UInt32 *) calloc(numberOfPixels, sizeof(UInt32));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //Fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), inputCGImage);
    
    //Cleanup
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if (completion) {
        completion(pixels, numberOfPixels);
    }
}

-(void) processPixels:(UInt32*)pixels {
    
}

@end























