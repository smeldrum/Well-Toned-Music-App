//
//  StaffView.h
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffView : UIScrollView
@property NSMutableArray * soprano;
@property NSMutableArray * alto;
@property NSMutableArray * tenor;
@property NSMutableArray * bass;
@property int currentvoice;

-(void)clearStaff;
-(void)checkStaff;
@end
