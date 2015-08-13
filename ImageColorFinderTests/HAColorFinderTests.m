//
//  HAColorFinderTests.m
//  HAColorFinder
//
//  Created by Hasan Adil on 8/12/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "HAColorFinder.h"

@interface HAColorFinderTests : XCTestCase

@end

@implementation HAColorFinderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testColorFinderNil {
    XCTestExpectation *expectation = [self expectationWithDescription:@"ready"];
    
    HAColorFinder *colorFinder = [[HAColorFinder alloc] init];
    [colorFinder fetchDominantColorFromImage:nil withCompletion:^(NSColor *color, NSTimeInterval processingTime) {
        XCTAssertNil(color, "False");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        XCTAssertNil(error, "Error");
    }];
}

@end
