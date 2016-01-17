//
//  APPViewController.h
//  CameraApp
//
//  Created by Rafael Garcia Leiva on 10/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getPhotoDelegate <NSObject>

-(void)onSave:(NSURL*)url uiImage:(UIImage*)uiImageuiImage;

@end

@interface APPViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property id<getPhotoDelegate> delegate;
@property NSURL* referenceUrl;
@property UIImage* uiImage;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;

- (IBAction)onSave:(id)sender;

@end
