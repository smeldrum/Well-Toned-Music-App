//
//  NoteData.m
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/4/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import "StaffData.h"
#import "ChordData.h"
@implementation StaffData
    
@synthesize noteArray;

-(id)init{
    self.noteArray = [[NSMutableArray alloc] init];
    int i;
    for(i = 0; i<50; i++){
        ChordData * chord = [[ChordData alloc]init];
        self.noteArray[i] = chord;
    }
    return self;
}

-(void)changeChordNote:(int)note withLine:(int)line withIndex:(int)chord{
    [noteArray[chord] setNote:note withLine:line];
}

    



@end
