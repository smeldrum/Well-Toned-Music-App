//
//  Note.m
//  Four Part Checker
//
//  Created by Zoe Sobin on 4/20/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "Note.h"

@implementation Note
@synthesize touchcircle = _touchcircle;
@synthesize index;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        _touchcircle.left = 0;

        _touchcircle.right = 0;


    }
    return self;
}



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event upstem:(BOOL)upstem;
{
    if(upstem == true){
        _touchcircle.top = 73;
        _touchcircle.bottom = 0;
    }
    else{
        _touchcircle.top = 0;
        _touchcircle.bottom = 73;
    }
    CGRect modifiedHitBox = UIEdgeInsetsInsetRect([self bounds], _touchcircle);
    return CGRectContainsPoint(modifiedHitBox, point);

}

@end
