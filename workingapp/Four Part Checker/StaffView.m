//
//  StaffView.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "StaffView.h"
#import "Note.h"
#import "HarmonyPlayer.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@implementation StaffView
@synthesize currentvoice;
@synthesize leadingTone;
@synthesize tonic;
@synthesize currentInversion;
@synthesize keySigNum;

const CGFloat kScrollObjHeight  = 650;
const CGFloat kScrollObjWidth   = 50;
const NSUInteger kNumImages     = 200;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sharp = false;
        _musicplayer = [HarmonyPlayer alloc];
 
        _soprano = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        _alto = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        _tenor = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        _bass = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        _inversion = [[NSMutableArray alloc] initWithCapacity:kNumImages];
        for (int i = 0; i < kNumImages; i++){
            [_soprano addObject:[NSNumber numberWithInt:0]];
            [_alto addObject:[NSNumber numberWithInt:0]];
            [_tenor addObject:[NSNumber numberWithInt:0]];
            [_bass addObject:[NSNumber numberWithInt:0]];
            [_inversion addObject:[NSNumber numberWithInt:0]];
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
        [self initKeySigLists];
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
    Note *note;
    if (currentvoice==3 ||currentvoice==1){ //stem up!
        note = [[Note alloc] initWithFrame:CGRectMake(x, y+3, 30, 100)];
        UIImage *img;
        if (_sharp == TRUE){
            img = [UIImage imageNamed:@"q_note_sharp.png"];
            note.sharp = true;
            note.flat = false;
        }
        else if (_flat == TRUE){
            img = [UIImage imageNamed:@"q_note_flat.png"];
            note.flat = true;
            note.sharp = false;
        }
        else{
            img = [UIImage imageNamed:@"q_note.png"];
            note.sharp = false;
            note.flat = false;
        }
            //check to see if sharp or flat is selected then set proper image

        [note setImage:img forState:UIControlStateNormal];
        [note addTarget:self action: @selector(notePressed:withevent:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{ //stem dowwwwn
        note = [[Note alloc] initWithFrame:CGRectMake(x, y+76, 30, 100)];
        UIImage *img;
        if (_sharp == TRUE){
            img = [UIImage imageNamed:@"down_q_note_sharp.png"];
            note.sharp = true;
            note.flat = false;
        }
        else if (_flat == TRUE){
            img = [UIImage imageNamed:@"down_q_note_flat.png"];
            note.flat = true;
            note.sharp = false;
        }
        else{
            img = [UIImage imageNamed:@"down_q_note.png"];
            note.sharp = false;
            note.flat = false;
        }
        //check to see if sharp or flat is selected then set proper image
        
        [note setImage:img forState:UIControlStateNormal];
        [note addTarget:self action: @selector(downnotePressed:withevent:) forControlEvents:UIControlEventTouchUpInside];
        
    }
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
    if(keySigNum>=8){
        int modVal = val%21;
        if(modVal==0) modVal = 21;
        int length = keySigNum -7;
        for(int i=0; i<length; i++){
            if(modVal==[_flatList[i] intValue]){
                val--;
            }
        }
    } else if(keySigNum>0){
        int modVal = val%21;
        if(modVal==0) modVal = 21;
        int length = keySigNum;
        for(int i=0; i<length; i++){
            if(modVal==[_sharpList[i] intValue]){
                val++;
            }
        }
    }
    //NSLog(@"%d", val);
    if (currentvoice==0) _bass[sender.tag]=[NSNumber numberWithInt:val];
    else if (currentvoice==1) _tenor[sender.tag]=[NSNumber numberWithInt:val];
    else if (currentvoice==2) _alto[sender.tag]=[NSNumber numberWithInt:val];
    else if (currentvoice==3) _soprano[sender.tag]=[NSNumber numberWithInt:val];
    _inversion[sender.tag] = [NSNumber numberWithInt:currentInversion];
    
    _sharp = false;
    _flat = false;
    
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


-(void)downnotePressed: (Note*)sender withevent: event
{
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    
    if( [sender pointInside:touchPoint withEvent:event upstem:false] == true){
        if (sender.voice==0) _bass[sender.index]=[NSNumber numberWithInt:0];
        else if (sender.voice==1) _tenor[sender.index]=[NSNumber numberWithInt:0];
        else if (sender.voice==2) _alto[sender.index]=[NSNumber numberWithInt:0];
        else if (sender.voice==3) _soprano[sender.index]=[NSNumber numberWithInt:0];
        [sender removeFromSuperview];
    }
    
    
}
-(void)notePressed: (Note*)sender withevent: event
{
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
       
    if( [sender pointInside:touchPoint withEvent:event upstem:true] == true){
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
    [self errorChecking];
}

-(void)errorChecking{
    for(int i=1; i<kNumImages; i++){
        if (_soprano[i]!=[NSNumber numberWithInt:0] && _alto[i]!=[NSNumber numberWithInt:0] && _tenor[i]!=[NSNumber numberWithInt:0]&&_bass[i]!=[NSNumber numberWithInt:0] && _soprano[i-1]!=[NSNumber numberWithInt:0] && _alto[i-1]!=[NSNumber numberWithInt:0] && _tenor[i-1]!=[NSNumber numberWithInt:0]&&_bass[i-1]!=[NSNumber numberWithInt:0]){
            [self checkFifthsOctaves:i];
            [self checkLTs:i];
            
        }
    }
}

-(void)checkFifthsOctaves: (int)i{
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

-(void)checkLTs: (int)i {
    if([self hasBadLT:_soprano[i] withNote2:_soprano[i-1]]){
        [self turnRed:3 atIndex:i];
        [self turnRed:3 atIndex:i-1];
    }
        if([self hasBadLT:_alto[i] withNote2:_alto[i-1]]){
        [self turnRed:2 atIndex:i];
        [self turnRed:2 atIndex:i-1];
    }
        if([self hasBadLT:_tenor[i] withNote2:_tenor[i-1]]){
        [self turnRed:1 atIndex:i];
        [self turnRed:1 atIndex:i-1];
    }
}
-(void)allBlack
{
    for(UIButton *subview in [self subviews]) {
        for(Note *notes in [subview subviews]) {
            UIImage *img;
            if (notes.voice ==3 ||notes.voice==1){
                if (notes.sharp==true) img = [UIImage imageNamed:@"q_note_sharp.png"];
                else if (notes.flat==true) img = [UIImage imageNamed:@"q_note_flat.png"];
                else img = [UIImage imageNamed:@"q_note.png"];
            }
            else{
                if (notes.sharp==true) img = [UIImage imageNamed:@"down_q_note_sharp.png"];
                else if (notes.flat==true) img = [UIImage imageNamed:@"down_q_note_flat.png"];
                else img = [UIImage imageNamed:@"down_q_note.png"];
            }
            [notes setImage:img forState:normal];
            
        }
    }
}
-(void)turnRed: (int) voice atIndex: (int)index
{
    for(UIButton *subview in [self subviews]) {
        for(Note *notes in [subview subviews]) {
            if (notes.index == index && notes.voice == voice){
                UIImage *img;
                if (notes.voice ==3 ||notes.voice==1){
                    if (notes.sharp==true) img = [UIImage imageNamed:@"red_q_note_sharp.png"];
                    else if (notes.flat==true) img = [UIImage imageNamed:@"red_q_note_flat.png"];
                    else img = [UIImage imageNamed:@"red_q_note.png"];
                }
                else{
                    if (notes.sharp==true) img = [UIImage imageNamed:@"red_down_q_note_sharp.png"];
                    else if (notes.flat==true) img = [UIImage imageNamed:@"red_down_q_note_flat.png"];
                    else img = [UIImage imageNamed:@"red_down_q_note.png"];
                }
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
    int h2 = higher2;
    int l2 = lower2;
    if(h2 %21 == 0) h2 = 21;
    else h2 = h2 %21;
    if(l2 %21 == 0) l2 = 21;
    else l2 = l2 %21;
    if(h2<l2) h2 = h2 +21;
    int h1 = higher1;
    int l1 = lower1;
    if(h1 %21 == 0) h1 = 21;
    else h1 = h1 %21;
    if(l1 %21 == 0) l1 = 21;
    else l1 = l1 %21;
    if(h1<l1) h1 = h1 +21;
    if(h1==l1){
        if(h2==l2 && higher2!=higher1 && lower2!=lower1){
            return true;
        }
    } else if((h1-l1)%12==0){
        if((h2-l2)%12==0 && higher2!=higher1 && lower2!=lower1){
            return true;
        }
    }
    return false;
}
-(BOOL)hasBadLT:(NSNumber*)note1 withNote2:(NSNumber*)note2{
    int second = [note1 intValue];
    int first = [note2 intValue];
    if(first %21 ==0)first = 21;
    else first = first % 21;
    if(second %21 ==0)second = 21;
    else second = second % 21;
    if(first == leadingTone){
        if(second !=tonic){
            //NSLog(@"%d, %d", first, second);
            return true;
        }
    }
    return false;
}

-(void)selectSharp
{
    _flat = FALSE;
    _sharp = TRUE;
}
-(void)selectFlat
{
    _flat = TRUE;
    _sharp = FALSE;
}
-(void)playStaff
{
    [_musicplayer play: _soprano a:_alto a:_tenor a:_bass];
}
-(void) initKeySigLists{
    NSNumber * first = [NSNumber numberWithInt:5];
    NSNumber * second = [NSNumber numberWithInt:17];
    NSNumber * third = [NSNumber numberWithInt:8];
    NSNumber * fourth = [NSNumber numberWithInt:20];
    NSNumber * fifth = [NSNumber numberWithInt:11];
    NSNumber * sixth = [NSNumber numberWithInt:2];
    NSNumber * seventh = [NSNumber numberWithInt:14];
    _sharpList = [NSArray arrayWithObjects:first, second, third, fourth, fifth, sixth, seventh, nil];
    first = [NSNumber numberWithInt:14];
    second = [NSNumber numberWithInt:2];
    third = [NSNumber numberWithInt:11];
    fourth = [NSNumber numberWithInt:20];
    fifth = [NSNumber numberWithInt:8];
    sixth = [NSNumber numberWithInt:17];
    seventh = [NSNumber numberWithInt:5];
    _flatList = [NSArray arrayWithObjects:first, second, third, fourth, fifth, sixth, seventh, nil];
    keySigNum =0;
    
}

@end

