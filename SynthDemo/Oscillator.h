//
//  Oscillator.h
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/27.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Generator.h"
#import "BiquadFilter.h"
#import "ADSR.h"

@interface Oscillator : NSObject{
    id<Generator> gen;
    ADSR *ampADSR;
    BiquadFilter *filter;
    
    float freq;
    id<Generator> pitchLFO;
    
    
    float nowFreq;  // 送信された再生ピッチ
}

- (id) initWithGen:(id<Generator>)_gen ADSR:_ampADSR Filter:_filter PitchLFO:_pitchLFO;
-(float)get; // -1.0fから1.0fの間で返す
-(void)changeGenerator:(id<Generator>)_gen;
-(void)oscNoteOn:(float)_freq;
-(void)oscNoteOff:(float)_freq;
-(void)setFreq:(float)_freq;
-(void)setPitchLFO_freq:(float)_freq amp:(float)_amp;
@end
