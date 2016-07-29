//
//  ZCAddTagViewController.m
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCAddTagViewController.h"
#import "ZCTagButton.h"
@interface ZCAddTagViewController ()
@property (nonatomic,weak) UIView *contentView;
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,weak) UITextField *textField;
@property (nonatomic,strong) NSMutableArray *tagButtons;
@end

@implementation ZCAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextField];
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
- (void)done
{
    ZCLogFunc;
}
- (void)setupContentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.x = ZCTagMargin;
    contentView.width = self.view.width-2*contentView.x;
    contentView.y = 64+ZCTagMargin;
    contentView.height = ZCScreenH;
    [self.view addSubview:contentView];
    self.contentView =contentView;
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc]init];
    textField.width = ZCScreenW;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

- (void)textFieldClick:(UITextField *)textField
{
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame)+ZCTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签：%@",textField.text] forState:UIControlStateNormal];
    }
    else{
        self.addButton.hidden = YES;
    }
    [self updateTagButtonFrame];
}


- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, ZCTagMargin, 0, ZCTagMargin);
        addButton.backgroundColor = ZCTagBg;
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}
#pragma mark 添加标签按钮点击
- (void)addButtonClick
{
    ZCTagButton *tagButton = [ZCTagButton buttonWithType:UIButtonTypeCustom];

    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];

    [self.tagButtons addObject:tagButton];
    [self updateTagButtonFrame];
    self.textField.text = nil;
    self.addButton.hidden = YES;
}

- (void)tagButtonClick:(ZCTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
}
#pragma mark 跟新标签按钮的frame
- (void)updateTagButtonFrame
{
    for (NSInteger i=0; i<self.tagButtons.count; i++) {
        ZCTagButton *tagButton = self.tagButtons[i];
        if (i==0) {
            tagButton.x = 0;
            tagButton.y = 0;
        }else{
            ZCTagButton *lastTagButton = self.tagButtons[i-1];
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame)+ZCTagMargin;
            CGFloat rightWidth = self.contentView.width-leftWidth;
            if (rightWidth>=tagButton.width) {
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            }else{
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame)+ZCTagMargin;
            }
        }
    }
    ZCTagButton *lastTagButton = [self.tagButtons lastObject];
    ZCLog(@"%@",lastTagButton);
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame)+ZCTagMargin;
    if (self.contentView.width-leftWidth>=[self textFieldTextwidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame)+ZCTagMargin;
    }

}

- (CGFloat)textFieldTextwidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}
-(NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
@end
