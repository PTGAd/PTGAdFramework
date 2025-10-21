//
//  PTGFeedViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/5/19.
//

#import "PTGFeedViewController.h"
#import "PTGNativeExpressFeedViewController.h"
#import "PTGFeedDelayDisplayViewController.h"
#import "PTGNativeExpressInScrollViewController.h"
#import "PTGNativeExpressCollectionWaterfallViewController.h"
#import "PTGNativeExpressCollectionHorizontalViewController.h"
#import "PTGNativeExpressCollectionVerticalViewController.h"
#import "PTGVideoControlDemoViewController.h"
#import "PTGFeedPeriodicRequestViewController.h"
#import "PTGNativeCountViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>

@interface PTGFeedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray<NSString *> *dataSource;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PTGFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"自渲染list",
                        @"模版list",
                        @"延迟展示自渲染",
                        @"延迟展示模板",
                        @"自渲染scroll",
                        @"模板scroll",
                        @"自渲染瀑布流",
                        @"模版瀑布流",
                        @"自渲染水平CollectionView",
                        @"模板水平CollectionView",
                        @"自渲染垂直CollectionView",
                        @"模板垂直CollectionView",
                        @"视频播放控制Demo(自渲染)",
                        @"视频播放控制Demo(模板)",
                        @"每10秒请求广告Demo",
                        @"多次请求自渲染",
                        @"多次请求模板"];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PTGNativeExpressFeedViewController *vc = [[PTGNativeExpressFeedViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeSelfRender;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        PTGNativeExpressFeedViewController *vc = [[PTGNativeExpressFeedViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeFeed;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        PTGFeedDelayDisplayViewController *vc = [[PTGFeedDelayDisplayViewController alloc] init];
        vc.isNativeExpress = NO;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        PTGFeedDelayDisplayViewController *vc = [[PTGFeedDelayDisplayViewController alloc] init];
        vc.isNativeExpress = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        PTGNativeExpressInScrollViewController *vc = [[PTGNativeExpressInScrollViewController alloc] init];
        vc.isNativeExpress = NO;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5){
        PTGNativeExpressInScrollViewController *vc = [[PTGNativeExpressInScrollViewController alloc] init];
        vc.isNativeExpress = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 6) {
        PTGNativeExpressCollectionWaterfallViewController *vc = [[PTGNativeExpressCollectionWaterfallViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeSelfRender;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 7) {
        PTGNativeExpressCollectionWaterfallViewController *vc = [[PTGNativeExpressCollectionWaterfallViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeFeed;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 8) {
        PTGNativeExpressCollectionHorizontalViewController *vc = [[PTGNativeExpressCollectionHorizontalViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeSelfRender;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 9) {
        PTGNativeExpressCollectionHorizontalViewController *vc = [[PTGNativeExpressCollectionHorizontalViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeFeed;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 10) {
        PTGNativeExpressCollectionVerticalViewController *vc = [[PTGNativeExpressCollectionVerticalViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeSelfRender;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 11) {
        PTGNativeExpressCollectionVerticalViewController *vc = [[PTGNativeExpressCollectionVerticalViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeFeed;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 12) {
        PTGVideoControlDemoViewController *vc = [[PTGVideoControlDemoViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeSelfRender;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 13) {
        PTGVideoControlDemoViewController *vc = [[PTGVideoControlDemoViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeFeed;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 14) {
        PTGFeedPeriodicRequestViewController *vc = [[PTGFeedPeriodicRequestViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 15) {
        PTGNativeCountViewController *vc = [[PTGNativeCountViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeSelfRender;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 16) {
        PTGNativeCountViewController *vc = [[PTGNativeCountViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeFeed;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}



@end
