//
//  EffectDelay.m
//  SynthDemo
//
//  Created by Keita Miyazaki on 12/10/29.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "EffectDelay.h"
#import "define.h"

@implementation EffectDelay
-(id)init
{
    self = [super init];
    
    point = 0;
    size = INITIAL_SIZE;
    buffer = (float *)malloc(sizeof(float) * size);
    for(int i=0; i<size; i++) buffer[i] = 0.0f;
    lock = NO;
    wet = 0.1f;
    feedback = 0.1f;
    
    return self;
}

-(float)get:(float)_value{
    if(lock) return _value;
    else{
        float ret = _value + buffer[point] * wet;
        buffer[point] = ret * feedback;
        point++;
        if(point >= size) point=0;
        
        return ret;
    }
    
}

-(void)setTime:(int)_time{
    lock = YES;

    free(buffer);
    point = 0;
    size = _time;
    buffer = (float *)malloc(sizeof(float) * size);
    for(int i=0; i<size; i++) buffer[i] = 0.0f;
    
    lock = NO;
}

-(void)setWet:(float)_wet{
    wet = _wet;
}

-(void)setFeedback:(float)_feedback{
    feedback = _feedback;
}

-(void)dealloc{
    free(buffer);
}

@end
