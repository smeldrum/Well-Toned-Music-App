//
//  AppDelegate.m
//  MusicApp
//
//  Created by Zoe Sobin on 3/11/13.
//  Copyright (c) 2013 Zoe Sobin. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidFinishLaunching:(UIApplication *)application{
    NSUInteger x,y;
    CGRect viewRectangle = CGRectMake(150, 36, 695, 316);
    UIView *indivNoteView;
    float numOfCellsWidth = 4;
    float numOfCellsHeight = 30;
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    for(x=0; x < numOfCellsWidth; ++x){
        
        for(y=0; y< numOfCellsHeight; ++y){
           indivNoteView = [[NoteView alloc] initWithFrame: [CGRectMake(viewRectangle.origin.x + x * viewRectangle.size.width / numOfCellsWidth, viewRectangle.origin.y + y * viewRectangle.size.height / numOfCellsHeight, x * viewRectangle.size.width / numOfCellsWidth, y * viewRectangle.size.height / numOfCellsHeight)]];
            
            [indivNoteView setMultipleTouchEnabled:NO];
            
            [_window addSubview:indivNoteView];
            
        }
    }
    
}

-(void)setup
{
    
}

@end
