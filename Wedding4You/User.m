//
//  User.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "User.h"

@implementation User

-(id)init: (NSString*)usId fname:(NSString*)fName lName:(NSString*)lName phone:(NSString*)phone {
    self = [super init];
    if (self) {
        _usId = usId;
        _fName = fName;
        _lName = lName;
        _phone = phone;
    }
    return self;
}

@end
