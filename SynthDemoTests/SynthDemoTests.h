//
//  SynthDemoTests.h
//  SynthDemoTests
//
//  Created by Keita Miyazaki on 12/10/28.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "BiquadFilter.h"
#import "ADSR.h"
#import "Oscillator.h"
#import "SineGenerator.h"

@interface SynthDemoTests : SenTestCase{
    BiquadFilter *filter;
    ADSR *ampADSR;
    Oscillator *osc;

}

@end
