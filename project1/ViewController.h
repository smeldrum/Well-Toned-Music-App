//
//  ViewController.h
//  project1
//
//  Created by Zoe Sobin on 3/14/13.
//  Copyright (c) 2013 Zoe Sobin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollView;

@interface MyViewController : UIViewController
{
    IBOutlet UIScrollView *scrollView; // holds five small images to scroll horizontally
 
}

@property (nonatomic, retain) UIView *scrollView;
@end
