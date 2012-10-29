//
//  Player.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/24.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize volume, mPlaying, osc, filter, ampADSR, pitchLFO, effectDelay;


static void AQBufferCallback(void *in, AudioQueueRef inQ, AudioQueueBufferRef outQB) {
	int i;
	OSStatus err;
	int outputValue;
	
	AQCallbackStruct *inData = (AQCallbackStruct *)in;
	short *coreAudioBuffer = (short*) outQB->mAudioData;
	
	
	if (inData->frameCount > 0) {
		outQB->mAudioDataByteSize = 4*inData->frameCount;
		
		for(i=0; i<inData->frameCount*2; i=i+2) {
            if(player.mPlaying){
                outputValue = [player.osc get] * 32767.0f;
                // outputValue = [player->filter get:outputValue];
                
                // effect
                outputValue = [player.effectDelay get:outputValue];
                
                // volume + guard
                outputValue *= player.volume;
                if(outputValue > 32767) outputValue = 32767;
                else if(outputValue < -32768) outputValue = -32768;
                
                // output
                coreAudioBuffer[i] = outputValue;
                coreAudioBuffer[i+1] = coreAudioBuffer[i];
            } else {
                coreAudioBuffer[i] = 0;
                coreAudioBuffer[i+1] = 0;
            }
		}
		AudioQueueEnqueueBuffer(inQ, outQB, 0, NULL);
	} else {
		err = AudioQueueStop(inData->queue, false);
	}
}

// 初期化メソッド
- (id)init:(id)delegate
{
    self = [super init];
    if( self==nil )
        return nil;
    player = self;
    
    // initialize メンバ変数
    NSLog(@"Player init initialize value");
    
    filter = [[BiquadFilter alloc] init];
    [filter setLPF_f0:10000.0f Q:1.0f];
    
    ampADSR = [[ADSR alloc] init];
    
    pitchLFO = [[SineGenerator alloc] init];
    [pitchLFO setFreq:0.0f];
    [pitchLFO setAmplitude:0.0f];
    amplitudeLFO = [[SineGenerator alloc] init];
    [amplitudeLFO setFreq:0.0f];
    [amplitudeLFO setAmplitude:0.0f];
    filterLFO = [[SineGenerator alloc] init];
    [filterLFO setFreq:0.0f];
    [filterLFO setAmplitude:0.0f];
    
    osc = [[Oscillator alloc] initWithGen:[[SineGenerator alloc] init]
                    ADSR:ampADSR Filter:filter PitchLFO:pitchLFO AmplitudeLFO:amplitudeLFO FilterLFO:filterLFO];
    
    mDelegate = delegate;
    mPlaying = NO;
    volume = 0.8f;
    
    effectDelay = [[EffectDelay alloc] init];
    
    // AudioUnitの初期化
    NSLog(@"Player Audiounit initialize");
    bool bRet = [self initAU];
    if(bRet != YES){
        //[self release];
        return nil;
    }

    
    return self;
}

// AudioUnitの初期化
- (BOOL)initAU
{
    OSStatus err;
    
    // config AQCallBack
    in.mDataFormat.mSampleRate = 44100.0;
	in.mDataFormat.mFormatID = kAudioFormatLinearPCM;
	in.mDataFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
	in.mDataFormat.mBytesPerPacket = 4;
	in.mDataFormat.mFramesPerPacket = 1;
	in.mDataFormat.mBytesPerFrame = 4;
	in.mDataFormat.mChannelsPerFrame = 2;
	in.mDataFormat.mBitsPerChannel = 16;
	in.frameCount = 1024;
	
    err = AudioQueueNewOutput(&in.mDataFormat, AQBufferCallback, &in, CFRunLoopGetCurrent(), kCFRunLoopCommonModes, 0, &in.queue);
	if(err) NSLog(@"AudioQueueNewOutput err %d", err);
	
	UInt32 bufferBytes = in.frameCount * in.mDataFormat.mBytesPerFrame;
	
	for (int i=0; i< NUM_BUFFERS; i++) {
		err = AudioQueueAllocateBuffer(in.queue, bufferBytes, &in.mBuffers[i]);
		if(err) NSLog(@"AudioQueueAllocateBuffer [%d] err %d",i, err);
		AQBufferCallback (&in, in.queue, in.mBuffers[i]);
	}
	
	err = AudioQueueSetParameter(in.queue, kAudioQueueParam_Volume, 1.0);
	if(err) NSLog(@"AudioQueueSetParameter err %d", err);
    
	err = AudioQueueStart(in.queue, NULL);
	if(err) NSLog(@"AudioQueueStart err %d", err);
	
	queue = in.queue;
    
    NSLog(@"initAU %d\n", YES);
    
    return YES;
    
}

// リリース
- (void)dealloc
{
    AudioQueueStop(queue,true);
	AudioQueueDispose(queue, true);
}

// delegateオブジェクトの取得
- (id)delegate
{
    return mDelegate;
}

// 再生開始
- (void)play
{
    mPlaying = YES;
    NSLog(@"mPlaying: %d\n", mPlaying);
}

// 一時停止
- (void)pause
{
    mPlaying = NO;
    NSLog(@"mPlaying: %d\n", mPlaying);
}

// オシレータの変更
- (void)changeGenerator:(id<Generator>)_gen
{
    bool b = mPlaying;
    if(b) mPlaying = NO;
    
    [osc changeGenerator:_gen];
    
    if(b) mPlaying = YES;
}

@end
