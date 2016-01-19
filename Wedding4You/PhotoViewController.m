//
//  ViewController.m
//  Wedding4You
//
//  Created by Admin on 12/20/15.
//  Copyright © 2015 Faigenzon. All rights reserved.
//

#import "PhotoViewController.h"


@interface PhotoViewController ()

@end

@implementation PhotoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *result = [formatter stringFromDate:(NSDate *)self.workPhoto.date];
    
    Photo* pto = self.workPhoto;
    self.ltitle.text = pto.title;
    self.descriptionPt.text = pto.descriptionPt;
    self.date.text = result;
    //self.image.image = [UIImage imageNamed:pto.imageName];
    
    // Fetch the image by name
    _image.image = nil;
    [[self activityIndic] startAnimating];
    if(pto.imageName != nil && ![pto.imageName isEqualToString:@""]){
        [[PhotoModel instance] getImage:pto block:^(UIImage *image) {
            _activityIndic.hidden = YES;
            if (image != nil) {
                [self image].image = image;
                [[self activityIndic] stopAnimating];
            }else{
                [self image].image = [UIImage imageNamed:@"no_photo.jpg"];
            }
        }];
    }else{
        [self image].image = [UIImage imageNamed:@"no_photo.jpg"];
    }
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
    //Comment* comment = [[Comment alloc] init:@"new" title:self.iTitle.text date:[NSDate date] comment:self.iComment.text grtId:@"A65KUSpgEE" usId:@"0dT4ALBdYJ"];
    //[self.delegate onSave:comment];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)clear:(id)sender {
    //self.iTitle.text = @"";
    //self.iComment.text = @"";
}
@end
