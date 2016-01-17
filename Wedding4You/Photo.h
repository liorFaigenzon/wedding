//
//  Photos.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Photo : NSObject

@property NSString* ptoId;
@property NSString* title;
@property NSDate* date;
@property NSString* descriptionPt;
@property NSString* imageName;
@property NSString* wdId;
@property NSString* usId;

-(id)init:(NSString*)ptoId title:(NSString*)title date:(NSDate*)date descriptionPt:(NSString*)descriptionPt imageName:(NSString*)imageName wdId:(NSString*)wdId usId:(NSString*)usId;

@end
