//
//  ModelSql.h
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Greeting.h"
#import "Utilities.h"

@protocol ModelSqlProtocol <NSObject>

+(BOOL)createTable:(sqlite3*)database;

+(NSString*)getLastUpdateDate:(sqlite3*)database;
+(void)setLastUpdateDate:(sqlite3*)database date:(NSString*)date;
+(void)updateTable:(sqlite3*)database array:(NSArray*)array;

@end

@interface ModelSql : NSObject {
    sqlite3* database;
}

+(BOOL)dropTable:(sqlite3*)database tableName:(NSString*)tblName;

-(void)addGreeting:(Greeting*)grt;
-(void)deleteGreeting:(Greeting*)grt;
-(Greeting*)getGreeting:(NSString*)grtId;
-(NSArray*)getGreetingsforWedding:(NSString*)wdId;
-(void)setGreetingsLastUpdateDate:(NSString*)date;
-(NSString*)getGreetingsLastUpdateDate;
-(void)updateGreetings:(NSArray*)greetings;

@end
