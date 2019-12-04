//
//  TLDatePickerAppearance.h
//  Demo
//
//  Created by 故乡的云 on 2019/12/2.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLDatePickerAppearance : NSObject

/// placeholder字体，默认14
@property(nonatomic, strong) UIFont *placeholderFont;
/// placeholder颜色，默认
@property(nonatomic, strong) UIColor *placeholderColor;

/// 非选中日期字段字体，默认14
@property(nonatomic, strong) UIFont *textFont;
/// 非选中单位字体，默认10
@property(nonatomic, strong) UIFont *unitFont;
/// 选中日期字段字体，默认14  bold
@property(nonatomic, strong) UIFont *seletedTextFont;
/// 选中单位字体，默认10
@property(nonatomic, strong) UIFont *seletedUnitFont;

/// 非选中日期字段颜色， 默认：
@property(nonatomic, strong) UIColor *textColor;
/// 选中日期字段颜色， 默认：
@property(nonatomic, strong) UIColor *seletedTextColor;
/// 选中日期区间线颜色， 默认：
@property(nonatomic, strong) UIColor *centerLineColor;

/// 错误信息提示字体，默认：14
@property(nonatomic, strong) UIFont *tipFont;
/// 错误信息提示文本颜色，默认：
@property(nonatomic, strong) UIColor *tipTextColor;

/// 整体背景色， 默认：白色
@property(nonatomic, strong) UIColor *backgroundColor;
/// 工具条景色， 默认：白色
@property(nonatomic, strong) UIColor *topBarbackgroundColor;

/// 取消按钮字体颜色， 默认：
@property(nonatomic, strong) UIColor *cancelButtonTextColor;
/// 确定按钮字体颜色， 默认：
@property(nonatomic, strong) UIColor *doneButtonTextColor;
/// 取消按钮字体， 默认：
@property(nonatomic, strong) UIFont *cancelButtonFont;
/// 确定按钮字体， 默认：
@property(nonatomic, strong) UIFont *doneButtonTextFont;
/// 取消按钮文字
@property(nonatomic, copy) NSString *cancelButtonText;
/// 确定按钮文字
@property(nonatomic, copy) NSString *doneButtonText;
/// 取消按钮圆角，默认： 4.f
@property(nonatomic, assign) CGFloat cancelButtonCornerRadius;
/// 确定按钮圆角，默认： 4.f
@property(nonatomic, assign) CGFloat doneButtonCornerRadius;
/// 取消按钮背景色，默认：
@property(nonatomic, strong) UIColor *cancelButtonFillColor;
/// 确定按钮圆角背景色，默认：
@property(nonatomic, strong) UIColor *doneButtonFillColor;

+ (instancetype)appearance;
@end

NS_ASSUME_NONNULL_END
