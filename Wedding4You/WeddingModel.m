//
//  WeddingModel.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "WeddingModel.h"
#import "WeddingParse.h"

@implementation WeddingModel

static WeddingModel* instance = nil;

+(WeddingModel*)instance{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[WeddingModel alloc] init];
        }
    }
    return instance;
}

-(id)init {
    self = [super init];
    if (self) {
        modelImpl = [[WeddingParse alloc] init];
    }
    return self;
}

-(void)getWedding:(NSString*)wdId block:(void(^)(Wedding*))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        Wedding* wd = [modelImpl getWedding:wdId];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(wd);
        });
    } );
}

-(void)getWeddingsHostGuest:(NSString*)usId block:(void(^)(NSArray*))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [modelImpl getWeddingsHostGuest:usId];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    } );
}

-(void)addWedding:(Wedding*)wd block:(void(^)(NSError*))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        [modelImpl addWedding:wd];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

-(void)addWeddingGuests:(NSArray*)usIds toWedding:(Wedding*)wd block:(void(^)(NSError*))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        [modelImpl addWeddingGuests:usIds toWedding:wd];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

-(void)deleteWedding:(Wedding *)wd block:(void (^)(NSError *))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        [modelImpl deleteWedding:wd];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

@end
