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

-(NSError*)addPhoto:(Photo*)pto{
    NSError* err = nil;
    PFObject* obj = [PFObject objectWithClassName:@"Photos"];
    obj[@"title"] = pto.title;
    obj[@"date"] = pto.date;
    obj[@"descriptionPt"] = pto.descriptionPt;
    obj[@"imageName"] = pto.imageName;
    [obj setObject:[[PFQuery queryWithClassName:@"Weddings"] getObjectWithId:pto.wdId] forKey:@"wedding"];
    
    // If saved successfully
    if ([obj save:&err] == YES) {
        pto.ptoId = obj.objectId;
        
        // Get user id
        PFUser* userObj = [obj objectForKey:@"createdBy"];
        pto.usId = userObj.objectId;
    }
    
    return err;
}

-(NSError*)deletePhoto:(Photo*)pto{
    NSError* err;
    PFQuery* query = [PFQuery queryWithClassName:@"Photos"];
    
    // Get photo with id parameter
    PFObject* obj = [query getObjectWithId:pto.ptoId error:&err];
    
    // Delete the object if found
    if (obj != nil) {
        [obj delete:&err];
    }
    
    return err;
}

-(Photo*)getPhoto:(NSString*)ptoId{
    Photo* photo = nil;
    PFQuery* query = [PFQuery queryWithClassName:@"Photos"];
    [query whereKey:@"objectId" equalTo:ptoId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        
        // Get wedding details
        PFObject* weddingObj = [obj objectForKey:@"wedding"];
        
        // Get user details
        PFUser* userObj = [obj objectForKey:@"createdBy"];
        
        // Create photo object
        photo = [[Photo alloc] init:obj.objectId title:obj[@"title"] date:obj[@"date"] descriptionPt:obj[@"descriptionPt"] imageName:obj[@"imageName"] wdId:weddingObj.objectId usId:userObj.objectId];
    }
    return photo;
}

-(NSArray*)getPhotosForWedding:(NSString *)wdId{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    // Get photos for specific wedding
    PFQuery* query = [PFQuery queryWithClassName:@"Photos"];
    [query whereKey:@"wedding" equalTo:[[PFQuery queryWithClassName:@"Weddings"] getObjectWithId:wdId]];
    NSArray* res = [query findObjects];
    
    for (PFObject* obj in res) {
        // Get user details
        PFUser* userObj = [obj objectForKey:@"createdBy"];
        
        // Create photo object
        Photo*  photo = [[Photo alloc] init:obj.objectId title:obj[@"title"] date:obj[@"date"] descriptionPt:obj[@"descriptionPt"] imageName:obj[@"imageName"] wdId:wdId usId:userObj.objectId];
        [array addObject:photo];
    }
    return array;
}

-(UIImage*)getImage:(NSString*)imageName{
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

-(void)saveImage:(UIImage*)image withName:(NSString*)imageName{
    NSData* imageData = UIImageJPEGRepresentation(image,0);
    
    PFFile* file = [PFFile fileWithName:imageName data:imageData];
    PFObject* fileobj = [PFObject objectWithClassName:@"Images"];
    fileobj[@"imageName"] = imageName;
    fileobj[@"file"] = file;
    [fileobj save];
}


@end
