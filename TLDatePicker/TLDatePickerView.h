//
//  TLDatePickerView.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/// 日期选择类型
typedef NS_ENUM(NSInteger, TLDatePickerMode) {
    /// 年
    TLDatePickerModeYear            = 0,
    /// 年-月
    TLDatePickerModeYearAndMonth,
    /// 年-月-日
    TLDatePickerModeDate,
    /// 时-分
    TLDatePickerModeTime,
    /// 时-分-秒
    TLDatePickerModeTime2,
    /// 年-月-日  时-分
    TLDatePickerModeDateAndTime,
    /// 年-月-日  时-分-秒
    TLDatePickerModeDateAndTime2,
};

@class TLDatePickerAppearance;
@interface TLDatePickerView : UIPickerView

/* =============== 日期属性 =============== */
/// 日期选择类型
@property (nonatomic, assign) TLDatePickerMode mode;
/// 最小日期（--> 过去）, default is nil
@property(nonatomic, strong) NSDate *minDate;
/// 最大日期（---> 未来）, default is nil
@property(nonatomic, strong) NSDate *maxDate;
/// 初始日期
@property(nonatomic, strong) NSDate *date;
/// 选中
@property(nonatomic, strong) NSDate *selectedDate;
/// 显示单位，default is YES
@property (nonatomic, assign, getter=isHideUnit) BOOL hideUnit;


/* =============== 外观属性 =============== */
@property(nonatomic, strong) TLDatePickerAppearance *appearance;


/// 更新预置参数后必须调用该方法，才能保证参数生效
- (void)resetParams;
@end

NS_ASSUME_NONNULL_END
