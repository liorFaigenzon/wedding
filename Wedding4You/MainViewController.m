//
//  MainViewController.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "MainViewController.h"
#import "LoginModel.h"
#import "WeddingModel.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityIndic.hidden = YES;
    
    
    //User* usr = [[User alloc] init:@"Alon" lName:@"Geffen" phone:@"0526833684"];
    //Wedding* wd = [[Wedding alloc] init:@"12" usCouple:[LoginModel user]];
    /*[[WeddingModel instance] addWedding:@"1" block:^(NSError * err) {
        NSLog(@"Success");
    }];
    [[WeddingModel instance] addWedding:@"2" block:^(NSError * err) {
        NSLog(@"Success");
    }];
    [[WeddingModel instance] addWedding:@"3" block:^(NSError * err) {
        NSLog(@"Success");
    }];
    [[WeddingModel instance] addWeddingGuest:@"NwxVBoV8wJ" toWedding:@"1" block:^(NSError* err) {
        NSLog(@"Success");
    }];
    [[WeddingModel instance] addWeddingGuest:@"NwxVBoV8wJ" toWedding:@"2" block:^(NSError* err) {
        NSLog(@"Success");
    }];*/
    [[WeddingModel instance] getWeddingsHostGuest:@"NwxVBoV8wJ" block:^(NSArray* guests) {
        NSLog(@"Success");
    }];
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

- (IBAction)logout:(id)sender {
    [self.activityIndic startAnimating];
    self.activityIndic.hidden = NO;
    [[LoginModel instance] logout: ^(void) {
        self.activityIndic.hidden = YES;
        [self performSegueWithIdentifier:@"LogoutSeague" sender:self];
    }];
}
@end
