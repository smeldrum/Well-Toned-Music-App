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

const CGFloat kScrollObjHeight  = 650;
const CGFloat kScrollObjWidth   = 50;
const NSUInteger kNumImages     = 1000;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCanCancelContentTouches:NO];
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.clipsToBounds = YES;
        self.scrollEnabled = YES;
        self.pagingEnabled = YES;
        
        // add invisible buttons to the scroll view
        NSUInteger i;
        for (i = 1; i <= kNumImages; i++)
        {
            UIButton *beat = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScrollObjWidth, kScrollObjHeight)];
            [beat addTarget:self action: @selector(addNote:withevent:) forControlEvents:UIControlEventTouchUpInside];
            // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
            beat.tag = i;  // tag our images for later use when we place them in serial fashion
 
            [self addSubview:beat];
<<<<<<< HEAD
=======
            
>>>>>>> 0f1a4dc30969e4c54cae0fb2119143761e3acb36
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
        if ([view isKindOfClass:[UIButton class]] && view.tag > 0)
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

    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    CGFloat x = 10;
    CGFloat y = touchPoint.y;
    y = y-85;
    y = detectValue(y);
    
    if (y == 0)return;
    Note *note = [[Note alloc] initWithFrame:CGRectMake(x, y, 30, 100)];
        UIImage *img = [UIImage imageNamed:@"q_note.png"];
    
    //check to see if sharp or flat is selected then set proper image

    [note setImage:img forState:UIControlStateNormal];
    
    [note addTarget:self action: @selector(notePressed:withevent:atindex:) forControlEvents:UIControlEventTouchUpInside];
    note.index = sender.tag;
    [sender addSubview:note];

    //add to array at array[sender.tag][value];
    
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
    else if ((y>=468)&&(y<=492))y=480;//A
    else if ((y>=493)&&(y<=507))y=500;//G
    else if (y>=508)y=520;            //F
    return y + 3 ;

    
}
<<<<<<< HEAD
-(void)notePressed: (Note*)sender withevent: event atindex: (int)index
{
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];

=======
*/
-(void)addNote: (UIButton*)sender withevent: event
{
    
    //check to see if a note already exists in array[sender.tag], if it doesn't:
    
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    CGFloat x = sender.tag * kScrollObjWidth;
    x = x-kScrollObjWidth ;
    CGFloat y = touchPoint.y;
    y = y-85;
    y = detectValue(y);
    
    Note *note = [[Note alloc] initWithFrame:CGRectMake(x, y, 30, 100)];
        UIImage *img = [UIImage imageNamed:@"q_note.png"];
    [note setImage:img forState:UIControlStateNormal];
    
    [note addTarget:self action: @selector(notePressed:withevent:atindex:) forControlEvents:UIControlEventTouchUpInside];
    note.index = sender.tag;
    [self addSubview:note ];

    //add to array at array[sender.tag][value];
    
}
int detectValue(int y)
{
    if (y<=-38)y=-50;
    else if ((y>=-37)&&(y<=-23))y=-30;
    else if ((y>=-22)&&(y<=2))y=-10;
    else if ((y>=3)&&(y<=17))y=10;
    else if ((y>=18)&&(y<=42))y=30;
    else if ((y>=43)&&(y<=57))y=50;
    else if ((y>=58)&&(y<=82))y=70;
    else if ((y>=83)&&(y<=97))y=90;
    else if ((y>=98)&&(y<=122))y=110;
    else if ((y>=123)&&(y<=137))y=130;
    else if ((y>=138)&&(y<=162))y=150;
    return y + 3 ;

    
}
-(void)notePressed: (Note*)sender withevent: event atindex: (int)index
{
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];

>>>>>>> 0f1a4dc30969e4c54cae0fb2119143761e3acb36
    if( [sender pointInside:touchPoint withEvent:event] == true){
        //delete from array at sender.index
        [sender removeFromSuperview];
    }
}
<<<<<<< HEAD
-(void)clearStaff
{
    for (int i=1; i<kNumImages;i++)
    {
        UIButton *beat = (UIButton *)[self viewWithTag:i];
        [[beat subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}
=======
>>>>>>> 0f1a4dc30969e4c54cae0fb2119143761e3acb36
@end

