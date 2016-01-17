//
//  DetailWeddingViewController.m
//  Wedding4You
//
//  Created by Alon Geffen on 15/01/2016.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "DetailWeddingViewController.h"
#import "WeddingModel.h"
#import "Utilities.h"

@interface DetailWeddingViewController ()

@end

@implementation DetailWeddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self navigationItem].title = [NSString stringWithFormat:@"%@ %@'s wedding", [self wedding].usCouple.fName, [self wedding].usCouple.lName];
    
    // Load wedding details to properties
    [self marriedCouple].text = [NSString stringWithFormat:@"%@ %@", [self wedding].usCouple.fName, [self wedding].usCouple.lName];
    [self date].text = [Utilities getDateStringFromDate:[self wedding].date];
    _imageName = [self wedding].imageName;
    
    // Fetch the image by name
    _image.image = nil;
    [[self activityIndic] startAnimating];
    if([self imageName] != nil && ![[self imageName] isEqualToString:@""]){
        [[WeddingModel instance] getImage:[self wedding] block:^(UIImage *image) {
            _activityIndic.hidden = YES;
            if (image != nil) {
                [self image].image = image;
                [[self activityIndic] stopAnimating];
            }else{
                [self image].image = [UIImage imageNamed:@"wedding.jpg"];
            }
        }];
    }else{
        [self image].image = [UIImage imageNamed:@"wedding.jpg"];
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

@end