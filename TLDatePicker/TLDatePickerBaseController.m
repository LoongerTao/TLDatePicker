//
//  TLDatePickerBaseController.m
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLDatePickerBaseController.h"
#import "TLDPPresentationController.h"

@interface TLDatePickerBaseController ()

@end

@implementation TLDatePickerBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

// MARK: - Transition
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection
                 withTransitionCoordinator:coordinator];
    
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection {
    BOOL isCompact = traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact;
    CGFloat H = isCompact ? kHeightOfLandscape : kHeight;
    BOOL isIPhoneX = YES;
    if (isIPhoneX) {
        H += 34;
    }
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, H);
}


// MARK: - API
- (void)showInViewController:(UIViewController *)vc {
    // 该宏表明存储在某些局部变量中的值在优化时不应该被编译器强制释放
    TLDPPresentationController *pController NS_VALID_UNTIL_END_OF_SCOPE;
    pController = [[TLDPPresentationController alloc] initWithPresentedViewController:self
                                                             presentingViewController:vc];
    pController.disableTapMaskToDismiss = self.disableTapMaskToDismiss;
    pController.didTapMaskView =  self.didTapMaskView;
    self.transitioningDelegate = pController;
    [vc presentViewController:self animated:YES completion:nil];
}


@end
