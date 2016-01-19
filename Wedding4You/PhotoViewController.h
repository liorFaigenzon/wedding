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

@interface PhotoViewController : UIViewController

@property Photo* workPhoto;
@property (weak, nonatomic) IBOutlet UILabel* ltitle;
@property (weak, nonatomic) IBOutlet UITextView* descriptionPt;
@property (weak, nonatomic) IBOutlet UILabel* date;
@property (weak, nonatomic) IBOutlet UIImageView* image;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;

- (IBAction)cancel:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)clear:(id)sender;

@end
