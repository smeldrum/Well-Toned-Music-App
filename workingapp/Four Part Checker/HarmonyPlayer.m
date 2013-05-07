//
//  HarmonyPlayer.m
//  Four Part Checker
//
//  Created by Zoe Sobin on 5/7/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "HarmonyPlayer.h"



@implementation HarmonyPlayer
@synthesize sop;
@synthesize alt;
@synthesize ten;
@synthesize bas;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)play: (NSMutableArray*)soprano a:(NSMutableArray*)alto a:(NSMutableArray*)tenor a:(NSMutableArray*)bass
{
    NSString * type = @"aiff";
    
    
    for (int i=0; i<1;i++)
    {
        if (soprano[i]==[NSNumber numberWithInt:0]&&alto[i]==[NSNumber numberWithInt:0]&&tenor[i]==[NSNumber numberWithInt:0]&&bass[i]==[NSNumber numberWithInt:0])break;
        
        NSLog(@"SUUUUP");
    
        NSString * s = [self getNote:soprano[i]];
        NSString * a = [self getNote:alto[i]];
        NSString * t = [self getNote:tenor[i]];
        NSString * b = [self getNote:bass[i]];

        
        sop = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:s ofType:type]] error:NULL];
        alt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:a ofType:type]] error:NULL];
        ten = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:t ofType:type]] error:NULL];
        bas = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:b ofType:type]] error:NULL];
        
        [sop play];
        [alt play];
        [ten play];
        [bas play];
    
     }
    
}

-(NSString*)getNote: (NSNumber*)num{
   
    NSString * string = @"Piano.ff.Eb2";
    return string;
    
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
