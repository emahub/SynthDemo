//
//  BiquadFilter.h
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "math.h"

#define SAMPLING_FREQ 44100.0f

@interface BiquadFilter : NSObject{
    float a0, a1, a2, b0, b1, b2;
    float x1, x2, y1, y2;   // x1 = x[n-1], x2 = x[n-2], y1 = y[n-1], y2 = y[n-2]
}

- (float) get:(float)_x;
- (void) setLPF_f0:(float)_f0 Q:(float)_Q;
- (void) setHPF_f0:(float)_f0 Q:(float)_Q;
- (void) setBPF_f0:(float)_f0 Q:(float)_Q;
- (void) setpeakingEQ_f0:(float)_f0 Q:(float)_Q dBGain:(float)_dBGain;
- (void) setlowShelf_f0:(float)_f0 Q:(float)_Q dBGain:(float)_dBGain;
- (void) sethighShelf_f0:(float)_f0 Q:(float)_Q dBGain:(float)_dBGain;

@end
