//
//  LoginViewController.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *UserNameF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordF;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;
@property (weak, nonatomic) IBOutlet UIImageView *testImage;

//- (IBAction)Register:(id)sender;
- (IBAction)login:(id)sender;

@end
