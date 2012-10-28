//
//  PlayerContoroller.m
//  SynthDemo
//
//  Created by Keita Miyazaki on 12/10/28.
//  Copyright (c) 2012年 Keita Miyazaki. All rights reserved.
//

#import "PlayerController.h"

static void
MIDIInputProc(const MIDIPacketList *pktlist,
              void *readProcRefCon, void *srcConnRefCon)
{
    //MIDIパケットリストの先頭のMIDIPacketのポインタを取得
    MIDIPacket *packet = (MIDIPacket *)&(pktlist->packet[0]);
    //パケットリストからパケットの数を取得
    UInt32 packetCount = pktlist->numPackets;
    
    for (NSInteger i = 0; i < packetCount; i++) {
        
        //data[0]からメッセージの種類とチャンネルを分けて取得する
        Byte mes = packet->data[0] & 0xF0;
        Byte ch = packet->data[0] & 0x0F;
        
        //メッセージの種類に応じてログに表示
        if ((mes == 0x90) && (packet->data[2] != 0)) {
            float freq = [playerController getFreqWithMIDI:packet->data[1]];
            NSLog(@"note on number = %2.2x(%f) / vel = %2.2x / ch = %2.2x", packet->data[1], freq, packet->data[2], ch);
            [player.osc oscNoteOn:freq];
        } else if (mes == 0x80 || mes == 0x90) {
            float freq = [playerController getFreqWithMIDI:packet->data[1]];
            NSLog(@"note off number = %2.2x / vel = %2.2x / ch = %2.2x", packet->data[1], packet->data[2], ch);
            [player.osc oscNoteOff:freq];
        } else if (mes == 0xB0) {
            NSLog(@"cc number = %2.2x / data = %2.2x / ch = %2.2x",
                  packet->data[1], packet->data[2], ch);
        } /*else {
           NSLog(@"etc");
           }*/
        
        //次のパケットへ進む
        packet = MIDIPacketNext(packet);
    }
}


@implementation PlayerController

- (id) init
{
    if (self = [super init])
    {
        NSLog(@"init");
        player = [[Player alloc] init:self];
        
        // midi inputの初期化
        OSStatus err;
        NSString *clientName;
        MIDIClientRef inputClientRef;
        MIDIPortRef inputPortRef;
        
        clientName = @"inputClient";
        err = MIDIClientCreate((__bridge CFStringRef)clientName, NULL, NULL, &inputClientRef);
        if (err != noErr) {
            NSLog(@"MIDIClientCreate err = %d", err);
        } else{
            //MIDIポートを作成する
            NSString *inputPortName = @"inputPort";
            err = MIDIInputPortCreate(
                                      inputClientRef, (__bridge CFStringRef)inputPortName,
                                      MIDIInputProc, NULL, &inputPortRef);
            if (err != noErr) {
                NSLog(@"MIDIInputPortCreate err = %d", err);
            } else {
                //MIDIエンドポイントを取得し、MIDIポートに接続する
                ItemCount sourceCount = MIDIGetNumberOfSources();
                for (ItemCount i = 0; i < sourceCount; i++) {
                    MIDIEndpointRef sourcePointRef = MIDIGetSource(i);
                    err = MIDIPortConnectSource(inputPortRef, sourcePointRef, NULL);
                    if (err != noErr) {
                        NSLog(@"MIDIPortConnectSource err = %d", err);
                    }
                }
            }
        }
        
        playerController = self;
        [self updateAmpADSRView:nil];
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"PlayerController dealloc");
    //[player dealloc];
    //[super dealloc];
}

- (IBAction)play:(id)sender{
     if(player.mPlaying){
        [player pause];
        playButton.title = @"Play";
    } else {
        [player play];
        playButton.title = @"Pause";
    }
}

- (IBAction)noteOn:(id)sender{
    [player.osc oscNoteOn:frequencySlider.floatValue];
    
}

- (IBAction)setOscillator:(id)sender{
    NSLog(@"setOscillator:%ld, %@\n", ganeratorRadioGroup.selectedRow, [[ganeratorRadioGroup selectedCell] title]);
    
    id<Generator> gen;
    switch(ganeratorRadioGroup.selectedRow){
        case 1:
            gen = [[SawtoothGenerator alloc] init];
            break;
        case 2:
            gen = [[SquareGenerator alloc] init];
            break;
        case 3:
            gen = [[WhitenoiseGenerator alloc] init];
            break;
        default:
            gen = [[SineGenerator alloc] init];
            break;
    }
    
    [player changeGenerator:gen];
}

- (IBAction)setFilter:(id)sender{
    switch(filterRadioGroup.selectedRow){
        case 0:
            [player.filter setLPF_f0:filterFrequencySlider.floatValue Q:filterQSlider.floatValue];
            break;
        case 1:
            [player.filter setHPF_f0:filterFrequencySlider.floatValue Q:filterQSlider.floatValue];
            break;
        case 2:
            [player.filter setBPF_f0:filterFrequencySlider.floatValue Q:filterQSlider.floatValue];
            break;
        case 3:
            [player.filter setpeakingEQ_f0:filterFrequencySlider.floatValue Q:filterQSlider.floatValue dBGain:filterdBGainSlider.floatValue];
            break;
        case 4:
            [player.filter setlowShelf_f0:filterFrequencySlider.floatValue Q:filterQSlider.floatValue dBGain:filterdBGainSlider.floatValue];
            break;
        case 5:
            [player.filter sethighShelf_f0:filterFrequencySlider.floatValue Q:filterQSlider.floatValue dBGain:filterdBGainSlider.floatValue];
            break;
    }
}

-(IBAction)setFrequency:(id)sender{
    [player.osc setFreq:frequencySlider.floatValue];
}

-(IBAction)setVolume:(id)sender{
    [player setVolume:volumeSlider.floatValue/100.0f];
}

-(IBAction)updateAmpADSRView:(id)sender{
    player.ampADSR.attack_level = ampADSRAttackLevel.floatValue;
    player.ampADSR.decay_level = ampADSRDecayLevel.floatValue;
    player.ampADSR.sustain_level = ampADSRSustainLevel.floatValue;
    player.ampADSR.release_level = ampADSRReleaseLevel.floatValue;
    player.ampADSR.attack_time = ampADSRAttackTime.floatValue * SAMPLING_FREQ;
    player.ampADSR.decay_time = ampADSRDecayTime.floatValue * SAMPLING_FREQ;
    player.ampADSR.sustain_time = ampADSRSustainTime.floatValue * SAMPLING_FREQ;
    player.ampADSR.release_time = ampADSRReleaseTime.floatValue * SAMPLING_FREQ;
    [ampADSRNView setADSR:player.ampADSR];
}

// midiノート番号から周波数を求める
-(double)getFreqWithMIDI:(int)_note{
    // A(69) = 440hzを利用
    return 440.0f * pow(2.0f, (_note-69) / 12.0f);
}

@end
