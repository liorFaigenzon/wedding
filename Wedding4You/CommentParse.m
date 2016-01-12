//
//  CommentsParse.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "CommentParse.h"
#import <Parse/Parse.h>

@implementation CommentParse

-(void)addComment:(Comment*)cmt{
    PFObject* obj = [PFObject objectWithClassName:@"Comments"];
    //obj[@"cmtId"] = cmt.cmtId;
    obj[@"title"] = cmt.title;
    obj[@"date"] = cmt.date;
    obj[@"comment"] = cmt.comment;
    [obj setObject:[[PFQuery queryWithClassName:@"Greetings"] getObjectWithId:cmt.grtId] forKey:@"greeting"];
    [obj save];
}

-(void)deleteComment:(Comment*)cmt{
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    
    // Get comment with id parameter
    [query whereKey:@"objectId" equalTo:cmt.cmtId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        [obj delete];
    }
}

-(Comment*)getComment:(NSString*)cmtId{
    Comment* comment = nil;
    
    // Get comment with id parameter
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    [query whereKey:@"objectId" equalTo:cmtId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        
        // Fetch greeting details
        PFObject* greetingObj = [[obj objectForKey:@"greeting"] fetch];
        
        // Create comment object
        comment = [[Comment alloc] init:obj[@"objectId"] title:obj[@"title"] date:obj[@"date"] comment:obj[@"comment"] grtId:greetingObj[@"objectId"]];
    }
    return comment;
}

-(NSArray*)getCommentsForGreeting:(NSString *)grtId {
    Comment* comment = nil;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    // Get comments for specific greeting
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    [query whereKey:@"greeting" equalTo:[[PFQuery queryWithClassName:@"Greetings"] getObjectWithId:grtId]];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        // Create comment object
        comment = [[Comment alloc] init:obj[@"objectId"] title:obj[@"title"] date:obj[@"date"] comment:obj[@"comment"] grtId:grtId];
        [array addObject:comment];
    }
    return array;
}

@end
