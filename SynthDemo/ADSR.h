//
//  ADSR.h
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/26.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SPEED 0.1f;

@interface ADSR : NSObject{
    float attack_time, attack_level, decay_time, decay_level,
    sustain_time, sustain_level, release_time, release_level;
    
    float time;
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
@property(readwrite) float time;
@property(readwrite) bool bFinish;

-(id)init;
-(float)get;    // 0.0 ~ 1.0の間
-(void)noteOff;
-(float)getValueOnLineX:(int)_x Y1:(int)_y1 Y2:(int)_y2 len:(int)_len;

@end
