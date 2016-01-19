//
//  NewPhotoViewController.h
//  Wedding4You
//
//  Created by Admin on 1/16/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "UserPhoto.h"

@protocol newPhotoDelegate <NSObject>

-(void)onSave:(Photo*)pto uiImage:(UIImage*)uiImage;

@end

//@interface NewPhotoViewController : UIViewController <getPhotoDelegate>
@interface NewPhotoViewController : UIViewController <getPhotoDelegate>

@property id<newPhotoDelegate> delegate;
@property Photo* workPhoto;
@property NSString* wdId;
@property NSString* usId;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField* uititle;
@property (strong, nonatomic) IBOutlet UITextView* descriptionPt;

- (IBAction)savePhoto:(id)sender;

@end