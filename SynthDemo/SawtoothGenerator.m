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
        amplitude = 1.0f;
    }
    
    return self;
}

-(float) get{
    radius += (2.0 * M_PI * frequency) / SAMPLING_FREQ;
    if(radius >= M_PI*2) radius -= M_PI*2;
    return (radius / M_PI - 1.0f) * amplitude;
}

-(void) setFreq:(float)_freq{
    frequency = _freq;
}

-(void) setAmplitude:(float)_amplitude{
    amplitude = _amplitude;
}
@end
