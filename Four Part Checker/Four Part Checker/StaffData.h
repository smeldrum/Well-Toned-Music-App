//
//  NoteData.h
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/4/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface StaffData : NSObject

-(void)changeChordNote:(int)note withLine:(int)line withIndex:(int)chord;
@property NSMutableArray * noteArray;
@end
