//
//  Photos.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(id)init:(NSString*)ptoId title:(NSString*)title date:(NSDate*)date descriptionPt:(NSString*)descriptionPt imageName:(NSString*)imageName{
    self = [super init];
    if (self){
        _ptoId = ptoId;
        _title = title;
        _date = date;
        _descriptionPt = descriptionPt;
        _imageName = imageName;
    }
    return self;
}

@end
