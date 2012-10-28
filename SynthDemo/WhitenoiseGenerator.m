//
//  WhitenoiseOscillator.m
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "WhitenoiseGenerator.h"

@implementation WhitenoiseGenerator

- (id) init
{
    if (self = [super init])
    {
        NSLog(@"WhitenoiseGeneratorr init");
    }
    
    return self;
}

-(float) get{
    return (float) random()/RAND_MAX;
}

-(void) setFreq:(float)_freq{
    NSLog(@"Whitenoise don't use freq=%f parameter.", _freq);
}

@end
