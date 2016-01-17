//
//  CommentViewController.h
//  Wedding4You
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "CommentModel.h"

@protocol NewCommentDelegate <NSObject>

-(void)onSave:(Comment*)newCom;

@end

@interface CommentViewController : UIViewController

@property id<NewCommentDelegate> delegate;

@property Comment* workComment;

@property (weak, nonatomic) IBOutlet UITextField *iTitle;
@property (weak, nonatomic) IBOutlet UITextView *iComment;

- (IBAction)cancel:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)clear:(id)sender;
//- (IBAction)commentToField:(Comment*)comment;

@end