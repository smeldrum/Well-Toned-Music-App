//
//  AppDelegate.h
//  MusicApp
//
//  Created by Zoe Sobin on 3/11/13.
//  Copyright (c) 2013 Zoe Sobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

-(void)setup;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UIView *staff;

@end