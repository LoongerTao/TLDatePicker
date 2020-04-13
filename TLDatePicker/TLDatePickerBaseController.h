//
//  TLDatePickerBaseController.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kHeight 270.f               // 竖屏
#define kHeightOfLandscape 270.f    // 横屏

@interface TLDatePickerBaseController : UIViewController

/// Picker View 的有效高度，默认： kHeight (非iPhone X系列 额外增加30 )
@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) BOOL disableTapMaskToDismiss;
@property(nonatomic, copy) void (^didTapMaskView)(void);

@property(nonatomic, assign, readonly) BOOL isIPhoneXOrLater;

- (void)showInViewController:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
