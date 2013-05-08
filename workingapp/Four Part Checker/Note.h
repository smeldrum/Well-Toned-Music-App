//
//  Note.h
//  Four Part Checker
//
//  Created by Zoe Sobin on 4/20/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Note: UIButton
@property (nonatomic, assign) UIEdgeInsets touchcircle;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) int voice;
@property BOOL sharp;
@property BOOL flat;
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event upstem:(BOOL)upstem;
@end
