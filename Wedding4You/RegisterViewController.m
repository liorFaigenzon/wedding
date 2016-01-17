//
//  RegisterViewController.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginModel.h"
#import "User.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityIndic.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)register:(id)sender {
    [self.activityIndic startAnimating];
    self.activityIndic.hidden = NO;
    
    User* usDetails = [[User alloc] init:nil fname:self.fNameF.text lName:self.lNameF.text phone:self.phoneF.text];
    
    [[LoginModel instance] signup:self.UserNameF.text pwd:self.PasswordF.text usDetails:usDetails block:^(BOOL res) {
        self.activityIndic.hidden = YES;
        if (res) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
