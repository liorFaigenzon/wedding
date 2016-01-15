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
-(void)onUpdate:(Comment*)newCom;
-(void)onCancel;

@end

@interface CommentViewController : UIViewController

@property id<NewCommentDelegate> delegate;

@property NSString* cmtId;
@property NSString* titlestr;
@property NSDate* date;
@property NSString* comment;
@property NSString* grtId;
@property Comment* workComment;

@property (weak, nonatomic) IBOutlet UITextField *iTitle;
@property (weak, nonatomic) IBOutlet UIDatePicker *iDate;
@property (weak, nonatomic) IBOutlet UITextField *iComment;
@property (weak, nonatomic) IBOutlet UITextField *iGrtId;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)commentToField:(Comment*)comment;

@end