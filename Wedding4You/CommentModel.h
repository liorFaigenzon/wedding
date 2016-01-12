//
//  CommentsModel.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Comment.h"
#import <UIKit/UIKit.h>

@protocol CommentProtocol <NSObject>

-(void)addComment:(Comment*)cmt;
-(void)deleteComment:(Comment*)cmt;
-(Comment*)getComment:(NSString*)cmtId;
-(NSArray*)getCommentsForGreeting:(NSString*)grtId;

@end


@protocol GetCommentsListener <NSObject>

-(void)done:(NSArray*)data;

@end

@interface CommentModel : NSObject
{
    id<CommentProtocol> commentImpl;
}

+(CommentModel*)instance;

-(void)addComment:(Comment*)cmt block:(void(^)(NSError*))block;
-(void)deleteComment:(Comment*)cmt block:(void(^)(NSError*))block;
-(void)getComment:(NSString*)cmtId block:(void(^)(Comment*))block;
-(NSArray*)getCommentsForGreeting:(NSString*)grtId;
-(void)getAsynch:(NSString*)grtId block:(void(^)(NSArray*))block;

@end


