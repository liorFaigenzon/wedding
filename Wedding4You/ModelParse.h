//
//  ModelParse.h
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ModelParse : NSObject 

-(UIImage*)getImage:(NSString*)imageName;
-(NSError*)saveImage:(UIImage*)image withName:(NSString*)imageName;

@end
