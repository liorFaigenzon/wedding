//
//  ModelSql.h
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GreetingModel.h"
#import "Greeting.h"

@protocol ModelSqlProtocol <NSObject>

+(BOOL)createTable:(sqlite3*)database;

+(NSString*)getLastUpdateDate:(sqlite3*)database;
+(void)setLastUpdateDate:(sqlite3*)database date:(NSString*)date;
+(void)updateTable:(sqlite3*)database array:(NSArray*)array;

@end

@interface ModelSql : NSObject<GreetingProtocol> {
    sqlite3* database;
}

+(NSString*)getStringFromDate:(NSDate*)date;
+(NSDate*)getDateFromString:(NSString*)date;

@end
