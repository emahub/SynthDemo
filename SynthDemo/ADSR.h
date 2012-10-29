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
    float attack_level, decay_level, sustain_level, release_level;
    int attack_time, decay_time, sustain_time, release_time;
    
    int time;
    bool bFinish;
    bool bNoteOn;
}


@property(readwrite) float attack_level;
@property(readwrite) float decay_level;
@property(readwrite) float sustain_level;
@property(readwrite) float release_level;
@property(readwrite) int attack_time;
@property(readwrite) int decay_time;
@property(readwrite) int sustain_time;
@property(readwrite) int release_time;
@property(readwrite) int time;
@property(readwrite) bool bFinish;

-(id)init;
-(float)get;    // 0.0 ~ 1.0の間
-(void)noteOn;
-(void)noteOff;
-(float)getValueOnLineX:(float)_x Y1:(float)_y1 Y2:(float)_y2 len:(float)_len;
-(void)printStatus;

@end
