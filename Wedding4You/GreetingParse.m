//
//  GreetingsParse.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "GreetingParse.h"
#import <Parse/Parse.h>

@implementation GreetingParse

-(NSError*)addGreeting:(Greeting*)grt{
    NSError* err;
    PFObject* obj = [PFObject objectWithClassName:@"Greetings"];
    //obj[@"grtId"] = grt.grtId;
    obj[@"title"] = grt.title;
    obj[@"date"] = grt.date;
    obj[@"greeting"] = grt.greeting;
    [obj setObject:[[PFQuery queryWithClassName:@"Weddings"] getObjectWithId:grt.wdId] forKey:@"wedding"];
    [obj setObject:[PFUser currentUser] forKey:@"createdBy"];
    
    // If saved successfully
    if ([obj save:&err] == YES) {
        grt.grtId = obj.objectId;
        
        // Get user id
        PFUser* userObj = [obj objectForKey:@"createdBy"];
        grt.usCreatedBy = [[User alloc] init];
        grt.usCreatedBy.usId = userObj.objectId;
    }
    
    return err;
}

-(NSError*)deleteGreeting:(Greeting*)grt{
    NSError* err;
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    
    // Get greeting with id parameter
    PFObject* obj = [query getObjectWithId:grt.grtId error:&err];
    
    // Delete the object if found
    if (obj != nil) {
        [obj delete:&err];
    }
    
    return err;
}

-(Greeting*)getGreeting:(NSString*)grtId{
    Greeting* greeting = nil;
    
    // Get greeting with id parameter
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    PFObject* obj = [query getObjectWithId:grtId];
    
    if (obj != nil) {
        // Get wedding details
        PFObject* weddingObj = [obj objectForKey:@"wedding"];
        
        // Fetch user details
        PFUser* pfusr = [[obj objectForKey:@"createdBy"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        
        // Create greeting object
        greeting = [[Greeting alloc] init:obj.objectId title:obj[@"title"] date:obj[@"date"] greeting:obj[@"greeting"] wdId:weddingObj.objectId usCreatedBy:usr];
    }
    
    return greeting;
}

-(NSArray*)getGreetingsforWedding:(NSString*)wdId {
    Greeting*  greeting;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    // Get greetings for specific wedding
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    [query whereKey:@"wedding" equalTo:[[PFQuery queryWithClassName:@"Weddings"] getObjectWithId:wdId]];
    NSArray* res = [query findObjects];
    
    for (PFObject* obj in res) {
        // Fetch user details
        PFUser* pfusr = [[obj objectForKey:@"couple"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        
        // Create wedding object
        greeting = [[Greeting alloc] init:obj.objectId title:obj[@"title"] date:obj[@"date"] greeting:obj[@"greeting"] wdId:wdId usCreatedBy:usr];
        [array addObject:greeting];
    }
    return array;
}

-(NSArray*)getGreetingsFromDate:(NSString*)date forWedding:(NSString*)wdId{
    Greeting*  greeting;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    // Get greetings for specific wedding from date
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    [query whereKey:@"wedding" equalTo:[[PFQuery queryWithClassName:@"Weddings"] getObjectWithId:wdId]];
    NSDate* dated = [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
    [query whereKey:@"updatedAt" greaterThanOrEqualTo:dated];
    
    NSArray* res = [query findObjects];
    
    for (PFObject* obj in res) {
        // Get wedding details
        PFObject* weddingObj = [obj objectForKey:@"wedding"];
        
        // Fetch user details
        PFUser* pfusr = [[obj objectForKey:@"couple"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        
        // Create wedding object
        greeting = [[Greeting alloc] init:obj.objectId title:obj[@"title"] date:obj[@"date"] greeting:obj[@"greeting"] wdId:weddingObj.objectId usCreatedBy:usr];
        [array addObject:greeting];
    }
    return array;
}

@end
