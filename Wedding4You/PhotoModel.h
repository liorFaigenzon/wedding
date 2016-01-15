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

-(NSError*)addPhoto:(Photo*)pto;
-(NSError*)deletePhoto:(Photo*)pto;
-(Photo*)getPhoto:(NSString*)ptoId;
-(NSArray*)getPhotosForWedding:(NSString*)wdId;
-(UIImage*)getImage:(NSString*)imageName;
-(void)saveImage:(UIImage*)image withName:(NSString*)imageName;

@end


@protocol GetPhotosListener <NSObject>

-(void)done:(NSArray*)data;

@end


@interface PhotoModel : NSObject{
    id<PhotoProtocol> photoImpl;
}

+(PhotoModel*)instance;

-(void)addPhoto:(Photo*)pto block:(void(^)(NSError*))block;
-(void)deletePhoto:(Photo*)pto block:(void(^)(NSError*))block;
-(void)getPhoto:(NSString*)ptoId block:(void(^)(Photo*))block;
-(NSArray*)getPhotosForWedding:(NSString*)wdId;

-(void)getAsynch:(NSString*)wdId block:(void(^)(NSArray*))block;
-(void)getImage:(Photo*)pto block:(void(^)(UIImage*))block;
-(void)saveImage:(Photo*)pto image:(UIImage*)image block:(void(^)(NSError*))block;
@end


