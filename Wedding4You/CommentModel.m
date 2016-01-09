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

-(void)addComment:(Comment*)cmt{
    [commentImpl addComment:cmt];
}
-(void)deleteComment:(Comment*)cmt{
    [commentImpl deleteComment:cmt];
}
-(Comment*)getComment:(NSString*)cmtId{
    return [commentImpl getComment:cmtId];
}
-(NSArray*)getComments{
    return [commentImpl getComments];
}


//Block Asynch implementation
-(void)getAsynch:(void(^)(NSArray*))blockLicmtener{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [commentImpl getComments];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockLicmtener(data);
        });
    } );
}
@end










