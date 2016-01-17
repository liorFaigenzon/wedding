//
//  WeddingModel.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wedding.h"
#import "Model.h"

@protocol WeddingModelProtocol <NSObject>

-(NSArray*)getWeddingsHostGuest;
-(Wedding*)getWedding:(NSString*)wdId;
-(NSError*)addWedding:(Wedding*)wd;
-(NSError*)addWeddingGuests:(NSArray*)usIds toWedding:(Wedding*)wd;
-(NSError*)deleteWedding:(Wedding*)wd;
-(UIImage*)getImage:(NSString*)imageName;
-(NSError*)saveImage:(UIImage*)image withName:(NSString*)imageName;

@end

@interface WeddingModel : Model {
    id<WeddingModelProtocol> modelImpl;
}

+(WeddingModel*)instance;

-(void)getWeddingsHostGuest:(void(^)(NSArray*))block;
-(void)getWedding:(NSString*)wdId block:(void(^)(Wedding*))block;
-(void)addWedding:(Wedding*)wd block:(void(^)(NSError*))block;
-(void)addWeddingGuests:(NSArray*)usIds toWedding:(Wedding*)wd block:(void(^)(NSError*))block;
-(void)deleteWedding:(Wedding*)wd block:(void(^)(NSError*))block;
-(void)getImage:(Wedding*)pto block:(void(^)(UIImage*))block;
-(void)saveImage:(Wedding*)pto image:(UIImage*)image block:(void(^)(NSError*))block;

@end
