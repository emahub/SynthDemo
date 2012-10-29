//
//  BiquadFilter.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "BiquadFilter.h"

@implementation BiquadFilter
@synthesize type, cutoff, q, dBGain;

- (id)init{
    self = [super init];
    type = 0;
    cutoff = 10000.0f;
    q = 1.0f;
    dBGain = 0.0f;
    
    return self;
}
- (float) get:(float)_x{
    switch(type){
        case FILTER_TYPE_LPF:
            [self setLPF_f0:cutoff Q:q];
            break;
        case FILTER_TYPE_HPF:
            [self setHPF_f0:cutoff Q:q];
            break;
        case FILTER_TYPE_BPF:
            [self setBPF_f0:cutoff Q:q];
            break;
        case FILTER_TYPE_PEAKINGEQ:
            [self setpeakingEQ_f0:cutoff Q:q dBGain:dBGain];
            break;
        case FILTER_TYPE_LOWSHELF:
            [self setlowShelf_f0:cutoff Q:q dBGain:dBGain];
            break;
        case FILTER_TYPE_HIGHSHELF:
            [self sethighShelf_f0:cutoff Q:q dBGain:dBGain];
            break;
    }
    
    float ret = (b0/a0)*_x + (b1/a0)*x1 + (b2/a0)*x2 - (a1/a0)*y1 - (a2/a0)*y2;
    x2 = x1;
    x1 = _x;
    y2 = y1;
    y1 = ret;
    return ret;
}

- (void) setLPF_f0:(float)_f0 Q:(float)_Q{
    float w0 = 2*M_PI*_f0/SAMPLING_FREQ;
    float alpha = sin(w0)/(2*_Q);
    
    b0 =  (1 - cos(w0))/2;
    b1 =   1 - cos(w0);
    b2 =  (1 - cos(w0))/2;
    a0 =   1 + alpha;
    a1 =  -2*cos(w0);
    a2 =   1 - alpha;
}

- (void) setHPF_f0:(float)_f0 Q:(float)_Q{
    float w0 = 2*M_PI*_f0/SAMPLING_FREQ;
    float alpha = sin(w0)/(2*_Q);
    
    b0 =  (1 + cos(w0))/2;
    b1 = -(1 + cos(w0));
    b2 =  (1 + cos(w0))/2;
    a0 =   1 + alpha;
    a1 =  -2*cos(w0);
    a2 =   1 - alpha;
}

- (void) setBPF_f0:(float)_f0 Q:(float)_Q{
    float w0 = 2*M_PI*_f0/SAMPLING_FREQ;
    float alpha = sin(w0)/(2*_Q);
    
    b0 =   alpha;
    b1 =   0;
    b2 =  -alpha;
    a0 =   1 + alpha;
    a1 =  -2*cos(w0);
    a2 =   1 - alpha;
}




- (void) setpeakingEQ_f0:(float)_f0 Q:(float)_Q dBGain:(float)_dBGain{
    float w0 = 2*M_PI*_f0/SAMPLING_FREQ;
    float alpha = sin(w0)/(2*_Q);
    float A = pow(10, _dBGain/40);

    b0 =   1 + alpha*A;
    b1 =  -2*cos(w0);
    b2 =   1 - alpha*A;
    a0 =   1 + alpha/A;
    a1 =  -2*cos(w0);
    a2 =   1 - alpha/A;
}

- (void) setlowShelf_f0:(float)_f0 Q:(float)_Q dBGain:(float)_dBGain{
    float w0 = 2*M_PI*_f0/SAMPLING_FREQ;
    float alpha = sin(w0)/(2*_Q);
    float A = pow(10, _dBGain/40);
    
    b0 =    A*( (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha );
    b1 =  2*A*( (A-1) - (A+1)*cos(w0)                   );
    b2 =    A*( (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha );
    a0 =        (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha;
    a1 =   -2*( (A-1) + (A+1)*cos(w0)                   );
    a2 =        (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha;
}


- (void) sethighShelf_f0:(float)_f0 Q:(float)_Q dBGain:(float)_dBGain{
    float w0 = 2*M_PI*_f0/SAMPLING_FREQ;
    float alpha = sin(w0)/(2*_Q);
    float A = pow(10, _dBGain/40);
    
    b0 =    A*( (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha );
    b1 = -2*A*( (A-1) + (A+1)*cos(w0)                   );
    b2 =    A*( (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha );
    a0 =        (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha;
    a1 =    2*( (A-1) - (A+1)*cos(w0)                   );
    a2 =        (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha;
}

- (void) printStatus{
    NSLog(@"Biquad filter status- type:%d cutoff:%.2f q:%.2f dBGain:%.2f", type, cutoff, q, dBGain);
}
@end
