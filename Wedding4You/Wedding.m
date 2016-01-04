//
//  Wedding.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "Wedding.h"

@implementation Wedding

-(id)init: (NSString*)wdId usCouple:(User*)couple {
    self = [super init];
    if (self) {
        _wdId = wdId;
        _usCouple = couple;
    }
    return self;
}

@end
