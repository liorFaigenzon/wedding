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

-(NSError*)addComment:(Comment*)cmt{
    NSError* err = nil;
    PFObject* obj = [PFObject objectWithClassName:@"Comments"];
    //obj[@"cmtId"] = cmt.cmtId;
    obj[@"title"] = cmt.title;
    obj[@"date"] = cmt.date;
    obj[@"comment"] = cmt.comment;
    [obj setObject:[[PFQuery queryWithClassName:@"Greetings"] getObjectWithId:cmt.grtId] forKey:@"greeting"];
    [obj setObject:[PFUser currentUser] forKey:@"createdBy"];
    
    // If saved successfully
    if ([obj save:&err] == YES) {
        cmt.cmtId = obj.objectId;
        
        // Get user id
        PFUser* userObj = [obj objectForKey:@"createdBy"];
        cmt.createdBy = [[User alloc] init];
        cmt.createdBy.usId = userObj.objectId;
    }
    
    return err;
}

-(NSError*)deleteComment:(Comment *)cmt{
    NSError* err;
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    
    // Get comment with id parameter
    PFObject* obj = [query getObjectWithId:cmt.cmtId error:&err];
    
    // Delete the object if found
    if (obj != nil) {
        [obj delete:&err];
    }
    
    return err;
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
        PFObject* greetingObj = [obj objectForKey:@"greeting"];
        
        // Fetch user details
        PFUser* pfusr = [[obj objectForKey:@"createdBy"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        
        // Create comment object
        comment = [[Comment alloc] init:obj.objectId title:obj[@"title"] date:obj[@"date"] comment:obj[@"comment"] grtId:greetingObj.objectId createdBy:usr];
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
        // Fetch user details
        PFUser* pfusr = [[obj objectForKey:@"createdBy"] fetch];
        User* usr = [[User alloc] init:pfusr.objectId fname:pfusr[@"fname"] lName:pfusr[@"lname"] phone:pfusr[@"phone"]];
        
        // Create comment object
        comment = [[Comment alloc] init:obj.objectId title:obj[@"title"] date:obj[@"date"] comment:obj[@"comment"] grtId:grtId createdBy:usr];
        [array addObject:comment];
    }
    return array;
}

@end
