//
//  ModelParse.m
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "ModelParse.h"
#import <Parse/Parse.h>

@implementation ModelParse

-(id)init{
    self = [super init];
    if (self) {
        [Parse setApplicationId:@"KQZXfRKACbu5xSnmCBa1r01xstfBO8I3ppWMqkjl"
                      clientKey:@"ZgD983FsRtjTmi9rZW9fVIBryfODNfqomZxlAC2s"];
        

    }
    return self;
}

-(NSError*)saveImage:(UIImage*)image withName:(NSString*)imageName{
    NSError* err = nil;
    NSData* imageData = UIImageJPEGRepresentation(image,0);
    
    PFFile* file = [PFFile fileWithName:imageName data:imageData];
    PFObject* fileobj = [PFObject objectWithClassName:@"Images"];
    fileobj[@"imageName"] = imageName;
    fileobj[@"file"] = file;
    [fileobj save];
    
    return err;
}

-(UIImage*)getImage:(NSString*)imageName{
    NSError* err = nil;
    PFQuery* query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"imageName" equalTo:imageName];
    NSArray* res = [query findObjects];
    UIImage* image = nil;
    if (res.count == 1) {
        PFObject* imObj = [res objectAtIndex:0];
        PFFile* file = imObj[@"file"];
        NSData* data = [file getData:&err];
        if (err == nil) {
            image = [UIImage imageWithData:data];
        }
    }
    return image;
}

@end
