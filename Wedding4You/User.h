//
//  User.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSString* usId;
@property NSString* fName;
@property NSString* lName;
@property NSString* phone;

-(id)init: (NSString*)fName lName:(NSString*)lName phone:(NSString*)phone;

@end
