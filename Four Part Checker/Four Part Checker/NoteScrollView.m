//
//  NoteScrollView.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/2/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "NoteScrollView.h"


@implementation NoteScrollView

@synthesize scrollingStaff;


const CGFloat kScrollObjHeight  = 335;
const CGFloat kScrollObjWidth   = 99;
const NSUInteger kNumImages     = 5;


- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = [scrollingStaff subviews];
    
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
    [scrollingStaff setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [scrollingStaff bounds].size.height)];
}

- (void)viewDidLoad
{
    self= [[UIScrollView alloc] initWithFrame: CGRectMake(100, 100, kScrollObjWidth*kNumImages, kScrollObjHeight*kNumImages)];
    [self addSubview:scrollingStaff];
    // 1. setup the scrollview for multiple images and add it to the view controller
    //
    // note: the following can be done in Interface Builder, but we show this in code for clarity
    [scrollingStaff setBackgroundColor:[UIColor blackColor]];
    [scrollingStaff setCanCancelContentTouches:NO];
    scrollingStaff.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollingStaff.clipsToBounds = YES;        // default is NO, we want to restrict drawing within our scrollview
    scrollingStaff.scrollEnabled = YES;
    
    // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
    // if you want free-flowing scroll, don't set this property.
    scrollingStaff.pagingEnabled = YES;
    
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
        [scrollingStaff addSubview:imageView];
        
    }
    
    [self layoutScrollImages];  // now place the photos in serial layout within the scrollview
    
}

@end
