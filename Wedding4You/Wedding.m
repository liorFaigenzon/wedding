//
//  Wedding.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "Wedding.h"

@implementation Wedding

-(id)init: (NSString*)wdId usCouple:(User*)couple date:(NSDate*)date imageName:(NSString*)imageName {
    self = [super init];
    if (self) {
        _wdId = wdId;
        _usCouple = couple;
        _date = date;
        _imageName = imageName;
    }
    return self;
}

@end
