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
    float velocity;
    BiquadFilter *filter;
    
    float nowFreq;
}

-(id)initWithGen:(id<Generator>)_gen ADSR:_ampADSR Filter:_filter;
-(float)get; // -1.0fから1.0fの間で返す
-(void)setFreq:(float)_value;
-(void)changeGenerator:(id<Generator>)_gen;
-(void)oscNoteOn:(float)_freq;
-(void)oscNoteOff:(float)_freq;
@end
