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

-(void)addGreeting:(Greeting*)grt{
    PFObject* obj = [PFObject objectWithClassName:@"Greetings"];
    obj[@"grtId"] = grt.grtId;
    obj[@"title"] = grt.title;
    obj[@"date"] = grt.date;
    obj[@"greeting"] = grt.greeting;
    [obj save];
}

-(void)deleteGreeting:(Greeting*)grt{
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    [query whereKey:@"objectId" equalTo:grt.grtId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        [obj delete];
    }
}

-(Greeting*)getGreeting:(NSString*)grtId{
    Greeting* greeting = nil;
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    [query whereKey:@"objectId" equalTo:grtId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        greeting = [[Greeting alloc] init:obj[@"grtId"] title:obj[@"title"] date:obj[@"date"] greeting:obj[@"greeting"]];
    }
    return greeting;
}

-(NSArray*)getGreetings{
    Greeting*  greeting;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Greetings"];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        greeting = [[Greeting alloc] init:obj[@"grtId"] title:obj[@"title"] date:obj[@"date"] greeting:obj[@"greeting"]];
        [array addObject:greeting];
    }
    return array;
}

@end
