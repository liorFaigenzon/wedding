//
//  LoginViewController.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityIndic.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([LoginModel instance].user != nil) {
        [self performSegueWithIdentifier:@"LoginSegue" sender:self];
    }
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

- (IBAction)Login:(id)sender {
    [self.activityIndic startAnimating];
    self.activityIndic.hidden = NO;
    [[LoginModel instance] login:self.UserNameF.text pwd:self.PasswordF.text block:^(BOOL res) {
        self.activityIndic.hidden = YES;
        if (res) {
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        }
    }];
}

/*
- (IBAction)Register:(id)sender {
    [self.activityIndic startAnimating];
    self.activityIndic.hidden = NO;
    [[LoginModel instance] signup:self.UserNameF.text pwd:self.PasswordF.text block:^(BOOL res) {
        self.activityIndic.hidden = YES;
        if (res) {
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        }
    }];
}*/

@end
