//
//  ModelSql.m
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "ModelSql.h"
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
            database = nil;
        }
        
        //[StudentSql createTable:database];
        //[LastUpdateSql createTable:database];
    }
    return self;
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

@end
