//
//  GreetingSql.m
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "GreetingSql.h"
#import "LastUpdateSql.h"
#import "UserSql.h"

@implementation GreetingSql

static NSString* GREETING_TABLE = @"GREETINGS";
static NSString* GREETING_GRT_ID = @"ID";
static NSString* GREETING_TITLE = @"TITLE";
static NSString* GREETING_DATE = @"DATE";
static NSString* GREETING_GREETING = @"GREETING";
static NSString* GREETING_WD_ID = @"WD_ID";
static NSString* GREETING_US_ID = @"US_ID";

+(BOOL)createTable:(sqlite3*)database{
    char* errormsg;
    
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT PRIMARY KEY, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT)",GREETING_TABLE,GREETING_GRT_ID,GREETING_TITLE,GREETING_DATE,GREETING_GREETING,GREETING_WD_ID,GREETING_US_ID];
    int res = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errormsg);
    if(res != SQLITE_OK){
        NSLog(@"ERROR: failed creating GREETINGS table");
        return NO;
    }
    return YES;
}

+(void)addGreeting:(sqlite3*)database grt:(Greeting*)grt {
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@,%@,%@,%@,%@,%@) values (?,?,?,?,?,?);",GREETING_TABLE,GREETING_GRT_ID,GREETING_TITLE,GREETING_DATE,GREETING_GREETING,GREETING_WD_ID,GREETING_US_ID];
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        // Bind all greeting attributes
        sqlite3_bind_text(statment, 1, [grt.grtId UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [grt.title UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 3, [[self getStringFromDate:grt.date] UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 4, [grt.greeting UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 5, [grt.wdId UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 6, [grt.usCreatedBy.usId UTF8String],-1,NULL);
        
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addStudent failed %s",sqlite3_errmsg(database));
}

+(void)deleteGreeting:(sqlite3*)database grt:(Greeting*)grt {
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?;", GREETING_TABLE, GREETING_GRT_ID];
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [grt.grtId UTF8String], -1, NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addStudent failed %s",sqlite3_errmsg(database));
}

+(Greeting*)getGreeting:(sqlite3 *)database grtId:(NSString *)grtId {
    Greeting* grt = nil;
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %@;", GREETING_TABLE];
    
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        // Bind greeting id to the statement
        sqlite3_bind_text(statment, 1, [grtId UTF8String],-1,NULL);
        
        if(sqlite3_step(statment) == SQLITE_ROW){
            // Get greeting details
            NSString* grtId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* title = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSDate* date = [self getDateFromString:[NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)]];
            NSString* greeting = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            NSString* wdId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,4)];
            
            // Fetch user details
            User* usr = [[User alloc] init];
            usr.usId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,5)];
            
            grt = [[Greeting alloc] init:grtId title:title date:date greeting:greeting wdId:wdId usCreatedBy:usr];
        }
    }else{
        NSLog(@"ERROR: getGreeting failed %s",sqlite3_errmsg(database));
        return nil;
    }
    
    return grt;
}

+(NSArray*)getGreetings:(sqlite3 *)database{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %@;", GREETING_TABLE];
    
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        while(sqlite3_step(statment) == SQLITE_ROW){
            // Get greeting details
            NSString* grtId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* title = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSDate* date = [self getDateFromString:[NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)]];
            NSString* greeting = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            NSString* wdId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,4)];
            
            // Fetch user details
            User* usr = [[User alloc] init];
            usr.usId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,5)];
            
            Greeting* grt = [[Greeting alloc] init:grtId title:title date:date greeting:greeting wdId:wdId usCreatedBy:usr];
            [data addObject:grt];
        }
    }else{
        NSLog(@"ERROR: getGreetings failed %s",sqlite3_errmsg(database));
        return nil;
    }

    sqlite3_free(statment);
    
    return data;
}

+(NSString*)getLastUpdateDate:(sqlite3*)database {
    return [LastUpdateSql getLastUpdateDate:database forTable:GREETING_TABLE];
}

+(void)setLastUpdateDate:(sqlite3*)database date:(NSString*)date {
    [LastUpdateSql setLastUpdateDate:database date:date forTable:GREETING_TABLE];
}

+(void)updateTable:(sqlite3*)database array:(NSArray*)array {
    for (Greeting* grt in array) {
        [self addGreeting:database grt:grt];
    }
}

@end
