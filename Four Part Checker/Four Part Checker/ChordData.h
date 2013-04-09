//
//  ChordData.h
//  Four Part Checker
//
//  Created by Spencer Meldrum on 4/4/13.
//  Copyright (c) 2013 Spencer Meldrum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChordData : NSObject
@property int soprano;
@property int alto;
@property int tenor;
@property int bass;
-(void)setNote:(int)note withLine:(int)line;
@end
