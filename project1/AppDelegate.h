//
//  AppDelegate.h
//  project1
//
//  Created by Zoe Sobin on 3/14/13.
//  Copyright (c) 2013 Zoe Sobin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    IBOutlet UIWindow *window;
    IBOutlet ViewController *viewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@end
