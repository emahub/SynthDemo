//
//  Oscillator.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/27.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "Oscillator.h"

@implementation Oscillator

- (id) initWithGen:(id<Generator>)_gen ADSR:_ampADSR Filter:_filter
{
    if (self = [super init])
    {
        NSLog(@"Oscillator init");
        gen = _gen;
        ampADSR = _ampADSR;
        filter = _filter;
        velocity = 1.0f;
    }
    
    return self;
}

- (float)get
{
    float outputValue = [gen get] * [ampADSR get];
    outputValue = [filter get:outputValue];
    outputValue *= velocity;
    
    return outputValue;
}

-(void)setFreq:(float)_value
{
    [gen setFreq:_value];
}

// ジェネレータの変更
- (void)changeGenerator:(id<Generator>)_gen
{
    //[gen release];
    gen = _gen;

}

-(void)oscNoteOn:(float)_freq
{
    nowFreq = _freq;
    [gen setFreq:_freq];
    [ampADSR noteOn];
}

-(void)oscNoteOff:(float)_freq
{
    if(nowFreq == _freq) [ampADSR noteOff];
}
@end
