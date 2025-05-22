//
//  AdConfigViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import "AdConfigViewController.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <PTGAdSDK/PTGAdSDK.h>

@interface AdConfigViewController ()

@property(nonatomic,strong)UIButton *confirmButton;
@property(nonatomic,strong)UILabel *errorTip;
@property(nonatomic,strong)UISwitch *on;

@end

@implementation AdConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat x = (UIScreen.mainScreen.bounds.size.width - 300) / 2;
    self.appIdTextFiled.frame = CGRectMake(x, 100, 300, 30);
    self.keyTextFiled.frame = CGRectMake(x, 150, 300, 30);
    self.idfaTextFiled.frame = CGRectMake(x, 200, 300, 30);
    self.caidTextFiled.frame = CGRectMake(x, 250, 300, 30);
    self.caidVersionTextFiled.frame = CGRectMake(x, 300, 300, 30);
    self.lastCaidTextFiled.frame = CGRectMake(x, 350, 300, 30);
    self.lastCaidVersionTextFiled.frame = CGRectMake(x, 400, 300, 30);
    self.aliAaidTextFiled.frame = CGRectMake(x, 450, 300, 30);
    self.confirmButton.frame = CGRectMake(100, 500, 175, 30);
    self.errorTip.frame = CGRectMake(50, 535, 425, 30);
    self.on.frame = CGRectMake(50, 575, 30, 50);

    
    [self.view addSubview:self.appIdTextFiled];
    [self.view addSubview:self.keyTextFiled];
    [self.view addSubview:self.aliAaidTextFiled];
    [self.view addSubview:self.idfaTextFiled];
    [self.view addSubview:self.caidTextFiled];
    [self.view addSubview:self.caidVersionTextFiled];
    [self.view addSubview:self.lastCaidTextFiled];
    [self.view addSubview:self.lastCaidVersionTextFiled];
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.errorTip];
    [self.view addSubview:self.on];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)initAdSDK {
    NSString *appid = self.appIdTextFiled.text.length > 0 ? self.appIdTextFiled.text : @"45271";
    NSString *appSecret = self.keyTextFiled.text.length > 0 ? self.keyTextFiled.text : @"Y6yyc3zyP3EO9ol8";
    
    /// appKey  Ptg后台创建的媒体⼴告位ID
    /// appSecret Ptg后台创建的媒体⼴告位密钥
    //  45227 1r8hOksXStGASHrp com.bmlchina.driver
    NSString *idfa = self.idfaTextFiled.text.length > 0 ? self.idfaTextFiled.text : [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    NSString *caid = self.caidTextFiled.text;               // 广协caid 建议传递，提升填充及收益
    NSString *caidVersion = self.caidVersionTextFiled.text;   // 你的广协caid veriosn 提升填充及收益
    NSString *lastCaid = self.lastCaidTextFiled.text;               // 广协caid 建议传递，提升填充及收益
    NSString *lastCaidVersion = self.lastCaidVersionTextFiled.text;   // 你的广协caid veriosn 提升填充及收益
    NSString *ali_aaid = self.aliAaidTextFiled.text;  // 需要对接阿里aaid sdk/api
    
    /// 避免代码中明文出现caid ali_id等字符 审核相关
    [PTGSDKManager setAdIds:@{
        @"idfa":idfa,
        @"one_id":caid,
        @"one_id_version": caidVersion,
        @"last_id": lastCaid,
        @"last_id_version": lastCaidVersion,
        @"one_ali_id": ali_aaid
    }];
    
    if (self.on.isOn) {
        [PTGSDKManager setAdLogo:[UIImage imageNamed:@"at_offer_logo_us"]];
    }

    [PTGSDKManager setAppKey:appid appSecret:appSecret completion:^(BOOL result,NSError *error) {
        self.errorTip.hidden = result;
        if (result) {
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing: YES];
}

- (void)requestIdfa {
    
}

- (void)confirm:(UIButton *)sender {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                {
                    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self initAdSDK];
                    });
                }
                    break;
                default:
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self initAdSDK];
                    });
                    break;
            }
        }];
    } else {
        [self initAdSDK];
    }

}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.backgroundColor = [UIColor lightGrayColor];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


- (UITextField *)appIdTextFiled {
    if (!_appIdTextFiled) {
        _appIdTextFiled = [UITextField new];
        _appIdTextFiled.placeholder = @"appid，默认45271";
        _appIdTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _appIdTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _appIdTextFiled;
}

- (UITextField *)keyTextFiled {
    if (!_keyTextFiled) {
        _keyTextFiled = [UITextField new];
        _keyTextFiled.placeholder = @"appSecret，默认Y6yyc3zyP3EO9ol8";
        _keyTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _keyTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _keyTextFiled;
}

- (UILabel *)errorTip {
    if (!_errorTip) {
        _errorTip = [UILabel new];
        _errorTip.textAlignment = NSTextAlignmentCenter;
        _errorTip.textColor = [UIColor redColor];
        _errorTip.text = @"初始化错误";
        _errorTip.hidden = true;
    }
    return  _errorTip;
}

- (UITextField *)aliAaidTextFiled {
    if (!_aliAaidTextFiled) {
        _aliAaidTextFiled = [UITextField new];
        _aliAaidTextFiled.placeholder = @"ali_aaid,需对接阿里aaid，建议传递，影响收益，可为空";
        _aliAaidTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _aliAaidTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _aliAaidTextFiled;
}

- (UITextField *)caidTextFiled {
    if (!_caidTextFiled) {
        _caidTextFiled = [UITextField new];
        _caidTextFiled.placeholder = @"caid,需对接对接广协caid，建议传递，影响收益,可为空";
        _caidTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _caidTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _caidTextFiled;
}

- (UITextField *)caidVersionTextFiled {
    if (!_caidVersionTextFiled) {
        _caidVersionTextFiled = [UITextField new];
        _caidVersionTextFiled.placeholder = @"caid,需对接对接广协caid，建议传递，影响收益,可为空";
        _caidVersionTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _caidVersionTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _caidVersionTextFiled;
}

- (UITextField *)lastCaidTextFiled {
    if (!_lastCaidTextFiled) {
        _lastCaidTextFiled = [UITextField new];
        _lastCaidTextFiled.placeholder = @"caid,需对接对接广协caid，建议传递，影响收益,可为空";
        _lastCaidTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _lastCaidTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _lastCaidTextFiled;
}

- (UITextField *)lastCaidVersionTextFiled {
    if (!_lastCaidVersionTextFiled) {
        _lastCaidVersionTextFiled = [UITextField new];
        _lastCaidVersionTextFiled.placeholder = @"caid,需对接对接广协caid，建议传递，影响收益,可为空";
        _lastCaidVersionTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _lastCaidVersionTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _lastCaidVersionTextFiled;
}

- (UITextField *)idfaTextFiled {
    if (!_idfaTextFiled) {
        _idfaTextFiled = [UITextField new];
        _idfaTextFiled.placeholder = @"idfa,获取到建议传递，影响收益,可为空";
        _idfaTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _idfaTextFiled.font = [UIFont systemFontOfSize:14];
    }
    return _idfaTextFiled;
}

- (UISwitch *)on {
    if (!_on) {
        _on = [[UISwitch alloc] init];
    }
    return _on;
}


@end
