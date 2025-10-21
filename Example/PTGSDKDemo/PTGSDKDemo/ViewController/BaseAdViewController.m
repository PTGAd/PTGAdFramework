//
//  BaseAdViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import "BaseAdViewController.h"
#import <Masonry/Masonry.h>

@interface BaseAdViewController ()


@end

@implementation BaseAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.showButton];
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@275);
    }];
    
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom).offset(-80);
        make.width.equalTo(@150);
    }];
    
    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom).offset(-150);
        make.width.equalTo(@150);
    }];
    
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
