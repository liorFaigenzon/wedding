//
//  WeddingParse.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "WeddingParse.h"
#import "LoginParse.h"
#import <Parse/Parse.h>

@implementation WeddingParse

-(NSArray*)getWeddingsHostGuest:(NSString*)usId {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    [query whereKey:@"guests" equalTo:[PFQuery getUserObjectWithId:usId]];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        PFUser* pfusr = [[obj objectForKey:@"couple"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        Wedding* wedding = [[Wedding alloc] init:obj[@"wdId"] usCouple:usr];
        [array addObject:wedding];
    }
    
    return array;
}

-(void)addWedding:(Wedding*)wd {
    PFObject* obj = [PFObject objectWithClassName:@"Weddings"];
    obj[@"wdId"] = wd.wdId;
    [obj setObject:[PFUser currentUser] forKey:@"couple"];
    [obj save];
}

-(void)addWeddingGuests:(NSArray*)usIds toWedding:(NSString*)wdId {
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    [query whereKey:@"wdId" equalTo:wdId];
    
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        PFRelation* rel = [obj relationForKey:@"guests"];
        
        for (NSString* usId in usIds) {
            [rel addObject:[PFQuery getUserObjectWithId:usId]];
        }
        
        [obj save];
    }
}

-(void)deleteWedding:(Wedding *)wd {
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    [query whereKey:@"wdId" equalTo:wd.wdId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        [obj delete];
    }
}

@end
