//
//  Generator.h
//  SynthTest
//
//  Created by Keita Miyazaki on 12/10/27.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Generator <NSObject>
-(float) get;   // -1.0 ~ 1.0の間で返す
-(void) setFreq:(float)_freq;
@end
