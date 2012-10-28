//
//  ADSRNSView.m
//  SynthDemo
//
//  Created by Keita Miyazaki on 12/10/28.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "ADSRNSView.h"

@implementation ADSRNSView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        adsr = [[ADSR alloc] init];
        [self setADSR:adsr];
    }
    
    return self;
}

-(void)setADSR:(ADSR*)_adsr{
    adsr = _adsr;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    float halfHight = dirtyRect.size.height / 2;
    CGContextRef context =[[NSGraphicsContext currentContext]graphicsPort];
    
    CGContextSetRGBFillColor(context,0,0,0,1);
    CGContextFillRect(context,*(CGRect*)&dirtyRect);
    
    CGContextSetRGBStrokeColor(context,1,0,1,1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,0,halfHight);
    
    
    float t = 0; int HABA = 5;
    CGContextAddLineToPoint(context, 0, adsr.attack_level * dirtyRect.size.height*0.9f);
    t+=adsr.attack_time;
    CGContextAddLineToPoint(context, t*20.0f/SAMPLING_FREQ+HABA, adsr.decay_level * dirtyRect.size.height*0.9f);
    t+=adsr.decay_time;
    CGContextAddLineToPoint(context, t*20.0f/SAMPLING_FREQ+HABA*2, adsr.sustain_level * dirtyRect.size.height*0.9f);
    t+=adsr.sustain_time;
    CGContextAddLineToPoint(context, t*20.0f/SAMPLING_FREQ+HABA*3, adsr.release_level * dirtyRect.size.height*0.9f);
    t+=adsr.release_time;
    CGContextAddLineToPoint(context, t*20.0f/SAMPLING_FREQ+HABA*4, 0);
    
    /*
    float frequency = 440.0f;
    if(frequency != 0.0f){    // 初期ビューは適当なサイン波でもだしとく。
        float phase = 0;
        float sinewaveFrequency = frequency;
        float samplingRate = 44100;
        
        float freq = sinewaveFrequency * 2. * M_PI / samplingRate;
        float xUnit = dirtyRect.size.width / samplingRate;
        
        for(int i = 0; i < samplingRate; i++){
            float wave = sin(phase);
            wave *= halfHight;
            CGContextAddLineToPoint(context,xUnit * i,wave + halfHight);
            phase += freq;
        }
    }*/
    
    CGContextDrawPath(context,kCGPathFillStroke);
}

@end
