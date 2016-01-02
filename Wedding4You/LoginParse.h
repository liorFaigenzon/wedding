//
//  LoginParse.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "ModelParse.h"
#import "User.h"

@interface LoginParse : ModelParse

-(BOOL)login:(NSString*)user pwd:(NSString*)pwd;
-(BOOL)signup:(NSString*)user pwd:(NSString*)pwd usDetails:(User*)usDeatils;
-(void)logout;
-(NSString*)getCurrentUser;

@end
