//
//  SineOscillator.h
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/25.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Generator.h"

@interface SineGenerator : NSObject<Generator>{
    float radius;
    float frequency;
}
-(id) init;
-(float) get;
-(void) setFreq:(float)_freq;
@end
