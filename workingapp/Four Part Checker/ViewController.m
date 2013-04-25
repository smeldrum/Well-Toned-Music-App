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
    
    _staff = [[StaffView alloc] initWithFrame: CGRectMake(200, 5, 800, 700)];
    [self.view addSubview: _staff];
    
    _currentvoice = 3;
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(100, 700, 50, 30);
    [button1 setTitle:@"S" forState: UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(155, 700, 50, 30);
    [button2 setTitle:@"A" forState: UIControlStateNormal];
    [button2 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(210, 700, 50, 30);
    [button3 setTitle:@"T" forState: UIControlStateNormal];
    [button3 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame = CGRectMake(265, 700, 50, 30);
    [button4 setTitle:@"B" forState: UIControlStateNormal];
    [button4 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
    UIButton * button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button5.frame = CGRectMake(330, 700, 50, 30);
    [button5 setTitle:@"Clear" forState: UIControlStateNormal];
    [button5 addTarget:self action:@selector(clearStaff:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    
    UIButton * checkbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkbutton.frame = CGRectMake(390, 700, 50, 30);
    [checkbutton setTitle:@"Check" forState: UIControlStateNormal];
    [checkbutton addTarget:self action:@selector(checkStaff:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkbutton];
    

    
    
    UIImageView * logo1 = [[UIImageView alloc] initWithFrame: CGRectMake(830, 645, 163, 119)];
    [logo1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"logo.png"]]];
    [self.view addSubview:logo1];
    
    [self allocateData];
}
-(void) clearStaff: (id)sender
{
    [_staff clearStaff];
}
-(void) checkStaff: (id)sender
{
    [_staff checkStaff];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeVoice: (id)sender
{
    if ([[sender currentTitle] isEqualToString:@"S"]) _currentvoice = 3;
    else if ([[sender currentTitle] isEqualToString:@"A"]) _currentvoice = 2;
    else if ([[sender currentTitle]isEqualToString:@"T"]) _currentvoice = 1;
    else if ([[sender currentTitle] isEqualToString:@"B"]) _currentvoice = 0;
    _staff.currentvoice=_currentvoice;
    NSLog(@"%@",[sender currentTitle]);
}
- (void)allocateData{
    StaffData * data = [[StaffData alloc] init];
    [data changeChordNote:3 withLine:1 withIndex:0];
}

@end
