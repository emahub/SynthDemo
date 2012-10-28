//
//  ADSRNSView.h
//  SynthDemo
//
//  Created by Keita Miyazaki on 12/10/28.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ADSR.h"

@interface ADSRNSView : NSView{
    ADSR *adsr;
}

-(void)setADSR:(ADSR*)_adsr;

@end
