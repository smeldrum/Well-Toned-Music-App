//
//  ViewController.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "ViewController.h"
#import "StaffView.h"
@class StaffView;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    StaffView * staff = [[StaffView alloc] initWithFrame: CGRectMake(100, 100, 600, 99)];
    [self.view addSubview:staff];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
