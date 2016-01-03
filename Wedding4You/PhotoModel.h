//
//  PhotosModel.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import <UIKit/UIKit.h>

@protocol PhotoProtocol <NSObject>

-(void)addPhoto:(Photo*)pto;
-(void)deletePhoto:(Photo*)pto;
-(Photo*)getPhoto:(NSString*)ptoId;
-(NSArray*)getPhotos;
-(void)savePto:(UIImage*)image withName:(NSString*)imageName;
-(UIImage*)getPto:(NSString*)imageName;

@end


@protocol GetPhotosListener <NSObject>

-(void)done:(NSArray*)data;

@end


@interface PhotoModel : NSObject{
    id<PhotoProtocol> photoImpl;
}

+(PhotoModel*)instance;

-(void)addPhoto:(Photo*)Pto;

-(void)getAsynch:(void(^)(NSArray*))blockListener;
-(void)getImage:(Photo*)pto block:(void(^)(UIImage*))block;
-(void)saveImage:(Photo*)pto image:(UIImage*)image block:(void(^)(NSError*))block;
@end


