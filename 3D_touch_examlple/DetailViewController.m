//
//  DetailViewController.m
//  3D_touch_examlple
//
//  Created by wsy on 15/12/27.
//  Copyright © 2015年 WSY. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    self.title = self.detailTitle;
    
    self.textLabel.text = @"我是预览的内容";

}

- (void)createUI
{
    CGRect rect = self.view.frame;
    rect.size.height = 300;
    _textLabel = [[UILabel alloc] initWithFrame:rect];
    _textLabel.numberOfLines = 0;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_textLabel];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_textLabel.frame), self.view.frame.size.width-40, 200)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    _imageView.image = [UIImage imageNamed:@"fy1.jpg"];
    [self.view addSubview:_imageView];
}

// 这里主要是显示 peek action，当手指向上移动的时候，出现的按钮
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *previewActionReply = [self createPreviewActionWithTitle:@"回复" style:UIPreviewActionStyleDefault];
    
    UIPreviewAction *previewActionDelete = [self createPreviewActionWithTitle:@"删除" style:UIPreviewActionStyleDestructive];
    
    UIPreviewAction *previewActionComment = [self createPreviewActionWithTitle:@"留言" style:UIPreviewActionStyleSelected];
    
    // 这是一个分组，当点击更多的时候，会弹出子菜单，删除和留言
    UIPreviewActionGroup *groupAction = [UIPreviewActionGroup actionGroupWithTitle:@"更多" style:UIPreviewActionStyleDestructive actions:@[previewActionDelete, previewActionComment]];
    
    return @[previewActionReply, groupAction];
}

- (UIPreviewAction *)createPreviewActionWithTitle:(NSString *)title style:(UIPreviewActionStyle)style
{
    UIPreviewAction *previewAction1 = [UIPreviewAction actionWithTitle:title style:style handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"click %@", title);
    }];
    return previewAction1;
}


@end
