//
//  Comment.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "CommentModel.h"
#import "CommentParse.h"

@implementation CommentModel

static CommentModel* instance = nil;

+(CommentModel*)instance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[CommentModel alloc] init];
        }
    }
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        //commentImpl = [[CommentSql alloc] init];
        commentImpl = [[CommentParse alloc] init];
    }
    return self;
}

-(void)addComment:(Comment*)cmt block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // Add comment
        NSError* err = [commentImpl addComment:cmt];
        
        // If created in parse, add local
        if (err == nil) {
            //[SqlImpl addComment:cmt];
        }
        
        // Do logic in the main Q after adding this comment
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)deleteComment:(Comment*)cmt block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // Delete comment
        NSError* err = [commentImpl deleteComment:cmt];
        
        // If created in parse, add local
        if (err == nil) {
            //[SqlImpl deleteComment:cmt];
        }
        
        // Do logic in the main Q after deleting this comment
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)getComment:(NSString*)cmtId block:(void(^)(Comment*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // Get comment
        Comment* cmt = [commentImpl getComment:cmtId];
        
        // Do logic in the main Q after getting this comment
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(cmt);
        });
    } );
}

-(NSArray*)getCommentsForGreeting:(NSString *)grtId {
    return [commentImpl getCommentsForGreeting:grtId];
}


//Block Asynch implementation
-(void)getAsynch:(NSString *)grtId block:(void(^)(NSArray*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [commentImpl getCommentsForGreeting:grtId];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    } );
}

@end










