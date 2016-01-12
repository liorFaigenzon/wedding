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
    obj[@"title"] = cmt.title;
    //obj[@"date"] = cmt.date;
    obj[@"comment"] = cmt.comment;
    obj[@"grtId"] = cmt.grtId;
    [obj save];
}

-(void)deleteComment:(Comment*)cmt{
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    [query whereKey:@"objectId" equalTo:cmt.cmtId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        [obj delete];
    }
}

-(Comment*)getComment:(NSString*)cmtId{
    Comment* comment = nil;
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    [query whereKey:@"objectId" equalTo:cmtId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        comment = [[Comment alloc] init:obj[@"cmtId"] title:obj[@"title"] date:obj[@"date"] comment:obj[@"comment"] grtId:obj[@"grtId"]];
    }
    return comment;
}

-(NSArray*)getComments{
    Comment* comment = nil;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Comments"];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
      comment = [[Comment alloc] init:obj[@"cmtId"] title:obj[@"title"] date:obj[@"date"] comment:obj[@"comment"] grtId:obj[@"grtId"]];
        [array addObject:comment];
    }
    return array;
}

@end
