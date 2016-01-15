//
//  GreetingViewController.m
//  Wedding4You
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//

#import "GreetingViewController.h"

@interface GreetingViewController ()

@end

@implementation GreetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //GreetingModel* xxx = [[GreetingModel alloc]init];
    // NSArray* yyy =[xxx getGreetings];
    // [self GreetingToField:[yyy objectAtIndex:0]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {
    [self.delegate onCancel];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)GreetingToField:(Greeting*)Greeting{
    //self.Grtitlestr = Greeting.title;
    //self.date = Greeting.date;
    //self.Greeting = Greeting.Greeting;
    //self.iGrtId = Greeting.grtId;
}

//-(id)init:(NSString*)grtId title:(NSString*)title date:(NSDate*)date greeting:(NSString*)greeting wdId:(NSString*)wdId usId:(NSString *)usId;{
   

- (IBAction)OnSave:(id)sender {
    Greeting* greeting = [[Greeting alloc] init:@"new" title:self.iTitle.text date:[NSDate date] greeting:self.iGreeting.text wdId:@"QMJWlc1QI7" usId:@"uiac1YRCiz"];

    [self.delegate onSave:greeting];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)clear:(id)sender {
    self.iTitle.text = @"";
    self.iGreeting.text = @"";

}

@end
