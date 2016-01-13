//
//  ModelSql.m
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "ModelSql.h"
#import "LastUpdateSql.h"
#import "UserSql.h"
#import "GreetingSql.h"

@implementation ModelSql

-(id)init{
    self = [super init];
    if (self) {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        NSArray* paths = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        
        NSURL* directoryUrl = [paths objectAtIndex:0];
        
        NSURL* fileUrl = [directoryUrl URLByAppendingPathComponent:@"database.db"];
        
        NSString* filePath = [fileUrl path];
        
        const char* cFilePath = [filePath UTF8String];
        
        int res = sqlite3_open(cFilePath,&database);
        
        if(res != SQLITE_OK){
            NSLog(@"ERROR: fail to open db");
            sqlite3_close(database);
            database = nil;
        }
        
        //[StudentSql createTable:database];
        
        //[ModelSql dropTable:database tableName:@"LAST_UPDATE"];
        //[ModelSql dropTable:database tableName:@"USERS"];
        //[ModelSql dropTable:database tableName:@"GREETINGS"];
        [LastUpdateSql createTable:database];
        [UserSql createTable:database];
        [UserSql getUsers:database];
        [GreetingSql createTable:database];
    }
    return self;
}

+(BOOL)dropTable:(sqlite3*)database tableName:(NSString*)tblName{
    char* errormsg;
    
    NSString* sql = [NSString stringWithFormat:@"DROP TABLE %@", tblName];
    int res = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errormsg);
    if(res != SQLITE_OK){
        NSLog(@"ERROR: failed dropping %@ table", tblName);
        return NO;
    }
    return YES;
}

+(NSString*)getStringFromDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     return [formatter stringFromDate:[NSDate date]];
}

+(NSDate*)getDateFromString:(NSString*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:date];
}

-(void)addGreeting:(Greeting*)grt {
    [GreetingSql addGreeting:database grt:grt];
    
    /*User* usr =[UserSql getUser:database usId:grt.usCreatedBy.usId];
    if (usr == nil) {
        [UserSql addUser:database usr:usr];
    }*/
}
-(void)deleteGreeting:(Greeting*)grt {
    [GreetingSql deleteGreeting:database grt:grt];
}
-(Greeting*)getGreeting:(NSString*)grtId {
    return [GreetingSql getGreeting:database grtId:grtId];
}
-(NSArray*)getGreetingsforWedding:(NSString*)wdId {
    return [GreetingSql getGreetings:database];
}
-(void)setGreetingsLastUpdateDate:(NSString*)date{
    [GreetingSql setLastUpdateDate:database date:date];
}
-(NSString*)getGreetingsLastUpdateDate{
    return [GreetingSql getLastUpdateDate:database];
}
-(void)updateGreetings:(NSArray*)greetings{
    [GreetingSql updateTable:database array:greetings];
}

-(void)addUser:(User*)usr {
    [UserSql addUser:database usr:usr];
}
-(void)deleteUser:(User*)usr {
    [UserSql deleteUser:database usr:usr];
}
-(User*)getUser:(NSString*)usrId {
    return [UserSql getUser:database usId:usrId];
}
-(NSArray*)getUsers {
    return [UserSql getUsers:database];
}
-(void)setUsersLastUpdateDate:(NSString*)date{
    [GreetingSql setLastUpdateDate:database date:date];
}
-(NSString*)getUsersLastUpdateDate{
    return [GreetingSql getLastUpdateDate:database];
}
-(void)updateUsers:(NSArray*)users{
    [GreetingSql updateTable:database array:users];
}

@end
