//
//  SynthDemoTests.m
//  SynthDemoTests
//
//  Created by Keita Miyazaki on 12/10/28.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "SynthDemoTests.h"

@implementation SynthDemoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    filter = [[BiquadFilter alloc] init];
    [filter setLPF_f0:600.0f Q:1.0f];
    
    ampADSR = [[ADSR alloc] init];
    
    osc = [[Oscillator alloc] initWithGen:[[SineGenerator alloc] init] ADSR:ampADSR Filter:filter];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    // STFail(@"Unit tests are not implemented yet in SynthDemoTests");
}

- (void)testAmpADSRGetValueOnLinx
{
    STAssertEqualObjects([ampADSR getValueOnLineX:5 Y1:0.0f Y2:10.0f len:20], 2.5f, @"getValueOnLineX");
}

@end
