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
    // Do any additional setup after loading the view.
    //GreetingDetailViewController* parent = self.sourceViewController;
    
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    
    CommentsTableViewController* child = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentTableViewController"];
    
    //connect between the parent VC to the Child VC
    
    
    //set the displa of the child view inside his parent
    CGRect frame = child.view.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    child.view.frame =frame;
    scrollView.frame = frame;
    
    [self addChildViewController:child];
   [self.ViewContainer addSubview:scrollView];
   [scrollView addSubview:child.view];
    

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
