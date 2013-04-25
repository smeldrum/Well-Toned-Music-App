//
//  StaffView.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "StaffView.h"
#import "Note.h"
#import <QuartzCore/QuartzCore.h>
@implementation StaffView
@synthesize currentvoice;

const CGFloat kScrollObjHeight  = 650;
const CGFloat kScrollObjWidth   = 50;
const NSUInteger kNumImages     = 1000;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _soprano = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        _alto = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        _tenor = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        _bass = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        for (int i = 0; i < kNumImages; i++){
            [_soprano addObject:[NSNumber numberWithInt:0]];
            [_alto addObject:[NSNumber numberWithInt:0]];
            [_tenor addObject:[NSNumber numberWithInt:0]];
            [_bass addObject:[NSNumber numberWithInt:0]];
        }
        
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCanCancelContentTouches:NO];
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.clipsToBounds = YES;
        self.scrollEnabled = YES;
        self.pagingEnabled = YES;
        
        // add invisible buttons to the scroll view
        NSUInteger i;
        for (i = 0; i <= kNumImages; i++)
        {
            UIButton *beat = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScrollObjWidth, kScrollObjHeight)];
            [beat addTarget:self action: @selector(addNote:withevent:) forControlEvents:UIControlEventTouchUpInside];
            // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
            beat.tag = i;  // tag our images for later use when we place them in serial fashion
 
            [self addSubview:beat];
        }
        
        [self layoutScrollImages];  // now place the photos in serial layout within the scrollview

    }
    return self;
}

- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = [self subviews];
    
    // reposition all image subviews in a horizontal serial fashion
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIButton class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            
            curXLoc += (kScrollObjWidth);
        }
    }
    
    // set the content size so it can be scrollable
    [self setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [self bounds].size.height)];
}


-(void)addNote: (UIButton*)sender withevent: event
{

    //check to see if a note already exists in array[sender.tag], if it doesn't:
    if (currentvoice==0 && _bass[sender.tag]!=[NSNumber numberWithInt:0]) return;
    else if (currentvoice==1 && _tenor[sender.tag]!=[NSNumber numberWithInt:0]) return;
    else if (currentvoice==2 && _alto[sender.tag]!=[NSNumber numberWithInt:0]) return;
    else if (currentvoice==3 && _soprano[sender.tag]!=[NSNumber numberWithInt:0]) return;
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    CGFloat x = 10;
    CGFloat y = touchPoint.y;
    y = y-85;
    y =detectValue(y);
    if (y == 0)return;
    Note *note = [[Note alloc] initWithFrame:CGRectMake(x, y+3, 30, 100)];
        UIImage *img = [UIImage imageNamed:@"q_note.png"];
    
    //check to see if sharp or flat is selected then set proper image

    [note setImage:img forState:UIControlStateNormal];
    
    [note addTarget:self action: @selector(notePressed:withevent:) forControlEvents:UIControlEventTouchUpInside];
    note.index = sender.tag;
    note.voice = currentvoice;
    [sender addSubview:note];
    int val = 0;
    if (y<=540 && y>=300){
        val = y/-10;
        val += 54;
        val = ((3*val)/2) + 2;
    }
    else if (y<=170){
        val = (y+130)/-10;
        val += 54;
        val =  ((3*val)/2)+ 2;
    }
    
    if (currentvoice==0) _bass[sender.tag]=[NSNumber numberWithInt:val];
    else if (currentvoice==1) _tenor[sender.tag]=[NSNumber numberWithInt:val];
    else if (currentvoice==2) _alto[sender.tag]=[NSNumber numberWithInt:val];
    else if (currentvoice==3) _soprano[sender.tag]=[NSNumber numberWithInt:val];
    
}
int detectValue(int y)
{
    if (y<=-38)y=-50;//G
    else if ((y>=-37)&&(y<=-23))y=-30;//F
    else if ((y>=-22)&&(y<=2))y=-10;  //E
    else if ((y>=3)&&(y<=17))y=10;    //D
    else if ((y>=18)&&(y<=42))y=30;   //C
    else if ((y>=43)&&(y<=57))y=50;   //B
    else if ((y>=58)&&(y<=82))y=70;   //A
    else if ((y>=83)&&(y<=97))y=90;   //G
    else if ((y>=98)&&(y<=122))y=110; //F
    else if ((y>=123)&&(y<=137))y=130;//E
    else if ((y>=138)&&(y<=162))y=150;//D
    else if ((y>=163)&&(y<=177))y=170;//C
    
    else if ((y>=178)&&(y<=293))return 0;
    
    else if ((y>=293)&&(y<=317))y=300;//C
    else if ((y>=318)&&(y<=332))y=320;//B
    else if ((y>=333)&&(y<=358))y=340;//A
    else if ((y>=358)&&(y<=372))y=360;//G
    else if ((y>=373)&&(y<=397))y=380;//F
    else if ((y>=398)&&(y<=412))y=400;//E
    else if ((y>=413)&&(y<=427))y=420;//D
    else if ((y>=428)&&(y<=452))y=440;//C
    else if ((y>=453)&&(y<=467))y=460;//B
    else if ((y>=468)&&(y<=492))y=480;//A 11
    else if ((y>=493)&&(y<=507))y=500;//G 8
    else if ((y>=508)&&(y<=532))y=520;//F 5
    else if (y>=533)y=540;//E  2
    
    return y;

    
}

