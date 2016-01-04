//
//  Wedding.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "User.h"

@interface Wedding : NSObject

@property NSString* wdId;
@property User* usCouple;

-(id)init: (NSString*)wdId usCouple:(User*)couple;

@end
