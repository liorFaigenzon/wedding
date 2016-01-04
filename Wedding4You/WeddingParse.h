//
//  WeddingParse.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelParse.h"
#import "Wedding.h"

@interface WeddingParse : ModelParse

-(void)addWeddingGuest:(NSString*)usId toWedding:(NSString*)wdId;
-(void)addWedding:(Wedding*)wedding;
-(NSArray*)getWeddingsHostGuest:(NSString*)usId;

@end
