//
//  StaffView.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "StaffView.h"

@implementation StaffView

const CGFloat kScrollObjHeight  = 335;
const CGFloat kScrollObjWidth   = 99;
const NSUInteger kNumImages     = 5;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
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
            NSString *imageName = [NSString stringWithFormat:@"sloth.png"];
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            
            // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
            CGRect rect = imageView.frame;
            rect.size.height = kScrollObjHeight;
            rect.size.width = kScrollObjWidth;
            imageView.frame = rect;
            imageView.tag = i;  // tag our images for later use when we place them in serial fashion
            [self addSubview:imageView];
            
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
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
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

@end
