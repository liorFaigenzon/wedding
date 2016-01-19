//
//  LoginParse.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "LoginParse.h"
#import <Parse/Parse.h>
#import "WeddingParse.h"


@implementation LoginParse

-(NSString*)getCurrentUser{
    PFUser* user = [PFUser currentUser];
    if (user != nil) {
        return user.username;
    }else{
        return nil;
    }
}

-(User*)getCurrentUserDetails{
    PFUser* user = [PFUser currentUser];
    if (user != nil) {
        return [[User alloc] init:user.objectId fname:user[@"fname"] lName:user[@"lname"] phone:user[@"phone"]];
    }else{
        return nil;
    }
}

-(NSString*)getCurrentId{
    PFUser* user = [PFUser currentUser];
    if (user != nil) {
        return user.objectId;
    }else{
        return nil;
    }
}

-(BOOL)login:(NSString*)user pwd:(NSString*)pwd{
    NSError* error;
    PFUser* puser = [PFUser logInWithUsername:user password:pwd error:&error];
    if (error == nil && puser != nil) {
        return YES;
    }
    return NO;
}

-(BOOL)signup:(NSString*)user pwd:(NSString*)pwd usDetails:(User*)usDeatils{
    NSError* error;
    PFUser* puser = [PFUser user];
    puser.username = user;
    puser.password = pwd;
    puser[@"fname"] = usDeatils.fName;
    puser[@"lname"] = usDeatils.lName;
    puser[@"phone"] = usDeatils.phone;
    return [puser signUp:&error];
}

-(void)logout{
    [PFUser logOut];
}

@end
