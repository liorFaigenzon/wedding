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

-(NSError*)addWedding:(Wedding*)wd {
    NSError* err = nil;
    PFObject* obj = [PFObject objectWithClassName:@"Weddings"];
    //obj[@"wdId"] = wd.wdId;
    [obj setObject:[PFUser currentUser] forKey:@"couple"];
    obj[@"date"] = wd.date;
    if (wd.imageName != nil) {
        obj[@"imageName"] = wd.imageName;
    }
    
    // If saved successfully
    if ([obj save:&err] == YES) {
        wd.wdId = obj.objectId;
        
        // Get user id
        PFUser* userObj = [obj objectForKey:@"couple"];
        wd.usCouple = [[User alloc] init];
        wd.usCouple.usId = userObj.objectId;
    }
    
    return err;
}

-(NSError*)addWeddingGuests:(NSArray*)usIds toWedding:(Wedding*)wd {
    NSError* err;
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    [query whereKey:@"objectId" equalTo:wd.wdId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        PFRelation* rel = [obj relationForKey:@"guests"];
        
        // Add all the guests in the list to the wedding
        for (NSString* usId in usIds) {
            [rel addObject:[PFQuery getUserObjectWithId:usId]];
        }
        
        [obj save:&err];
    }
    
    return err;
}

-(NSArray*)getWeddingsHostGuest {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    // Get weddings for this specific guest
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    [query whereKey:@"guests" equalTo:[PFUser currentUser]];
    NSArray* res = [query findObjects];
    
    for (PFObject* obj in res) {
        // Fetch user details
        PFUser* pfusr = [[obj objectForKey:@"couple"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        
        //  Create wedding object
        Wedding* wedding = [[Wedding alloc] init:obj.objectId usCouple:usr date:obj[@"date"] imageName:obj[@"imageName"]];
        [array addObject:wedding];
    }
    
    return array;
}

-(Wedding*)getWedding:(NSString *)wdId{
    Wedding* wedding = nil;
    
    // Get wedding with id parameter
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    [query whereKey:@"objectId" equalTo:wdId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        
        // Fetch user details
        PFUser* pfusr = [[obj objectForKey:@"couple"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        
        // Creating wedding object with this user
        wedding = [[Wedding alloc] init:obj.objectId usCouple:usr date:obj[@"date"] imageName:obj[@"imageName"]];
    }
    return wedding;
}

-(NSError*)deleteWedding:(Wedding *)wd {
    NSError* err = nil;
    PFQuery* query = [PFQuery queryWithClassName:@"Weddings"];
    
    // Get wedding with id parameter
    [query whereKey:@"wdId" equalTo:wd.wdId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        [obj delete:&err];
    }
    
    return err;
}

@end
