//
//  ViewController.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "ViewController.h"
#import "StaffView.h"
#import "StaffData.h"
@class StaffView;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *imageName = [NSString stringWithFormat:@"musicstaff.png"];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 10, 800, 591)];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
    NSString *imageName2 = [NSString stringWithFormat:@"staff2.png"];
    UIImage *image2 = [UIImage imageNamed:imageName2];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame: CGRectMake(800, 19, 200, 582)];
    [imageView2 setImage:image2];
    [self.view addSubview:imageView2];
    
    StaffView * staff = [[StaffView alloc] initWithFrame: CGRectMake(200, 10, 800, 591)];
    [self.view addSubview:staff];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(100, 650, 50, 30);
    [button1 setTitle:@"S" forState: UIControlStateNormal];
    [self.view addSubview:button1];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(155, 650, 50, 30);
    [button2 setTitle:@"A" forState: UIControlStateNormal];
    [self.view addSubview:button2];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(210, 650, 50, 30);
    [button3 setTitle:@"T" forState: UIControlStateNormal];
    [self.view addSubview:button3];
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame = CGRectMake(265, 650, 50, 30);
    [button4 setTitle:@"B" forState: UIControlStateNormal];
    [self.view addSubview:button4];
    [self allocateData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)allocateData{
    StaffData * data = [[StaffData alloc] init];
    [data changeChordNote:3 withLine:1 withIndex:0];
}

@end
