//
//  CommentViewController.m
//  Wedding4You
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancel:(id)sender {
    //[self.delegate onCancel];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)onSave:(id)sender {
    Comment* comment = [[Comment alloc] init:@"new" title:self.iTitle.text date:[NSDate date] comment:self.iComment.text grtId:@"A65KUSpgEE" usId:@"0dT4ALBdYJ"];
    [self.delegate onSave:comment];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)clear:(id)sender {
    self.iTitle.text = @"";
    self.iComment.text = @"";
}

@end
