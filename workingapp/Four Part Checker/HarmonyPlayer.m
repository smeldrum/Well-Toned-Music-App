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
@synthesize s;
@synthesize a;
@synthesize t;
@synthesize b;
@synthesize timer;
@synthesize stoptimer;
@synthesize i;

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
    i = 0;
    _soprano = soprano;
    _alto = alto;
    _tenor = tenor;
    _bass = bass;
    
    [self getBeat];
    
}
-(void)getBeat {
        NSString * type = @"aiff";
    
        if (_soprano[i]==[NSNumber numberWithInt:0]&&_alto[i]==[NSNumber numberWithInt:0]&&_tenor[i]==[NSNumber numberWithInt:0]&&_bass[i]==[NSNumber numberWithInt:0])return;
        
        s = [self getNote:_soprano[i]];
        a = [self getNote:_alto[i]];
        t = [self getNote:_tenor[i]];
        b = [self getNote:_bass[i]];

        if (s!=NULL)sop = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:s ofType:type]] error:NULL];
        if (a!=NULL)alt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:a ofType:type]] error:NULL];
        if (t!=NULL)ten = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:t ofType:type]] error:NULL];
        if (b!=NULL)bas = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:b ofType:type]] error:NULL];
        
        if (s!=NULL)[sop prepareToPlay];
        if (a!=NULL)[alt prepareToPlay];
        if (t!=NULL)[ten prepareToPlay];
        if (b!=NULL)[bas prepareToPlay];
        [self playBeat];
    
}
-(void)playBeat{
    NSTimeInterval shortStartDelay = 0.5;          
    NSTimeInterval now = sop.deviceCurrentTime;
    
    if (s!=NULL)[sop playAtTime:now+shortStartDelay];
    if (a!=NULL)[alt playAtTime:now+shortStartDelay];
    if (t!=NULL)[ten playAtTime:now+shortStartDelay];
    if (b!=NULL)[bas playAtTime:now+shortStartDelay];
    stoptimer = [NSTimer scheduledTimerWithTimeInterval: 2.0 target:self selector:@selector(stopBeat) userInfo:nil repeats: NO];
    
}
-(void)stopBeat{
    
    if (s!=NULL)[sop stop];
    if (a!=NULL)[alt stop];
    if (t!=NULL)[ten stop];
    if (b!=NULL)[bas stop];
    i+=1;
    [self getBeat];
    
}

-(NSString*)getNote: (NSNumber*)num{

    
    NSString * string;
    if ([num isEqualToNumber:[NSNumber numberWithInt:0]])string=NULL;
    
    else if ([num isEqualToNumber:[NSNumber numberWithInt:1]])string=@"Piano.ff.Eb2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:2]])string=@"Piano.ff.E2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:3]])string=@"Piano.ff.F2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:4]])string=@"Piano.ff.E2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:5]])string=@"Piano.ff.F2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:6]])string=@"Piano.ff.Gb2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:7]])string=@"Piano.ff.Gb2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:8]])string=@"Piano.ff.G2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:9]])string=@"Piano.ff.Ab2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:10]])string=@"Piano.ff.Ab2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:11]])string=@"Piano.ff.A2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:12]])string=@"Piano.ff.Bb2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:13]])string=@"Piano.ff.Bb2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:14]])string=@"Piano.ff.B2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:15]])string=@"Piano.ff.C3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:16]])string=@"Piano.ff.B2";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:17]])string=@"Piano.ff.C3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:18]])string=@"Piano.ff.Db3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:19]])string=@"Piano.ff.Db3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:20]])string=@"Piano.ff.D3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:21]])string=@"Piano.ff.Eb3";

    else if ([num isEqualToNumber:[NSNumber numberWithInt:22]])string=@"Piano.ff.Eb3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:23]])string=@"Piano.ff.E3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:24]])string=@"Piano.ff.F3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:25]])string=@"Piano.ff.E3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:26]])string=@"Piano.ff.F3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:27]])string=@"Piano.ff.Gb3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:28]])string=@"Piano.ff.Gb3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:29]])string=@"Piano.ff.G3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:30]])string=@"Piano.ff.Ab3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:31]])string=@"Piano.ff.Ab3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:32]])string=@"Piano.ff.A3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:33]])string=@"Piano.ff.Bb3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:34]])string=@"Piano.ff.Bb3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:35]])string=@"Piano.ff.B3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:36]])string=@"Piano.ff.C4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:37]])string=@"Piano.ff.B3";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:38]])string=@"Piano.ff.C4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:39]])string=@"Piano.ff.Db4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:40]])string=@"Piano.ff.Db4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:41]])string=@"Piano.ff.D4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:42]])string=@"Piano.ff.Eb4";
    
    else if ([num isEqualToNumber:[NSNumber numberWithInt:43]])string=@"Piano.ff.Eb4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:44]])string=@"Piano.ff.E4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:45]])string=@"Piano.ff.F4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:46]])string=@"Piano.ff.E4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:47]])string=@"Piano.ff.F4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:48]])string=@"Piano.ff.Gb4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:49]])string=@"Piano.ff.Gb4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:50]])string=@"Piano.ff.G4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:51]])string=@"Piano.ff.Ab4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:52]])string=@"Piano.ff.Ab4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:53]])string=@"Piano.ff.A4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:54]])string=@"Piano.ff.Bb4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:55]])string=@"Piano.ff.Bb4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:56]])string=@"Piano.ff.B4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:57]])string=@"Piano.ff.C5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:58]])string=@"Piano.ff.B4";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:59]])string=@"Piano.ff.C5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:60]])string=@"Piano.ff.Db5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:61]])string=@"Piano.ff.Db5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:62]])string=@"Piano.ff.D5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:63]])string=@"Piano.ff.Eb5";

    else if ([num isEqualToNumber:[NSNumber numberWithInt:64]])string=@"Piano.ff.Eb5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:65]])string=@"Piano.ff.E5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:66]])string=@"Piano.ff.F5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:67]])string=@"Piano.ff.E5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:68]])string=@"Piano.ff.F5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:69]])string=@"Piano.ff.Gb5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:70]])string=@"Piano.ff.Gb5";
    else if ([num isEqualToNumber:[NSNumber numberWithInt:71]])string=@"Piano.ff.G5";
    
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
