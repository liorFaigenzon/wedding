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

-(void)addWeddingGuest:(NSString*)usId toWedding:(NSString*)wdId {
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    [query whereKey:@"wdId" equalTo:wdId];
    
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        PFUser* usr = [PFQuery getUserObjectWithId:usId];
        
        if (usr != nil) {
            [obj addObject:[PFQuery getUserObjectWithId:usId] forKey: @"guests"];
        }
    }
}

-(void)addWedding:(Wedding*)wedding {
    PFObject* obj = [PFObject objectWithClassName:@"Weddings"];
    obj[@"CoupleId"] = wedding.usCouple;
    [obj save];
}

-(NSArray*)getWeddingsHostGuest:(NSString*)usId {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    [query whereKey:@"guests" equalTo:usId];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Wedding* wedding = [[Wedding alloc] init:obj[@"wdId"] usCouple:obj[@"CoupleId"]];
        [array addObject:wedding];
    }
    
    return array;
}

@end
