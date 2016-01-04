//
//  Photo.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "PhotomODEL.h"
#import "PhotoParse.h"

@implementation PhotoModel  

static PhotoModel* instance = nil;

+(PhotoModel*)instance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[PhotoModel alloc] init];
        }
    }
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        //PhotoImpl = [[PhotoSql alloc] init];
        photoImpl = [[PhotoParse alloc] init];
    }
    return self;
}

-(void)addPhoto:(Photo*)pto{
    [photoImpl addPhoto:pto];
}
-(void)deletePhoto:(Photo*)pto{
    [photoImpl deletePhoto:pto];
}
-(Photo*)getPhoto:(NSString*)ptoId{
    return [photoImpl getPhoto:ptoId];
}
-(NSArray*)getPhotos{
    return [photoImpl getPhotos];
}


//Block Asynch implementation
-(void)getAsynch:(void(^)(NSArray*))blockLiptoener{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [photoImpl getPhotos];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockLiptoener(data);
        });
    } );
}

-(void)getImage:(Photo*)pto block:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        UIImage* image = [photoImpl getPto:pto.imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    } );
}


-(void)saveImage:(Photo*)pto image:(UIImage*)image block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        [photoImpl savePto:image withName:pto.imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}
@end










