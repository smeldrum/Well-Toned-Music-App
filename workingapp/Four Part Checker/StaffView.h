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
@property NSMutableArray * inversion;
@property int currentInversion;
@property int keySigNum;
@property BOOL sharp;
@property BOOL flat;
@property NSArray * sharpList;
@property NSArray * flatList;
-(void)clearStaff;
-(void)checkStaff;
-(void)playStaff;
-(void)selectSharp;
-(void)selectFlat;

@end
