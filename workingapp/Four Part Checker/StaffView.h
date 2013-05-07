//
//  StaffView.h
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HarmonyPlayer.h"

@interface StaffView : UIScrollView
@property NSMutableArray * soprano;
@property NSMutableArray * alto;
@property NSMutableArray * tenor;
@property NSMutableArray * bass;
@property int currentvoice;
@property int leadingTone;
@property int tonic;
@property HarmonyPlayer * musicplayer;
@property BOOL sharp;

-(BOOL)hasParallelFifths:(NSNumber*)note1 withNote2:(NSNumber*)note2 withVoice2:(NSNumber*)note3 withNote4:(NSNumber*)note4;
-(void)clearStaff;
-(void)checkStaff;
-(void)playStaff;
-(void)selectSharp;
@end
