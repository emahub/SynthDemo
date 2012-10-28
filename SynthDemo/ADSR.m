//
//  ADSR.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/26.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "ADSR.h"

@implementation ADSR

@synthesize attack_time, attack_level, decay_time, decay_level, sustain_time, sustain_level, release_time, release_level, time, bFinish;

- (id) init
{
    if (self = [super init])
    {
        NSLog(@"ADSR init");
        attack_time = 44100.0f;
        attack_level = 0.0f;
        decay_time = 44100.0f;
        decay_level = 1.0f;
        sustain_time = 44100.0f;
        sustain_level = 0.7f;
        release_time = 44100.0f;
        release_level = 0.5f;

        time = 0;
        bFinish = NO;
    }
    
    return self;
}

-(float)get{
    time+=0.1f;
    int t = attack_time + decay_time + sustain_time+release_time;
    if(time > t){
        bFinish = YES;
        return 0.0f;
    }
    t -= release_time;
    if(time > t)
        return [self getValueOnLineX:time-t Y1:release_level Y2:0.0f len:release_time];
    
    t -= sustain_time;
    if(time > t)
        return [self getValueOnLineX:time-t Y1:sustain_level Y2:release_level len:sustain_time];
    
    t -= decay_time;
    if(time > t)
        return [self getValueOnLineX:time-t Y1:decay_level Y2:sustain_level len:decay_time];
    
    return [self getValueOnLineX:time Y1:attack_level Y2:decay_level len:attack_time];

}

-(void)noteOff{
    release_level = [self get];
    time = attack_time + decay_time + sustain_time;
}

-(float)getValueOnLineX:(int)_x Y1:(int)_y1 Y2:(int)_y2 len:(int)_len{
    return (_y2-_y1) * (_x-_len) / _len + _y1;
}
@end
