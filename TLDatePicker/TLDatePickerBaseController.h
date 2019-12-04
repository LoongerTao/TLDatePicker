//
//  TLDatePickerBaseController.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kHeight 320.f               // 竖屏
#define kHeightOfLandscape 270.f    // 横屏

@interface TLDatePickerBaseController : UIViewController

/// Picker View 的有效高度，iPhoneX系列 自动增加34。 默认： kHeight
@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) BOOL disableTapMaskToDismiss;
@property(nonatomic, copy) void (^didTapMaskView)(void);

- (void)showInViewController:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
