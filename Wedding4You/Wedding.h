//
//  Wedding.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Wedding : NSObject

@property NSString* wdId;
@property User* usCouple;
@property NSDate* date;
@property NSString* imageName;

-(id)init: (NSString*)wdId usCouple:(User*)couple date:(NSDate*)date imageName:(NSString*)imageName;

@end
