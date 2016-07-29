//
//  ZCPlaceholderTextView.m
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCPlaceholderTextView.h"
@interface ZCPlaceholderTextView()
@property (nonatomic,weak)UILabel *placeholderLabel;
@end
@implementation ZCPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        [ZCNotetCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}
- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
}
- (void)dealloc
{
    [ZCNotetCenter removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.width = self.width-2*self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

@end
