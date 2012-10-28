//
//  BiquadFilter.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "BiquadFilter.h"

@implementation BiquadFilter

- (float) get:(float)_x{
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
@end
