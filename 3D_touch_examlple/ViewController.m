//
//  ViewController.m
//  3D_touch_examlple
//
//  Created by wsy on 15/12/27.
//  Copyright © 2015年 WSY. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate>

@property (strong, nonatomic) NSArray *datas;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = @[@"我们", @"我的3D touch", @"咋么样才能好呢"];
 
    [self createView];
    
    // 判断3D Touch是否可用
    // 当然你可以关闭或打开3D Touch，设置－通用－辅助功能－3D Touch
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)] && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        
        /**
         *  注册用户将要点击的view，来作为soureceView，这里使用 _tableView，当然一个视图控制器
         *  可以注册多个view,注册后将返回一个id<UIViewControllerPreviewing>的对象，这个对象
         *  的生命周期由系统控制，我们不需要管理
         */
      id<UIViewControllerPreviewing> retObj = [self registerForPreviewingWithDelegate:self sourceView:_tableView];
        NSLog(@" === %@", retObj);
        
        /**
         *  如果你想禁用预览，那么可以调用unregisterForPreviewingWithContext: 来禁用
         */
//        [self unregisterForPreviewingWithContext: retObj];

    }
}

- (void)createView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailViewController *detailVC = [storyBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.detailTitle = _datas[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UIViewControllerPreviewingDelegate
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewControllerToCommit];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

/**
 *  当用户点击我们所注册的视图的时候，将出发这个代理
 *
 *  @param previewingContext 上下文对象，用来管理预览预览
 *  @param location          用户点击注册view的位置
 *
 *  @return
 */
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{

    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
    if (!indexPath) {
        return nil;
    }
    
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return nil;
    }
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailViewController *detailVC = [storyBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.detailTitle = _datas[indexPath.row];
    
    /* The preferredContentSize is used for any container laying out a child view controller.
     也就是说设置子视图控制器的preferredContentSize，如果不是子视图控制起，设置这里会导致你所要预览的内容不显示
     */
//    detailVC.preferredContentSize = CGSizeMake(300, 200);
    
    CGRect rect = cell.frame;
    rect.origin.y = cell.frame.origin.y;
    /**
     *  设置sourceRect，用户点击的时候产生一种视觉效果，让用户知道可以peek
     */
    previewingContext.sourceRect = rect;
    
    return detailVC;

}

@end
