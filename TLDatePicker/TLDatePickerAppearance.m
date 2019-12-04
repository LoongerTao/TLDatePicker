//
//  TLDatePickerAppearance.m
//  Demo
//
//  Created by 故乡的云 on 2019/12/2.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLDatePickerAppearance.h"

@implementation TLDatePickerAppearance

- (instancetype)init {
    if (self = [super init]) {
        self.placeholderFont = [UIFont systemFontOfSize:14];
        self.textFont = [UIFont boldSystemFontOfSize:14];
        self.unitFont = [UIFont systemFontOfSize:10];
        self.seletedTextFont = [UIFont boldSystemFontOfSize:14];
        self.seletedUnitFont = [UIFont systemFontOfSize:10];
        self.cancelButtonFont = [UIFont boldSystemFontOfSize:15];
        self.doneButtonTextFont = [UIFont boldSystemFontOfSize:15];
        self.tipFont = [UIFont systemFontOfSize:14];
        self.cancelButtonText = @"取消";
        self.doneButtonText = @"确定";
        self.cancelButtonCornerRadius = 4.f;
        self.doneButtonCornerRadius = 4.f;
        
        if (@available(iOS 13.0, *)) {
            self.backgroundColor = [UIColor systemBackgroundColor];
            self.topBarbackgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [UIColor colorWithWhite:26.f/255.0 alpha:1];
                } else {
                    return [UIColor colorWithWhite:0.985 alpha:1];
                }
            }];
            self.placeholderColor = [UIColor secondaryLabelColor];
            self.textColor = [UIColor secondaryLabelColor];
            self.seletedTextColor = [UIColor labelColor];
            self.centerLineColor = [UIColor opaqueSeparatorColor];
            self.cancelButtonTextColor = [UIColor systemTealColor];
            self.doneButtonTextColor = [UIColor systemTealColor];
            self.cancelButtonFillColor = [UIColor clearColor];
            self.doneButtonFillColor = [UIColor clearColor];
            self.tipTextColor = [UIColor systemRedColor];
        } else {
            self.backgroundColor = [UIColor whiteColor];
            self.topBarbackgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
            self.placeholderColor = [UIColor lightTextColor];
            self.textColor = [UIColor lightTextColor];
            self.seletedTextColor = [UIColor darkTextColor];
            self.centerLineColor = [UIColor lightGrayColor];
            self.cancelButtonTextColor = [UIColor darkTextColor];
            self.doneButtonTextColor = [UIColor darkTextColor];
            self.cancelButtonFillColor = [UIColor clearColor];
            self.doneButtonFillColor = [UIColor clearColor];
            self.tipTextColor = [UIColor redColor];
        }
    }
    
    return self;
}

+ (instancetype)appearance {
    return [[self alloc] init];
}

@end
