//
//  Utilities.h
//  Wedding4You
//
//  Created by Alon Geffen on 15/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSString*)getStringFromDate:(NSDate*)date;
+(NSString*)getDateStringFromDate:(NSDate*)date;
+(NSDate*)getDateFromString:(NSString*)date;

@end
