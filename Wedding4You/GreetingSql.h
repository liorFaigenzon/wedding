//
//  GreetingSql.h
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ModelSql.h"
#import "Greeting.h"

@interface GreetingSql : ModelSql<ModelSqlProtocol>

+(void)addGreeting:(sqlite3*)database grt:(Greeting*)grt;
+(void)deleteGreeting:(sqlite3*)database grt:(Greeting*)grt;
+(Greeting*)getGreeting:(sqlite3*)database grtId:(NSString*)grtId;
+(NSArray*)getGreetings:(sqlite3*)database;

@end
