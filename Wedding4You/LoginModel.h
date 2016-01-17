//
//  LoginModel.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Model.h"

@interface LoginModel : Model

@property NSString* user;

+(LoginModel*)instance;
-(void)login:(NSString*)user pwd:(NSString*)pwd block:(void(^)(BOOL))block;
-(void)signup:(NSString*)user pwd:(NSString*)pwd usDetails:(User*)usDetails block:(void(^)(BOOL))block;
-(void)logout: (void(^)(void))block;

@end
