//
//  WhitenoiseOscillator.h
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Generator.h"

@interface WhitenoiseGenerator : NSObject<Generator>{
    float amplitude;
}
-(id) init;
-(float) get;
-(void) setFreq:(float)_freq;
-(void) setAmplitude:(float)_amplitude;
@end
