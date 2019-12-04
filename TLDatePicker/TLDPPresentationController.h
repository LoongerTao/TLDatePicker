//
//  TLDPPresentationController.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLDPPresentationController : UIPresentationController
<UIViewControllerTransitioningDelegate>

/// default  圆角 0.f
@property(nonatomic, assign) CGFloat cornerRadius;
/// default 0.2f
@property(nonatomic, assign) NSTimeInterval transitionDuration;

@property(nonatomic, assign) BOOL disableTapMaskToDismiss;
@property(nonatomic, copy) void (^didTapMaskView)(void);
@end

NS_ASSUME_NONNULL_END
