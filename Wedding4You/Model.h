//
//  Model.h
//  Wedding4You
//
//  Created by Alon Geffen on 15/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Model : NSObject

-(void)savingImageToFile:(UIImage*)image fileName:(NSString*)fileName;
-(UIImage*)readingImageFromFile:(NSString*)fileName;
-(NSString*)getLocalFilePath:(NSString*)fileName;
-(void)saveToFile:(NSData*)data fileName:(NSString*)fileName;
-(NSData*)readFromFile:(NSString*)fileName;

@end
