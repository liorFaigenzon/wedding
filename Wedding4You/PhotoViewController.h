//
//  ViewController.h
//  Wedding4You
//
//  Created by Admin on 12/20/15.
//  Copyright © 2015 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "PhotoModel.h"

@protocol NewPhotoDelegate <NSObject>

-(void)onSave:(Photo*)newPhoto;

@end

@interface PhotoViewController : UIViewController

@property id<NewPhotoDelegate> delegate;

@property Photo* workPhoto;

@property (weak, nonatomic) IBOutlet UILabel* ltitle;
@property (weak, nonatomic) IBOutlet UITextView* descriptionPt;
@property (weak, nonatomic) IBOutlet UILabel* date;
@property (weak, nonatomic) IBOutlet UIImageView* image;

- (IBAction)cancel:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)clear:(id)sender;

@end
