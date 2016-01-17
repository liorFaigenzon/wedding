//
//  Utilities.m
//  Wedding4You
//
//  Created by Alon Geffen on 15/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSString*)getStringFromDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}

+(NSString*)getDateStringFromDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    return [formatter stringFromDate:[NSDate date]];
}

+(NSDate*)getDateFromString:(NSString*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:date];
}

@end
