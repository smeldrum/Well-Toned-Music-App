//
//  ViewController.h
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoteScrollView;
@class StaffView;

@interface ViewController : UIViewController
<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    UITextField *myTextField;
    UIPickerView *myPickerView;
    NSArray *pickerArray;
}
@property StaffView* staff;
@property int currentvoice;

@end
