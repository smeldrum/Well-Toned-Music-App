//
//  ViewController.h
//  MusicApp
//
//  Created by Zoe Sobin on 3/11/13.
//  Copyright (c) 2013 Zoe Sobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
@private
    int numTaps;
}

@property (nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;

@end