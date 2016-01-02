//
//  RegisterViewController.h
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *UserNameF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordF;
@property (weak, nonatomic) IBOutlet UITextField *fNameF;
@property (weak, nonatomic) IBOutlet UITextField *lNameF;
@property (weak, nonatomic) IBOutlet UITextField *phoneF;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndic;

- (IBAction)register:(id)sender;
@end
