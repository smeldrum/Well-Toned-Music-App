//
//  staff.m
//  MusicApp
//
//  Created by Zoe Sobin on 3/11/13.
//  Copyright (c) 2013 Zoe Sobin. All rights reserved.
//

#import "staff.h"

@implementation staff
@synthesize theStaff;
-(id)createStaff{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Trend"]];
    imageView.frame = CGRectMake(....) or  imageView.center = CGPointMake(...)
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
