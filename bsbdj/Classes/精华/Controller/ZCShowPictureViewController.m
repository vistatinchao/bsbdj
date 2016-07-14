//
//  ZCShowPictureViewController.m
//  bsbdj
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCShowPictureViewController.h"
#import "ZCProgressView.h"
#import "ZCTopic.h"
@interface ZCShowPictureViewController ()
@property (weak, nonatomic) IBOutlet ZCProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak,nonatomic)UIImageView *imageView;

@end

@implementation ZCShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;

    CGFloat pictureW = ZCScreenW;
    CGFloat pictureH = pictureW *self.topic.height/self.topic.width;
    if (pictureH>ZCScreenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        //imageView.centerY = ZCScreenH*0.5;
    }
    else
    {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = ZCScreenH*0.5;
    }

    [self.progressView setProgress:self.topic.picturePregress animated:YES];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0*receivedSize/expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];


}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save
{
    if (self.imageView.image==nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没有下载完毕"];
        return;
    }

    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishWithError:(NSError *)error contextInfo:(void *)context
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];


}



@end
