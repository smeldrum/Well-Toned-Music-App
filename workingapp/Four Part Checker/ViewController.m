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
#import <QuartzCore/QuartzCore.h>
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
    
    _staff = [[StaffView alloc] initWithFrame: CGRectMake(220, 5, 780, 700)];
    [self.view addSubview: _staff];
    
    _currentvoice = 3;

    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(100, 700, 50, 30);
    button1.tag = 3;
    [button1 setTitle:@"S" forState: UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(155, 700, 50, 30);
    button2.tag = 2;
    [button2 setTitle:@"A" forState: UIControlStateNormal];
    [button2 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(210, 700, 50, 30);
    button3.tag= 1;
    [button3 setTitle:@"T" forState: UIControlStateNormal];
    [button3 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame = CGRectMake(265, 700, 50, 30);
    button4.tag = 0;
    [button4 setTitle:@"B" forState: UIControlStateNormal];
    [button4 addTarget:self action:@selector(changeVoice:) forControlEvents:UIControlEventTouchUpInside];
    [[button4 layer] setBorderWidth:1.0f];
    [[button4 layer] setBorderColor:[UIColor greenColor].CGColor];
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
    
    UIButton * playbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playbutton.frame = CGRectMake(450, 700, 50, 30);
    [playbutton setTitle:@"Play" forState: UIControlStateNormal];
    [playbutton addTarget:self action:@selector(playStaff:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbutton];

    UIButton * sharp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sharp.frame = CGRectMake(70, 620, 50, 30);
    [sharp setTitle:@"#" forState: UIControlStateNormal];
    [sharp addTarget:self action:@selector(selectSharp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharp];
 
    UIButton * flat = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    flat.frame = CGRectMake(140, 620, 50, 30);
    [flat setTitle:@"♭" forState: UIControlStateNormal];
    //[flat addTarget:self action:@selector(selectFlat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flat];
    
    UIImageView * logo1 = [[UIImageView alloc] initWithFrame: CGRectMake(830, 645, 163, 119)];
    [logo1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"logo.png"]]];
    [self.view addSubview:logo1];
    [self addPickerView];
}
-(void) selectSharp: (id)sender{
    [_staff selectSharp];
}
-(void) playStaff: (id)sender
{
    [_staff playStaff];
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
-(void)changeVoice: (UIButton*)sender
{
    for (UIButton* button in self.view.subviews){
        if ([sender isEqual:button]){
            [[button layer] setBorderWidth:1.0f];
            [[button layer] setBorderColor:[UIColor greenColor].CGColor];
        }
        else{
            [[button layer] setBorderWidth:0.0f];
        }
    }
    _currentvoice = sender.tag;
    _staff.currentvoice=_currentvoice;
}

-(void)addPickerView{
    pickerArray = [[NSArray alloc]initWithObjects:@"A♭ Major",@"A Major", @"B♭ Major",
                   @"B Major",@"C Major",@"D Major",@"E♭ Major",@"E major", @"F major",
                   @"G major", nil];
    myTextField = [[UITextField alloc]initWithFrame:
                   CGRectMake(510, 700, 300, 30)];
    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    myTextField.delegate = self;
    [self.view addSubview:myTextField];
    [myTextField setPlaceholder:@"Pick a Key"];
    myPickerView = [[UIPickerView alloc]init];
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(self.view.frame.origin.x,
                                     self.view.frame.origin.y-50,self.view.frame.size.width , 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    myTextField.inputView = myPickerView;
    myTextField.inputAccessoryView = toolBar;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    switch(row){
        case 0:
            _staff.leadingTone = 8;
            _staff.tonic = 10;
            _staff.keySigNum = 11;
            break;
        case 1:
            _staff.leadingTone = 9;
            _staff.tonic = 11;
            _staff.keySigNum = 3;
            break;
        case 2:
            _staff.leadingTone = 11;
            _staff.tonic = 13;
            _staff.keySigNum = 9;
            break;
        case 3:
            _staff.leadingTone = 12;
            _staff.tonic = 14;
            _staff.keySigNum = 5;
            
            break;
        case 4:
            _staff.leadingTone = 14;
            _staff.tonic = 17;
            _staff.keySigNum = 0;
            break;
        case 5:
            _staff.leadingTone = 18;
            _staff.tonic = 20;
            _staff.keySigNum = 2;
            break;
        case 6:
            _staff.leadingTone = 20;
            _staff.tonic = 1;
            _staff.keySigNum = 10;
            break;
        case 7:
            _staff.leadingTone = 21;
            _staff.tonic = 2;
            _staff.keySigNum = 4;
            break;
        case 8:
            _staff.leadingTone = 2;
            _staff.tonic = 5;
            _staff.keySigNum = 8;
            break;
    }
    myTextField.text = [pickerArray objectAtIndex:row];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [pickerArray count];
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [pickerArray objectAtIndex:row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

-(void) done: (UIButton*)sender{
    [myTextField resignFirstResponder];
}


@end
