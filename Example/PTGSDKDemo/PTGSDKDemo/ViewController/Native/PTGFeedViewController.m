//
//  PTGFeedViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/5/19.
//

#import "PTGFeedViewController.h"
#import "PTGNativeExpressFeedViewController.h"
#import "PTGFeedDelayDisplayViewController.h"

@interface PTGFeedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray<NSString *> *dataSource;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PTGFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"自渲染list",@"模版list",@"延迟展示自渲染",@"延迟展示模板"];
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
    } else {
        PTGFeedDelayDisplayViewController *vc = [[PTGFeedDelayDisplayViewController alloc] init];
        vc.isNativeExpress = YES;
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
