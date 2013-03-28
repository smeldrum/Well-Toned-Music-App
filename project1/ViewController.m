//
//  ViewController.m
//  project1
//
//  Created by Zoe Sobin on 3/14/13.
//  Copyright (c) 2013 Zoe Sobin. All rights reserved.
//



#import "ViewController.h"

@implementation MyViewController

@synthesize scrollView;

const CGFloat kScrollObjHeight  = 335;
const CGFloat kScrollObjWidth   = 99;
const NSUInteger kNumImages     = 5;


- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = [scrollView subviews];
    
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
    [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [scrollView bounds].size.height)];
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    
    // 1. setup the scrollview for multiple images and add it to the view controller
    //
    // note: the following can be done in Interface Builder, but we show this in code for clarity
    [scrollView setBackgroundColor:[UIColor blackColor]];
    [scrollView setCanCancelContentTouches:NO];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.clipsToBounds = YES;        // default is NO, we want to restrict drawing within our scrollview
    scrollView.scrollEnabled = YES;
    
    // pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
    // if you want free-flowing scroll, don't set this property.
    scrollView.pagingEnabled = YES;
    
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
        [scrollView addSubview:imageView];

    }
    
    [self layoutScrollImages];  // now place the photos in serial layout within the scrollview

}


- (void)didReceiveMemoryWarning
{
    // invoke super's implementation to do the Right Thing, but also release the input controller since we can do that
    // In practice this is unlikely to be used in this application, and it would be of little benefit,
    // but the principle is the important thing.
    //
    [super didReceiveMemoryWarning];
}

@end

/*
@implementation ViewController
@synthesize scrollView;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
    tempScrollView.contentSize=CGSizeMake(335,99*10);
    for (int i = 0; i < 10; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(99 * i, 0, 99,335)];
        imageView.image = [UIImage imageNamed:@"sloth.png"];
        [tempScrollView addSubview:imageView];
    }
    // do any further configuration to the scroll view
    // add a view, or views, as a subview of the scroll view.
    UIView *baseView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view =baseView;
    // release scrollView as self.view retains it
    [self.view addSubview:scrollView];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
*/