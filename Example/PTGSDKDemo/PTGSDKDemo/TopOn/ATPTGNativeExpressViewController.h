//
//  ATNativeExpressCustomViewController.h
//  PTGSDKDemo
//
//  Created byttt on 2024/11/11.
//

#import <UIKit/UIKit.h>
#import <AnyThinkNative/AnyThinkNative.h>
#import <AnyThinkPTGAdSDKAdapter/ATPSelfRenderDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATPTGSelfNativeView: UIView<ATPSelfRenderDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *bodyLabel;
@property(nonatomic,strong)UIImageView *iv;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,strong)UIView *adView;
@property(nonatomic,strong)UIView *videoView;

@property(nonatomic,weak)id<ATPSelfRenderActionDelegate> delegate;

@end

@interface ATPTGNativeExpressViewController : UIViewController

@end

@interface ATNativeExpressCell : UITableViewCell

@property(nonatomic,strong)ATNativeADView *adView;

@end

NS_ASSUME_NONNULL_END
