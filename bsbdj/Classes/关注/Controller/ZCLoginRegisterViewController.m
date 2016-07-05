//
//  ZCLOginRegisterViewController.m
//  bsbdj
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCLoginRegisterViewController.h"

@interface ZCLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeftMargin;

@end

@implementation ZCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    self.view.backgroundColor = ZCGlobalBg;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showRigesteLogin:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.layoutLeftMargin.constant==0)
    {
        self.layoutLeftMargin.constant = -self.view.width;
        sender.selected =YES;
    }
    else
    {
        self.layoutLeftMargin.constant =0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
