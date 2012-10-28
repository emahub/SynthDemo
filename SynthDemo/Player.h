//
//  Player.h
//  wpak32pre1
//
//  Created by 圭太 宮崎 on 12/07/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AudioToolbox/ExtendedAudioFile.h>
#import <AudioToolbox/AudioQueue.h>

#import "Oscillator.h"
#import "Generator.h"
#import "SineGenerator.h"
#import "SawtoothGenerator.h"
#import "WhitenoiseGenerator.h"
#import "BiquadFilter.h"

#define CHANNEL_NUM 2
#define BITS sizeof(float) * 8 //32 // floatは4bytes = 32bits

#define NUM_BUFFERS 3

typedef struct AQCallbackStruct {
    AudioQueueRef   queue;
    UInt32          frameCount;
    AudioQueueBufferRef     mBuffers[NUM_BUFFERS];
    AudioStreamBasicDescription mDataFormat;
} AQCallbackStruct;
AQCallbackStruct in;

@interface Player : NSObject{
    AudioQueueRef queue;
    Float64 mSamplingRate;
    BOOL mPlaying;      // 再生中フラグ
    id mDelegate;       // delegate

    float volume;
    Oscillator *osc;
    ADSR *ampADSR;
    BiquadFilter *filter;
}

@property(readwrite) BOOL mPlaying;
@property(readwrite) float volume;
@property(retain) id osc;
@property(retain) BiquadFilter *filter;

- (id)init:(id)delegate;
- (void)dealloc;
- (BOOL)initAU;
- (id)delegate;
- (void)play;
- (void)pause;
- (void)changeGenerator:(id<Generator>)_osc;

@end

Player *player;