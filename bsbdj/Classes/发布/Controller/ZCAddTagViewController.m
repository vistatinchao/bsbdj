//
//  ZCAddTagViewController.m
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCAddTagViewController.h"
#import "ZCTagButton.h"
#import "ZCTagTextField.h"
@interface ZCAddTagViewController ()<UITextFieldDelegate>
@property (nonatomic,weak) UIView *contentView;
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,weak) ZCTagTextField *textField;
@property (nonatomic,strong) NSMutableArray *tagButtons;
@end

@implementation ZCAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
- (void)done
{
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock?:self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.x = ZCTagMargin;
    self.contentView.width = self.view.width-2*self.contentView.x;
    self.contentView.y = 64+ZCTagMargin;
    self.contentView.height = ZCScreenH;

    self.textField.width = self.contentView.width;
    self.addButton.width= self.contentView.width;
    [self setupTags];
}

- (void)setupTags
{
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            self.textField.text = tag;
            [self addButtonClick];
        }
        self.tags = nil;
    }
}
- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc]init];
        [self.view addSubview:contentView];
        self.contentView =contentView;
    }
    return _contentView;
}

- (ZCTagTextField *)textField
{
    if (!_textField) {
        __weak typeof(self)weakSelf = self;
        ZCTagTextField*textField = [[ZCTagTextField alloc]init];
        textField.deleteBlock = ^{
            if (weakSelf.textField.hasText) {
                [weakSelf tagButtonClick:weakSelf.tagButtons.lastObject];
            }
        };
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        self.textField = textField;
    }
    return _textField;
}

- (void)textFieldClick:(UITextField *)textField
{
    [self updateTextFieldFrame];
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame)+ZCTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签：%@",textField.text] forState:UIControlStateNormal];
        // 获取最后一个字符
        NSString *text = self.textField.text;
        NSInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len-1];
        if ([lastLetter isEqualToString:@","]|| [lastLetter isEqualToString:@"，"]) {
            self.textField.text = [text substringToIndex:len-1];
            [self addButtonClick];
        }

    }
    else{
        self.addButton.hidden = YES;
    }
}


- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    if (self.tagButtons.count==5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    ZCTagButton *tagButton = [ZCTagButton buttonWithType:UIButtonTypeCustom];

    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];

    [self.tagButtons addObject:tagButton];

    self.textField.text = nil;
    self.addButton.hidden = YES;

    [self updateTagButtonFrame];
    [self updateTextFieldFrame];

}

- (void)tagButtonClick:(ZCTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
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

}
#pragma mark 跟新textField的frame
- (void)updateTextFieldFrame
{
    ZCTagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame)+ZCTagMargin;
    if (self.contentView.width-leftWidth>=[self textFieldTextwidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame)+ZCTagMargin;
    }
    self.addButton.y = CGRectGetMaxY(self.textField.frame)+ZCTagMargin;

}
#pragma mark textfield的文字宽度
- (CGFloat)textFieldTextwidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}

#pragma mark <TextField 代理方法>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

-(NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

@end
