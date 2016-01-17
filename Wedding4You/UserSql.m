//
//  UserSql.m
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "UserSql.h"
#import "LastUpdateSql.h"

@implementation UserSql

static NSString* USERS_TABLE = @"USERS";
static NSString* USERS_ID = @"ID";
static NSString* USERS_FNAME = @"FNAME";
static NSString* USERS_LNAME = @"LNAME";
static NSString* USERS_PHONE = @"PHONE";

+(BOOL)createTable:(sqlite3*)database{
    char* errormsg;
    
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT PRIMARY KEY, %@ TEXT, %@ TEXT, %@ TEXT)",USERS_TABLE,USERS_ID,USERS_FNAME,USERS_LNAME,USERS_PHONE];
    int res = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errormsg);
    if(res != SQLITE_OK){
        NSLog(@"ERROR: failed creating USERS table");
        return NO;
    }
    return YES;
}

+(void)addUser:(sqlite3*)database usr:(User*)usr {
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@,%@,%@,%@) values (?,?,?,?);",USERS_TABLE,USERS_ID,USERS_FNAME,USERS_LNAME,USERS_PHONE];
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [usr.usId UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [usr.fName UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 4, [usr.lName UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 5, [usr.phone UTF8String],-1,NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addUser failed %s",sqlite3_errmsg(database));
}

+(void)deleteUser:(sqlite3*)database usr:(User*)usr {
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?;", USERS_TABLE, USERS_ID];
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [usr.usId UTF8String], -1, NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: deleteUser failed %s",sqlite3_errmsg(database));
}

+(User*)getUser:(sqlite3 *)database usId:(NSString *)usId {
    User* us = nil;
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ?;", USERS_TABLE, USERS_ID];
    
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        // Bind greeting id to the statement
        sqlite3_bind_text(statment, 1, [usId UTF8String],-1,NULL);
        
        if(sqlite3_step(statment) == SQLITE_ROW){
            // Get user details
            NSString* usId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* fName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSString* lName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
            NSString* phone = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            
            us = [[User alloc] init:usId fname:fName lName:lName phone:phone];
        }
    }else{
        NSLog(@"ERROR: getUsers failed %s",sqlite3_errmsg(database));
        return nil;
    }
    
    return us;
}

+(NSArray*)getUsers:(sqlite3 *)database{
    NSMutableArray* data = [[NSMutableArray alloc] init];
    sqlite3_stmt *statment;
    
    NSString* query = [NSString stringWithFormat:@"SELECT * from %@;", USERS_TABLE];
    
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        while(sqlite3_step(statment) == SQLITE_ROW){
            // Get user details
            NSString* usId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
            NSString* fName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,1)];
            NSString* lName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,2)];
            NSString* phone = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,3)];
            
            User* us = [[User alloc] init:usId fname:fName lName:lName phone:phone];
            [data addObject:us];
        }
    }else{
        NSLog(@"ERROR: getUsers failed %s",sqlite3_errmsg(database));
        return nil;
    }
    
    return data;
}

+(NSString*)getLastUpdateDate:(sqlite3*)database {
    return [LastUpdateSql getLastUpdateDate:database forTable:USERS_TABLE];
}

+(void)setLastUpdateDate:(sqlite3*)database date:(NSString*)date {
    [LastUpdateSql setLastUpdateDate:database date:date forTable:USERS_TABLE];
}

+(void)updateTable:(sqlite3*)database array:(NSArray*)array {
    for (User* usr in array) {
        [self addUser:database usr:usr];
    }
}

@end
