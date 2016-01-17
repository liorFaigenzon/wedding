//
//  UserSql.h
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "ModelSql.h"

@interface UserSql : ModelSql<ModelSqlProtocol>

+(void)addUser:(sqlite3*)database usr:(User*)usr;
+(void)deleteUser:(sqlite3*)database usr:(User*)usr;
+(User*)getUser:(sqlite3*)database usId:(NSString*)usId;
+(NSArray*)getUsers:(sqlite3*)database;

@end
