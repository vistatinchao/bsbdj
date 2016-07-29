//
//  ZCPostWordViewController.m
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCPostWordViewController.h"
#import "ZCPlaceholderTextView.h"
#import "ZCAddtagToobar.h"
@interface ZCPostWordViewController ()<UITextViewDelegate>
@property (nonatomic,weak)ZCPlaceholderTextView *textView;
@property (nonatomic,weak)ZCAddtagToobar *toolbar;
@end

@implementation ZCPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
    [self setupToobar];
}

- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
    self.navigationItem.rightBarButtonItem.enabled =NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finish
{
    ZCLogFunc;
}
- (void)setupTextView
{
    ZCPlaceholderTextView *textView = [[ZCPlaceholderTextView alloc]init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    textView.delegate = self;
    self.textView = textView;
}

- (void)setupToobar
{
    ZCAddtagToobar *toolbar = [ZCAddtagToobar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    [ZCNotetCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    CGRect keyBoardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyBoardF.origin.y-ZCScreenH);
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled =textView.hasText;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
