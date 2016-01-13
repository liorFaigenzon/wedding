//
//  Greeting.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "Greeting.h"

@implementation Greeting

-(id)init:(NSString*)grtId title:(NSString*)title date:(NSDate*)date greeting:(NSString*)greeting wdId:(NSString*)wdId usCreatedBy:(User *)usCreatedBy;{
    self = [super init];
    if (self){
        _grtId = grtId;
        _title = title;
        _date = date;
        _greeting = greeting;
        _wdId = wdId;
        _usCreatedBy = usCreatedBy;
    }
    return self;
}

@end
