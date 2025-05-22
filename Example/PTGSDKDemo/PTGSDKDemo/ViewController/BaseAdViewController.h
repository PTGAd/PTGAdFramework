//
//  BaseAdViewController.h
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAdViewController : UIViewController

@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) UIButton *loadButton;
@property(nonatomic,strong) UIButton *showButton;
@property(nonatomic,assign) BOOL isLoading;

@end

NS_ASSUME_NONNULL_END
