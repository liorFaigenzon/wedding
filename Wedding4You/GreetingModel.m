//
//  Greeting.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "GreetingModel.h"
#import "GreetingParse.h"

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
        //greetingImpl = [[GreetingSql alloc] init];
        greetingImpl = [[GreetingParse alloc] init];
    }
    return self;
}

-(void)addGreeting:(Greeting*)grt{
    [greetingImpl addGreeting:grt];
}
-(void)deleteGreeting:(Greeting*)grt{
    [greetingImpl deleteGreeting:grt];
}
-(Greeting*)getGreeting:(NSString*)grtId{
    return [greetingImpl getGreeting:grtId];
}
-(NSArray*)getGreetings{
    return [greetingImpl getGreetings];
}


//Block Asynch implementation
-(void)getAsynch:(void(^)(NSArray*))blockLigrtener{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [greetingImpl getGreetings];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockLigrtener(data);
        });
    } );
}
@end










