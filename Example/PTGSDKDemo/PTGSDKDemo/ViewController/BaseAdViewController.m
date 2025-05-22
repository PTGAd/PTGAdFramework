//
//  BaseAdViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import "BaseAdViewController.h"

@interface BaseAdViewController ()


@end

@implementation BaseAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = UIScreen.mainScreen.bounds.size.width;
    CGFloat h = UIScreen.mainScreen.bounds.size.height;
    self.textField.frame = CGRectMake(50, 100, 275, 30);
    self.loadButton.frame = CGRectMake((w - 150) / 2.0, h - 80, 150, 40);
    self.showButton.frame = CGRectMake((w - 150) / 2.0, h - 130, 150, 40);
    [self.view addSubview:self.textField];
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.showButton];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.placeholder = @"请输入广告位id";
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.font = [UIFont systemFontOfSize:14];
    }
    return _textField;
}


- (UIButton *)loadButton {
    if (!_loadButton) {
        _loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loadButton.backgroundColor = [UIColor lightGrayColor];
        [_loadButton setTitle:@"加载广告" forState:UIControlStateNormal];
        [_loadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loadButton addTarget:self action:@selector(loadAd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}

- (UIButton *)showButton {
    if (!_showButton) {
        _showButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showButton.backgroundColor = [UIColor lightGrayColor];
        [_showButton setTitle:@"展示广告" forState:UIControlStateNormal];
        [_showButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showButton addTarget:self action:@selector(showAd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showButton;
}

@end
