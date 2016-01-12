//
//  GreetingsModel.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Greeting.h"
#import <UIKit/UIKit.h>

@protocol GreetingProtocol <NSObject>

-(NSError*)addGreeting:(Greeting*)grt;
-(NSError*)deleteGreeting:(Greeting*)grt;
-(Greeting*)getGreeting:(NSString*)grtId;
-(NSArray*)getGreetingsforWedding:(NSString*)wdId;

@end


@protocol GetGreetingsListener <NSObject>

-(void)done:(NSArray*)data;

@end

@interface GreetingModel : NSObject
{
    id<GreetingProtocol> greetingParseImpl;
    id<GreetingProtocol> SqlImpl;
}

+(GreetingModel*)instance;

-(void)addGreeting:(Greeting*)grt block:(void(^)(NSError*))block;
-(void)deleteGreeting:(Greeting*)grt block:(void(^)(NSError*))block;
-(void)getGreeting:(NSString*)grtId block:(void(^)(Greeting*))block;
-(NSArray*)getGreetingsforWedding:(NSString*)wdId;
-(void)getAsynch:(NSString*)wdId block:(void(^)(NSArray*))block;

@end


