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
        self.clipsToBounds = YES;        // default is NO, we want to restrict drawing within our scrollview
        self.scrollEnabled = YES;
        
        // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
        // if you want free-flowing scroll, don't set this property.
        self.pagingEnabled = YES;
        
        // load all the images from our bundle and add them to the scroll view
        NSUInteger i;
        for (i = 1; i <= kNumImages; i++)
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
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

    if( [sender pointInside:touchPoint withEvent:event] == true){
        //delete from array at sender.index
        [sender removeFromSuperview];
    }
}
@end

