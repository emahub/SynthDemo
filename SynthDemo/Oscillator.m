//
//  Oscillator.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/27.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "Oscillator.h"

@implementation Oscillator

- (id) initWithGen:(id<Generator>)_gen ADSR:_ampADSR Filter:_filter PitchLFO:_pitchLFO AmplitudeLFO:_amplitudeLFO FilterLFO:_filterLFO
{
    if (self = [super init])
    {
        NSLog(@"Oscillator init");
        gen = _gen;
        ampADSR = _ampADSR;
        filter = _filter;
        
        pitchLFO = _pitchLFO;
        amplitudeLFO = _amplitudeLFO;
        filterLFO = _filterLFO;
    }
    
    return self;
}

- (float)get
{
    [gen setFreq:freq + [pitchLFO get]];
    float outputValue = [gen get] * [ampADSR get] * (0.5f + [amplitudeLFO get] * 0.5f);
    
    [filter setCutoff:cutoff + [filterLFO get]];
    
    outputValue = [filter get:outputValue];
    
    return outputValue;
}


// ジェネレータの変更
- (void)changeGenerator:(id<Generator>)_gen
{
    gen = _gen;

}

-(void)oscNoteOn:(float)_freq
{
    nowFreq = _freq;
    freq = _freq;
    //[gen setFreq:_freq];
    [ampADSR noteOn];
}

-(void)oscNoteOff:(float)_freq
{
    if(nowFreq == _freq) [ampADSR noteOff];
}

-(void)setFreq:(float)_freq
{
    freq = _freq;
}

-(void)setFilter_type:(int)_type cutoff:(float)_cutoff Q:(float)_q dBGain:(float)_dbgain
{
    cutoff = _cutoff;
    filter.type = _type;
    filter.cutoff = _cutoff;
    filter.q = _q;
    filter.dBGain = _dbgain;
}

-(void)setPitchLFO_freq:(float)_freq amp:(float)_amp
{
    [pitchLFO setFreq:_freq];
    [pitchLFO setAmplitude:_amp];
}

-(void)setAmplitudeLFO_freq:(float)_freq amp:(float)_amp
{
    [amplitudeLFO setFreq:_freq];
    [amplitudeLFO setAmplitude:_amp];
}

-(void)setFilterLFO_freq:(float)_freq amp:(float)_amp
{
    [filterLFO setFreq:_freq];
    [filterLFO setAmplitude:_amp];
}
@end
