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
    // Do any additional setup after loading the view.
     //CommentModel* xxx = [[CommentModel alloc]init];
   // NSArray* yyy =[xxx getComments];
   // [self commentToField:[yyy objectAtIndex:0]];
    
    
    
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

- (IBAction)cancel:(id)sender {
    [self.delegate onCancel];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)commentToField:(Comment*)comment{
    self.titlestr = comment.title;
    self.date = comment.date;
    self.comment = comment.comment;
    //self.iGrtId = comment.grtId;
}

- (IBAction)OnSave:(id)sender {
    //CommentModel* xxx = [[CommentModel alloc]init];
    //Comment* comment = [[Comment alloc] init:@"new" title:self.iTitle.text date:self.iDate.date comment:self.iComment.text grtId:self.iGrtId.text];
    //[xxx addComment:(Comment *)xxx];
    //[self.delegate onSave:comment];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)clear:(id)sender {
    self.iTitle.text = @"";
    //self.iDate.text = @"";
    self.iComment.text = @"";
     self.iGrtId.text = @"";
}

@end
