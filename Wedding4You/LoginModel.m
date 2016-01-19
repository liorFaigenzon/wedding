//
//  LoginModel.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "LoginModel.h"
#import "LoginParse.h"

@implementation LoginModel {
    LoginParse* parseModelImpl;
}

static LoginModel* instance = nil;

+(LoginModel*)instance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[LoginModel alloc] init];
        }
    }
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        parseModelImpl = [[LoginParse alloc] init];
        _user = [parseModelImpl getCurrentUser];
    }
    return self;
}

-(void)login:(NSString*)user pwd:(NSString*)pwd block:(void(^)(BOOL))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        BOOL res = [parseModelImpl login:user pwd:pwd];
        
        if (res) {
            self.user = user;
            self.userDetails = [parseModelImpl getCurrentUserDetails];
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(res);
        });
    } );
}

-(void)signup:(NSString*)user pwd:(NSString*)pwd usDetails:(User*)usDetails block:(void(^)(BOOL))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        BOOL res = [parseModelImpl signup:user pwd:pwd usDetails:usDetails];
        
        if (res) {
            self.user = user;
        }
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(res);
        });
    } );
}

-(void)logout: (void(^)(void))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        [parseModelImpl logout];
        self.user = nil;
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block();
        });
    } );
}


@end
