//
//  ADSR.h
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/26.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"

@interface ADSR : NSObject{
    float attack_time, attack_level, decay_time, decay_level,
    sustain_time, sustain_level, release_time, release_level;
    
    int time;
    bool bFinish;
}

@property(readwrite) float attack_time;
@property(readwrite) float attack_level;
@property(readwrite) float decay_time;
@property(readwrite) float decay_level;
@property(readwrite) float sustain_time;
@property(readwrite) float sustain_level;
@property(readwrite) float release_time;
@property(readwrite) float release_level;
@property(readwrite) int time;
@property(readwrite) bool bFinish;

-(id)init;
-(float)get;    // 0.0 ~ 1.0の間
-(void)noteOn;
-(void)noteOff;
-(float)getValueOnLineX:(float)_x Y1:(float)_y1 Y2:(float)_y2 len:(float)_len;

@end
