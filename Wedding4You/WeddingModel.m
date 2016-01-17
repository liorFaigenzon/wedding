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

-(void)getWeddingsHostGuest:(void(^)(NSArray*))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [modelImpl getWeddingsHostGuest];
        
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
        NSError* err = [modelImpl addWedding:wd];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)addWeddingGuests:(NSArray*)usIds toWedding:(Wedding*)wd block:(void(^)(NSError*))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueue", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSError* err = [modelImpl addWeddingGuests:usIds toWedding:wd];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)deleteWedding:(Wedding *)wd block:(void (^)(NSError *))block {
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        NSError* err = [modelImpl deleteWedding:wd];
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)getImage:(Wedding*)wd block:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //first try to get the image from local file
        UIImage* image = [self readingImageFromFile:wd.imageName];
        
        //if failed to get image from file try to get it from parse
        if(image == nil){
            image = [modelImpl getImage:wd.imageName];
            
            //once the image is loaded save it local
            if(image != nil){
                [self savingImageToFile:image fileName:wd.imageName];
            }
        }
        
        // Do block operations in main Q after image is loaded
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    } );
}


-(void)saveImage:(Wedding*)wd image:(UIImage*)image block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //save the image to parse
        NSError* err = [modelImpl saveImage:image withName:wd.imageName];
        
        //save the image local
        [self savingImageToFile:image fileName:wd.imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

@end
