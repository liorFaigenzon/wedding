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

-(void)addGreeting:(Greeting*)grt;
-(void)deleteGreeting:(Greeting*)grt;
-(Greeting*)getGreeting:(NSString*)grtId;
-(NSArray*)getGreetings;

@end


@protocol GetGreetingsListener <NSObject>

-(void)done:(NSArray*)data;

@end

@interface GreetingModel : NSObject
{
    id<GreetingProtocol> greetingImpl;
}

+(GreetingModel*)instance;

-(void)addGreeting:(Greeting*)grt;
-(void)deleteGreeting:(Greeting*)grt;
-(Greeting*)getGreeting:(NSString*)grtId;
-(NSArray*)getGreetings;
-(void)getAsynch:(void(^)(NSArray*))blockListener;

@end


