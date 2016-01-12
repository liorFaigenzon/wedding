//
//  WeddingModel.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wedding.h"

@protocol WeddingModelProtocol <NSObject>

-(NSArray*)getWeddingsHostGuest:(NSString*)usId;
-(Wedding*)getWedding:(NSString*)wdId;
-(void)addWedding:(Wedding*)wd;
-(void)addWeddingGuests:(NSArray*)usIds toWedding:(Wedding*)wd;
-(void)deleteWedding:(Wedding*)wd;

@end

@interface WeddingModel : NSObject {
    id<WeddingModelProtocol> modelImpl;
}

+(WeddingModel*)instance;

-(void)getWeddingsHostGuest:(NSString*)usId block:(void(^)(NSArray*))block;
-(void)getWedding:(NSString*)wdId block:(void(^)(Wedding*))block;
-(void)addWedding:(Wedding*)wd block:(void(^)(NSError*))block;
-(void)addWeddingGuests:(NSArray*)usIds toWedding:(Wedding*)wd block:(void(^)(NSError*))block;
-(void)deleteWedding:(Wedding*)wd block:(void(^)(NSError*))block;

@end
