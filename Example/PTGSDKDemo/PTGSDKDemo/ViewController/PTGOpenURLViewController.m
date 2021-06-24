//
//  PTGOpenURLViewController.m
//  PTGSDKDemo
//
//  Created by taoyongjiu on 2021/4/28.
//

#import "PTGOpenURLViewController.h"
#import <Masonry/Masonry.h>
@interface PTGOpenURLViewController ()

@property(nonatomic,strong)UIButton *loadButton;
@property(nonatomic,strong)UITextView *textView;

@end

@implementation PTGOpenURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"fancympsdk://loadAd?slotId=900000245&type=1";
    textView.frame = CGRectMake(20, 100, self.view.bounds.size.width - 40, 100);
    self.textView = textView;
    [self.view addSubview:textView];
    
    [self.view addSubview:self.loadButton];
    
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
}

- (void)buttonClicked:(UIButton *)button {
    if (self.textView.text.length == 0) {
        return;
    }
    NSString *urlString = self.textView.text;
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


- (UIButton *)loadButton {
    if (!_loadButton) {
        _loadButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton setTitle:@"加载广告" forState:UIControlStateNormal];
        [_loadButton setBackgroundColor:UIColor.lightGrayColor];
        _loadButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
