//
//  Comment.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property NSString* cmtId;
@property NSString* title;
@property NSDate* date;
@property NSString* comment;
@property NSString* grtId;

-(id)init:(NSString*)cmtId title:(NSString*)title date:(NSDate*)date comment:(NSString*)comment grtId:(NSString*)grtId;

@end
