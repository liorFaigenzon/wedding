//
//  LastUpdateSql.h
//  Wedding4You
//
//  Created by Alon Geffen on 12/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <sqlite3.h>
#import "ModelSql.h"

@interface LastUpdateSql : ModelSql

+(BOOL)createTable:(sqlite3*)database;
+(NSString*)getLastUpdateDate:(sqlite3*)database forTable:(NSString*)table;
+(void)setLastUpdateDate:(sqlite3*)database date:(NSString*)date forTable:(NSString*)table;

@end
