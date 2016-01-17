//
//  LoginViewController.m
//  Wedding4You
//
//  Created by Alon Geffen on 02/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"
#import "Photo.h"
#import "PhotoModel.h"
#import "WeddingModel.h"
#import "User.h"
#import "GreetingModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityIndic.hidden = YES;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    /*
    UIImage* image = [UIImage imageNamed:@"ashton.jpeg"];
    Photo* xxx = [[Photo alloc] init:@"XXX2" title:@"Tile" date:[NSDate date] descriptionPt:@"des" imageName:@"ashton.jpeg"];
    
        Photo* yyy = [[Photo alloc] init:@"X" title:@"Tile" date:[NSDate date] descriptionPt:@"des" imageName:@"img"];
        Photo* zzz = [[Photo alloc] init:@"XXX" title:@"Tile" date:[NSDate date] descriptionPt:@"des" imageName:@"img"];
    
    [[PhotoModel instance] addPhoto:(Photo *)xxx];
    [[PhotoModel instance] saveImage:xxx image:image block:^(NSError* err) {
        NSLog([err localizedDescription]);
    }];
    [[PhotoModel instance] addPhoto:(Photo *)yyy];
    [[PhotoModel instance] addPhoto:(Photo *)zzz];
    [[PhotoModel instance] delete:(Photo *)yyy ];
    [[PhotoModel instance] getPhoto:(NSString *)];
    [[PhotoModel instance] getImage:[[PhotoModel instance] getPhoto:@"PS8R716WtH"] block:^(UIImage* img) {
        [self.testImage initWithImage:img];
    }];
     */
    
    //[[GreetingModel instance] getGreeting:@"m376FXBY9u" block:^(Greeting* outerGrt) {
    //    NSLog(outerGrt.wdId);
    //}];
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

- (IBAction)login:(id)sender {
    [self.activityIndic startAnimating];
    self.activityIndic.hidden = NO;
    [[LoginModel instance] login:self.UserNameF.text pwd:self.PasswordF.text block:^(BOOL res) {
        self.activityIndic.hidden = YES;
        if (res) {
            //[self.navigationController pushViewController:self animated:YES];
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        }
    }];
}
@end
