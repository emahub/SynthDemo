//
//  SineOscillator.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "SineGenerator.h"

@implementation SineGenerator

- (id) init
{
    if (self = [super init])
    {
        NSLog(@"SineGenerator init");
        radius = 0;
        frequency = 440;
        //now_frequency = frequency;
        amplitude = 1.0f;
    }
    
    return self;
}

-(float) get{
    //now_frequency += (frequency - now_frequency) * 0.0001f;
    //radius += (2.0 * M_PI * now_frequency) / SAMPLING_FREQ;
    radius += (2.0 * M_PI * frequency) / SAMPLING_FREQ;
    if(radius >= M_PI*2) radius -= M_PI*2;
    return sin(radius) * amplitude;
}

-(void) setFreq:(float)_freq{
    frequency = _freq;
}

-(void) setAmplitude:(float)_amplitude{
    amplitude = _amplitude;
}

@end
