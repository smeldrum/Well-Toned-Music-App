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
#import <AVFoundation/AVFoundation.h>

@implementation StaffView
@synthesize currentvoice;

const CGFloat kScrollObjHeight  = 650;
const CGFloat kScrollObjWidth   = 50;
const NSUInteger kNumImages     = 200;

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
    [self allBlack];
    for (int i=0; i<kNumImages;i++)
    {
        UIButton *beat = (UIButton *)[self viewWithTag:i];
        
        if (_soprano[i]==[NSNumber numberWithInt:0]&&_alto[i]==[NSNumber numberWithInt:0]&& _tenor[i]==[NSNumber numberWithInt:0]&&_bass[i]==[NSNumber numberWithInt:0]){
            
            [[beat layer] setBorderWidth:0.0f];
        } //do nothing! not incorrect
            
        else if (_soprano[i]==[NSNumber numberWithInt:0]||_alto[i]==[NSNumber numberWithInt:0]||_tenor[i]==[NSNumber numberWithInt:0]||_bass[i]==[NSNumber numberWithInt:0]){
            
            [[beat layer] setBorderWidth:1.0f];
            [[beat layer] setBorderColor:[UIColor redColor].CGColor];
        }
        else{
            [[beat layer] setBorderWidth:0.0f];
        }
        
    }
    [self checkParallelFifthsOctaves];
}
-(void)checkParallelFifthsOctaves{
    for(int i=1; i<kNumImages; i++){
        if (_soprano[i]!=[NSNumber numberWithInt:0] && _alto[i]!=[NSNumber numberWithInt:0] && _tenor[i]!=[NSNumber numberWithInt:0]&&_bass[i]!=[NSNumber numberWithInt:0] && _soprano[i-1]!=[NSNumber numberWithInt:0] && _alto[i-1]!=[NSNumber numberWithInt:0] && _tenor[i-1]!=[NSNumber numberWithInt:0]&&_bass[i-1]!=[NSNumber numberWithInt:0]){
            if([self hasParallels:_soprano[i] withNote2:_soprano[i-1] withVoice2: _alto[i] withNote4: _alto[i-1]]==true){
                [self turnRed:3 atIndex:i];
                [self turnRed:2 atIndex:i];
                [self turnRed:3 atIndex:i-1];
                [self turnRed:2 atIndex:i-1];
            }
            if([self hasParallels:_soprano[i] withNote2:_soprano[i-1] withVoice2: _tenor[i] withNote4: _tenor[i-1]]==true){
                [self turnRed:3 atIndex:i];
                [self turnRed:1 atIndex:i];
                [self turnRed:3 atIndex:i-1];
                [self turnRed:1 atIndex:i-1];
            }
            if([self hasParallels:_soprano[i] withNote2:_soprano[i-1] withVoice2: _bass[i] withNote4: _bass[i-1]]==true){
                [self turnRed:3 atIndex:i];
                [self turnRed:0 atIndex:i];
                [self turnRed:3 atIndex:i-1];
                [self turnRed:0 atIndex:i-1];
            }
            if([self hasParallels:_alto[i] withNote2:_alto[i-1] withVoice2: _tenor[i] withNote4: _tenor[i-1]]==true){
                [self turnRed:2 atIndex:i];
                [self turnRed:1 atIndex:i];
                [self turnRed:2 atIndex:i-1];
                [self turnRed:1 atIndex:i-1];
            }
            if([self hasParallels:_alto[i] withNote2:_alto[i-1] withVoice2: _bass[i] withNote4: _bass[i-1]]==true){
                [self turnRed:2 atIndex:i];
                [self turnRed:0 atIndex:i];
                [self turnRed:2 atIndex:i-1];
                [self turnRed:0 atIndex:i-1];
            }
            if([self hasParallels:_tenor[i] withNote2:_tenor[i-1] withVoice2: _bass[i] withNote4: _bass[i-1]]==true){
                [self turnRed:1 atIndex:i];
                [self turnRed:0 atIndex:i];
                [self turnRed:1 atIndex:i-1];
                [self turnRed:0 atIndex:i-1];
            }
        }
    }
}
-(void)allBlack 
{
    for(UIButton *subview in [self subviews]) {
        for(Note *notes in [subview subviews]) {
            UIImage *img = [UIImage imageNamed:@"q_note.png"];
            [notes setImage:img forState:normal];

        }
    }
}
-(void)turnRed: (int) voice atIndex: (int)index
{
    for(UIButton *subview in [self subviews]) {
        for(Note *notes in [subview subviews]) {
            if (notes.index == index && notes.voice == voice){
                UIImage *img = [UIImage imageNamed:@"red_q_note.png"];
                [notes setImage:img forState:normal];
            }
        }
    }
}
-(BOOL)hasParallels:(NSNumber*)note1 withNote2:(NSNumber*)note2 withVoice2:(NSNumber*)note3 withNote4:(NSNumber*)note4{
    int higher1 = [note2 intValue];
    int higher2 = [note1 intValue];
    int lower1 = [note4 intValue];
    int lower2 = [note3 intValue];
    
       NSLog(@"%d, %d, %d, %d", higher1, higher2, lower1, lower2);
    if((higher1-lower1)%21==0){
        if((higher2-lower2)%21==0 && higher2!=higher1){
            return true;
        }
    } else if((higher1-lower1)%12==0){
        if((higher2-lower2)%12==0 &&higher2!=higher1){
            return true;
        }
    }
    return false;
}


-(void)playStaff
{
    NSError *audioError;
    //for (int i=0; i<kNumImages;i++)
    //{
       // if (_soprano[i]==[NSNumber numberWithInt:0]&&_alto[i]==[NSNumber numberWithInt:0]&&_tenor[i]==[NSNumber numberWithInt:0]&&_bass[i]==[NSNumber numberWithInt:0])break;
    NSLog(@"SUUUUP");
  

    
        NSURL *urlS = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@play.mp3",[[NSBundle mainBundle] resourcePath]]];
        AVAudioPlayer *sopranoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlS error:&audioError];

        
      /*  NSURL *urlA = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Four Part Checker/corn.mp3",[[NSBundle mainBundle] resourcePath]]];
        AVAudioPlayer *altoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlS error:&audioError];

        
        NSURL *urlT = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Four Part Checker/corn.mp3",[[NSBundle mainBundle] resourcePath]]];
        AVAudioPlayer *tenorPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlS error:&audioError];
    
        
        NSURL *urlB = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Four Part Checker/corn.mp3",[[NSBundle mainBundle] resourcePath]]];
        AVAudioPlayer *bassPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlS error:&audioError];
        */
        
        [sopranoPlayer play];
       // [altoPlayer play];
        //[tenorPlayer play];
        //[bassPlayer play];
        

        
   // }
    
}

@end

