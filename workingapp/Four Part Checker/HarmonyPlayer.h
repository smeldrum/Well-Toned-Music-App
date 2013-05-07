//
//  HarmonyPlayer.h
//  Four Part Checker
//
//  Created by Zoe Sobin on 5/7/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface HarmonyPlayer : UIView

@property (strong, nonatomic) AVAudioPlayer *sop;
@property (strong, nonatomic) AVAudioPlayer *alt;
@property (strong, nonatomic) AVAudioPlayer *ten;
@property (strong, nonatomic) AVAudioPlayer *bas;
-(void)play: (NSMutableArray*)soprano a:(NSMutableArray*)alto a:(NSMutableArray*)tenor a:(NSMutableArray*)bass;
@end
