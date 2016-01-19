//
//  Comment.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(id)init:(NSString*)cmtId title:(NSString*)title date:(NSDate*)date comment:(NSString*)comment grtId:(NSString*)grtId createdBy:(User*)createdBy{
    self = [super init];
    if (self){
        _cmtId = cmtId;
        _title = title;
        _date = date;
        _comment = comment;
        _grtId = grtId;
        _createdBy = createdBy;
    }
    return self;
}

@end
