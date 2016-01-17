//
//  Photo.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "PhotoModel.h"
#import "PhotoParse.h"
#import "ModelSql.h"

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

-(void)addPhoto:(Photo*)pto block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // Add photo
        NSError* err = [photoImpl addPhoto:pto];
        
        // If created in parse, add local
        if (err == nil) {
            //[SqlImpl addPhoto:pto];
        }
        
        // Do block operations in main Q after adding photo
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

-(void)deletePhoto:(Photo*)pto block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // delete photo
        NSError* err = [photoImpl deletePhoto:pto];
        
        // If deleted in parse, delete local
        if (err == nil) {
            //[SqlImpl deletePhoto:pto];
        }
        
        // Do block operations in main Q after deleting photo
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

-(void)getPhoto:(NSString*)ptoId block:(void(^)(Photo*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        // get photo
        Photo* pto = [photoImpl getPhoto:ptoId];
        
        // Do block operations in main Q after getting photo
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(pto);
        });
    } );
}

-(NSArray*)getPhotosForWedding:(NSString*)wdId {
    return [photoImpl getPhotosForWedding:wdId];
}


//Block Asynch implementation
-(void)getAsynch:(NSString*)wdId block:(void(^)(NSArray*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [photoImpl getPhotosForWedding:wdId];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    } );
}

-(void)getImage:(Photo*)pto block:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //first try to get the image from local file
        UIImage* image = [self readingImageFromFile:pto.imageName];
        
        //if failed to get image from file try to get it from parse
        if(image == nil){
            image = [photoImpl getImage:pto.imageName];
            
            //once the image is loaded save it local
            if(image != nil){
                [self savingImageToFile:image fileName:pto.imageName];
            }
        }
        
        // Do block operations in main Q after image is loaded
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    } );
}


-(void)saveImage:(Photo*)pto image:(UIImage*)image block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //save the image to parse
        NSError* err = [photoImpl saveImage:image withName:pto.imageName];
        
        //save the image local
        [self savingImageToFile:image fileName:pto.imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(err);
        });
    } );
}

// Working with local files
-(void)savingImageToFile:(UIImage*)image fileName:(NSString*)fileName{
    NSData *pngData = UIImagePNGRepresentation(image);
    [self saveToFile:pngData fileName:fileName];
}

-(UIImage*)readingImageFromFile:(NSString*)fileName{
    NSData* pngData = [self readFromFile:fileName];
    if (pngData == nil) return nil;
    return [UIImage imageWithData:pngData];
}

-(NSString*)getLocalFilePath:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return filePath;
}

-(void)saveToFile:(NSData*)data fileName:(NSString*)fileName{
    NSString* filePath = [self getLocalFilePath:fileName];
    [data writeToFile:filePath atomically:YES]; //Write the file
}

-(NSData*)readFromFile:(NSString*)fileName{
    NSString* filePath = [self getLocalFilePath:fileName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    return pngData;
}

@end










