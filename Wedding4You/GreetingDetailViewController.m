//
//  GreetingDetailViewController.m
//  Wedding4You
//
//  Created by Admin on 1/17/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "GreetingDetailViewController.h"
#import "CommentsTableViewController.h"


@interface GreetingDetailViewController ()

@end

@implementation GreetingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *result = [formatter stringFromDate:(NSDate *)self.greetingToShow.date];
    
    self.titleGRT.text = [NSString stringWithFormat:@"%@ by /%@", self.greetingToShow.title, self.greetingToShow.createdBy.fName];
    self.dateGRT.text =result;
    self.greetingGRT.text =self.greetingToShow.greeting;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GreetingDetailSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        CommentsTableViewController *firmyVC = (CommentsTableViewController *)nav.topViewController;
        firmyVC.grtId = self.greetingToShow.grtId;
    }
}


@end
