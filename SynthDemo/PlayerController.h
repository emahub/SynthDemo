//
//  PlayerContoroller.h
//  SynthDemo
//
//  Created by Keita Miyazaki on 12/10/28.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>
#import "Player.h"
#import "Generator.h"
#import "SineGenerator.h"
#import "SawtoothGenerator.h"
#import "SquareGenerator.h"
#import "WhitenoiseGenerator.h"
#import "ADSRNSView.h"

@class Player;

#define	CHANNEL_NUM 2

@interface PlayerController : NSObject{
    Player* player;
    IBOutlet NSButton *playButton;
    IBOutlet NSSlider *volumeSlider;
    
    IBOutlet NSMatrix *ganeratorRadioGroup;
    IBOutlet NSButton *noteOnButton;
    
    IBOutlet NSSlider *frequencySlider;
    
    IBOutlet NSMatrix *filterRadioGroup;
    IBOutlet NSSlider *filterFrequencySlider;
    IBOutlet NSSlider *filterQSlider;
    IBOutlet NSSlider *filterdBGainSlider;
    
    IBOutlet ADSRNSView *ampADSRNView;
    IBOutlet NSSlider *ampADSRAttackLevel;
    IBOutlet NSSlider *ampADSRDecayLevel;
    IBOutlet NSSlider *ampADSRSustainLevel;
    IBOutlet NSSlider *ampADSRReleaseLevel;
    IBOutlet NSSlider *ampADSRAttackTime;
    IBOutlet NSSlider *ampADSRDecayTime;
    IBOutlet NSSlider *ampADSRSustainTime;
    IBOutlet NSSlider *ampADSRReleaseTime;
}

-(id) init;
-(void)dealloc;
-(IBAction)play:(id)sender;
-(IBAction)noteOn:(id)sender;
-(IBAction)setOscillator:(id)sender;
-(IBAction)setFilter:(id)sender;
-(IBAction)setFrequency:(id)sender;
-(IBAction)setVolume:(id)sender;
-(IBAction)updateAmpADSRView:(id)sender;
- (double)getFreqWithMIDI:(int)_note;

@end

PlayerController *playerController;
