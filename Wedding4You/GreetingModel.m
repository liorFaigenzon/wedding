//
//  Greeting.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "GreetingModel.h"
#import "GreetingParse.h"
#import "ModelSql.h"

@implementation GreetingModel

static GreetingModel* instance = nil;

+(GreetingModel*)instance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[GreetingModel alloc] init];
        }
    }
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        greetingParseImpl = [[GreetingParse alloc] init];
        SqlImpl = [[ModelSql alloc] init];
    }
    return self;
}

-(void)addGreeting:(Greeting*)grt block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // Add greeting
        NSError* err = [greetingParseImpl addGreeting:grt];
        
        // If created in parse, add local
        if (err == nil) {
            [SqlImpl addGreeting:grt];
        }
        
        // Do logic in the main Q after adding this greeting
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)deleteGreeting:(Greeting*)grt block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // Delete greeting
        NSError* err = [greetingParseImpl deleteGreeting:grt];
        
        // Do logic in the main Q after deleting this greeting
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)getGreeting:(NSString*)grtId block:(void(^)(Greeting*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // Get greeting
        Greeting* grt = [greetingParseImpl getGreeting:grtId];
        
        // Do logic in the main Q after getting this greeting
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(grt);
        });
    } );
}

-(NSArray*)getGreetingsforWedding:(NSString*)wdId {
    return [greetingParseImpl getGreetingsforWedding:wdId];
}


//Block Asynch implementation
-(void)getAsynch:(NSString*)wdId block:(void(^)(NSArray*))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [greetingParseImpl getGreetingsforWedding:wdId];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    } );
}

@end










