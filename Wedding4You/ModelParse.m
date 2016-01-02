//
//  ModelParse.m
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "ModelParse.h"
#import <Parse/Parse.h>

@implementation ModelParse

-(id)init{
    self = [super init];
    if (self) {
        [Parse setApplicationId:@"KQZXfRKACbu5xSnmCBa1r01xstfBO8I3ppWMqkjl"
                      clientKey:@"ZgD983FsRtjTmi9rZW9fVIBryfODNfqomZxlAC2s"];

    }
    return self;
}

@end