-(void)notePressed: (Note*)sender withevent: event
{
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
       
    if( [sender pointInside:touchPoint withEvent:event] == true){
        if (sender.voice==0) _bass[sender.index]=[NSNumber numberWithInt:0];
        else if (sender.voice==1) _tenor[sender.index]=[NSNumber numberWithInt:0];
        else if (sender.voice==2) _alto[sender.index]=[NSNumber numberWithInt:0];
        else if (sender.voice==3) _soprano[sender.index]=[NSNumber numberWithInt:0];
        [sender removeFromSuperview];
    }
 

}

-(void)clearStaff
{

        for(UIButton *subview in [self subviews]) {
            for(Note *notes in [subview subviews]) {
                [_soprano replaceObjectAtIndex:notes.index withObject:[NSNumber numberWithInt:0]];
                [_alto replaceObjectAtIndex:notes.index withObject:[NSNumber numberWithInt:0]];
                [_tenor replaceObjectAtIndex:notes.index withObject:[NSNumber numberWithInt:0]];
                [_bass replaceObjectAtIndex:notes.index withObject:[NSNumber numberWithInt:0]];
                [notes removeFromSuperview];
            }
            [[subview layer] setBorderWidth:0.0f];
        }

}
-(void)checkStaff
{
    for (int i=0; i<kNumImages;i++)
    {
        UIButton *beat = (UIButton *)[self viewWithTag:i];
        
        if (_soprano[i]==[NSNumber numberWithInt:0]&&_alto[i]==[NSNumber numberWithInt:0]&& _tenor[i]==[NSNumber numberWithInt:0]&&_bass[i]==[NSNumber numberWithInt:0]){
            
            [[beat layer] setBorderWidth:0.0f];
        } //do nothing! not incorrect
            
        else if (_soprano[i]==[NSNumber numberWithInt:0]||_alto[i]==[NSNumber numberWithInt:0]||_tenor[i]==[NSNumber numberWithInt:0]||_bass[i]==[NSNumber numberWithInt:0]){
            
            [[beat layer] setBorderWidth:1.0f];
            [[beat layer] setBorderColor:[UIColor redColor].CGColor];
            //[[beat subviews]makeObjectsPerformSelector:@selector(badNote)];
        }
        else{
            [[beat layer] setBorderWidth:0.0f];
            //[[beat subviews]makeObjectsPerformSelector:@selector(goodNote)];
        }
        
    }
}
/*
-(void)badNote:(id)note{

    UIImage *img = [UIImage imageNamed:@"red_q_note.png"];
    [note setImage:img forState:normal];
}
-(void)goodNote:(id)note{
    UIImage *img = [UIImage imageNamed:@"q_note.png"];
    [note setImage:img forState:normal];
}*/
@end

