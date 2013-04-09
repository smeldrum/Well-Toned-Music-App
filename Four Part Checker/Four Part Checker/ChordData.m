//
//  ChordData.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/4/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "ChordData.h"

@implementation ChordData
@synthesize soprano;
@synthesize alto;
@synthesize tenor;
@synthesize bass;
-(id)init {
    self = [ChordData alloc];
    soprano = 0;
    alto = 0;
    tenor = 0;
    bass = 0;
    return self;
}
-(void)setNote:(int)note withLine:(int)line {
    if(line==0){
        bass = note;
    } else if(line==1){
        tenor = note;
    } else if(line==2){
        alto = note;
    } else if(line==3){
        soprano = note;
    }
}
@end
