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
        attack_time = SAMPLING_FREQ * 0.1f;
        decay_time = SAMPLING_FREQ * 2.0f;
        sustain_time = SAMPLING_FREQ * 2.0f;
        release_time = SAMPLING_FREQ * 0.1f;
        attack_level = 0.0f;
        decay_level = 1.0f;
        sustain_level = 1.0f;
        release_level = 0.0f;

        time = attack_time+decay_time+sustain_time+release_time;
        bFinish = YES;
        bNoteOn = NO;
    }
    
    return self;
}

-(float)get{
    if(bFinish) return 0.0f;
    
    time++;
    int t = attack_time + decay_time + sustain_time+release_time;
    
    // 全ての時間経過終了
    if(time > t){
        bFinish = YES;
        return 0.0f;
    }
    
    // リリース
    t -= release_time;
    if(time > t)
        return [self getValueOnLineX:time-t Y1:release_level Y2:0.0f len:release_time];
    
    // ストップ
    if(time == t){
        time--;
        return release_level;
    }
    
    // サステイン
    t -= sustain_time;
    if(time > t)
        return [self getValueOnLineX:time-t Y1:sustain_level Y2:release_level len:sustain_time];
    
    
    // ディケイ
    t -= decay_time;
    if(time > t)
        return [self getValueOnLineX:time-t Y1:decay_level Y2:sustain_level len:decay_time];
    
    // アタック
    return [self getValueOnLineX:time Y1:attack_level Y2:decay_level len:attack_time];

}

-(void)noteOn{
    time = 0;
    bFinish = NO;
    bNoteOn = YES;
}

-(void)noteOff{
    release_level = [self get];
    time = attack_time + decay_time + sustain_time;
    bNoteOn = NO;
}

-(float)getValueOnLineX:(float)_x Y1:(float)_y1 Y2:(float)_y2 len:(float)_len{
    return (_y2-_y1) * _x / _len + _y1;
}

-(void)printStatus{
    NSLog(@"ADSR:%.2f %.2f %.2f %.2f %d %d %d %d",
          attack_level, decay_level, sustain_level, release_level,
          attack_time, decay_time, sustain_time, release_time);
}
@end
