//
//  EffectDelay.h
//  SynthDemo
//
//  Created by Keita Miyazaki on 12/10/29.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#define INITIAL_SIZE SAMPLING_FREQ

@interface EffectDelay : NSObject{
    int point;
    int size;
    float *buffer;
    bool lock;
    float wet;
    float feedback;
}

-(id)init;
-(float)get:(float)_value;
-(void)setTime:(int)_time;
-(void)setWet:(float)_wet;
-(void)setFeedback:(float)_feedback;
-(void)dealloc;
@end
