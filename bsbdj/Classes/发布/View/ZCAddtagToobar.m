//
//  ZCAddtagToobar.m
//  bsbdj
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCAddtagToobar.h"
#import "ZCAddTagViewController.h"
@interface ZCAddtagToobar()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,strong)NSMutableArray *tagLabels;

@end
@implementation ZCAddtagToobar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
- (void)awakeFromNib
{
    UIButton *addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = ZCTagMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
   // 默认有两个标签
    [self creatTagLabels:@[@"吐槽",@"糗事"]];
}

- (void)creatTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];

    for (NSInteger i=0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc]init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = ZCTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = ZCTagFont;
        [tagLabel sizeToFit];
        tagLabel.width +=2*ZCTagMargin;
        tagLabel.height = ZCTagH;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (NSInteger i=0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        if (i==0) {
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{
            UILabel *lastTagLabel= self.tagLabels[i-1];
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame)+ZCTagMargin;
            CGFloat rightWidth = self.topView.width-leftWidth;
            if (rightWidth>=tagLabel.width) {
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            }else{
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame)+ZCTagMargin;
            }

        }
    }
    UILabel *lastTagLabel = self.tagLabels.lastObject;
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame)+ZCTagMargin;
    if (self.topView.width-leftWidth>=self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame)+ZCTagMargin;
    }
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame)+45;
    self.y-=self.height-oldH;


}

- (void)addButtonClick
{
    ZCAddTagViewController *vc = [[ZCAddTagViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    vc.tagsBlock = ^(NSArray *tags){
        [weakSelf creatTagLabels:tags];
    };
    vc.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nvc = (UINavigationController *)root.presentedViewController;
    [nvc pushViewController:vc animated:YES];
}

@end
