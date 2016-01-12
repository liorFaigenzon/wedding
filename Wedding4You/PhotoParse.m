//
//  PhotosParse.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "PhotoParse.h"
#import <Parse/Parse.h>

@implementation PhotoParse

-(void)addPhoto:(Photo*)pto{
    PFObject* obj = [PFObject objectWithClassName:@"Photos"];
    obj[@"title"] = pto.title;
    obj[@"date"] = pto.date;
    obj[@"descriptionPt"] = pto.descriptionPt;
    obj[@"imageName"] = pto.imageName;
    [obj save];
}

-(void)deletePhoto:(Photo*)pto{
    PFQuery* query = [PFQuery queryWithClassName:@"Photos"];
    [query whereKey:@"objectId" equalTo:pto.ptoId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        [obj delete];
    }
}

-(Photo*)getPhoto:(NSString*)ptoId{
    Photo* photo = nil;
    PFQuery* query = [PFQuery queryWithClassName:@"Photos"];
    [query whereKey:@"objectId" equalTo:ptoId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        photo = [[Photo alloc] init:obj[@"ptoId"] title:obj[@"title"] date:obj[@"date"] descriptionPt:obj[@"descriptionPt"] imageName:obj[@"imageName"]];
    }
    return photo;
}

-(NSArray*)getPhotos{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Photos"];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Photo*  photo = [[Photo alloc] init:obj[@"ptoId"] title:obj[@"title"] date:obj[@"date"] descriptionPt:obj[@"descriptionPt"] imageName:obj[@"imageName"]];
        [array addObject:photo];
    }
    return array;
}

-(void)savePto:(UIImage*)image withName:(NSString*)imageName{
    NSData* imageData = UIImageJPEGRepresentation(image,0);
    
    PFFile* file = [PFFile fileWithName:imageName data:imageData];
    PFObject* fileobj = [PFObject objectWithClassName:@"Images"];
    fileobj[@"imageName"] = imageName;
    fileobj[@"file"] = file;
    [fileobj save];
}

-(UIImage*)getPto:(NSString*)imageName{
    PFQuery* query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"imageName" equalTo:imageName];
    NSArray* res = [query findObjects];
    UIImage* image = nil;
    if (res.count == 1) {
        PFObject* imObj = [res objectAtIndex:0];
        PFFile* file = imObj[@"file"];
        NSData* data = [file getData];
        image = [UIImage imageWithData:data];
    }
    return image;
}


@end
