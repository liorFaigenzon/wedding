//
//  GreetingViewController.h
//  Wedding4You
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Faigenzon. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Greeting.h"
#import "GreetingModel.h"

@protocol NewGreetingDelegate <NSObject>

-(void)onSave:(Greeting*)newCom;

@end

@interface GreetingViewController : UIViewController

@property id<NewGreetingDelegate> delegate;

@property Greeting* workGreeting;

@property (weak, nonatomic) IBOutlet UITextField *iTitle;
@property (weak, nonatomic) IBOutlet UITextView *iGreeting;




- (IBAction)cancel:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)GreetingToField:(Greeting*)Greeting;

@end