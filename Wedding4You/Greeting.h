//
//  Greeting.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Greeting : NSObject

@property NSString* grtId;
@property NSString* title;
@property NSDate* date;
@property NSString* greeting;
@property NSString* wdId;
@property User* usCreatedBy;

-(id)init:(NSString*)grtId title:(NSString*)title date:(NSDate*)date greeting:(NSString*)greeting wdId:(NSString*)wdId usCreatedBy:(User*)usCreatedBy;

@end
