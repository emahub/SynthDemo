//
//  SawtoothOscillator.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "SawtoothGenerator.h"

@implementation SawtoothGenerator

- (id) init
{
    if (self = [super init])
    {
        NSLog(@"SawtoothGenerator init");
        radius = 0;
        frequency = 440;
    }
    
    return self;
}

-(float) get{
    radius += (2.0 * M_PI * frequency) / 44100.0;
    if(radius >= M_PI*2) radius -= M_PI*2;
    return radius / M_PI - 1.0f;
}

-(void) setFreq:(float)_freq{
    frequency = _freq;
}

@end
