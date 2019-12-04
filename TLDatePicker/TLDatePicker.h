//
//  TLDatePicker.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLDatePickerBaseController.h"
#import "TLDatePickerAppearance.h"
#import "TLDatePickerView.h"
#import "NSDate+TLCalendarExtention.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// 点击了确定按钮
    TLDatePickerEventTypeDoneButtonDidClicked   = 0,
    /// 点击了取消按钮
    TLDatePickerEventTypeCancelButtonDidClicked,
    /// 点击了蒙层
    TLDatePickerEventTypeDidDismissByTapMaskView,
} TLDatePickerEventType;


@interface TLDatePicker : TLDatePickerBaseController

/// 日期选择类型
@property (nonatomic, assign) TLDatePickerMode mode;
/// 最小日期（--> 过去）, Default is nil
@property(nonatomic, strong) NSDate *minDate;
/// 最大日期（---> 未来）, Default is nil
@property(nonatomic, strong) NSDate *maxDate;
/// 初始日期
@property(nonatomic, strong) NSDate *date;
/// 选中日期
@property(nonatomic, strong, readonly) NSDate *selectedDate;

@property(nonatomic, copy) NSString *placeholder;

/// 外观属性, 在组件已经显示后修改后需要调用`- resetParams`方法来生效
@property(nonatomic, strong, readonly) TLDatePickerAppearance *appearance;

/// 在组件已经显示后，更新预置参数后必须调用该方法，才能保证参数生效
- (void)resetParams;




/// 点击事件（按钮、蒙层）
@property(nonatomic, copy) void (^picekerEvent)(NSDate *selectedDate, TLDatePickerEventType type);

+ (instancetype)datePickerWithMode:(TLDatePickerMode)mode;
+ (instancetype)datePickerWithMode:(TLDatePickerMode)mode date:(NSDate *)date;

/// 可以通过selectedDate.year / selectedDate.day 等直接获取相关属性
- (void)showInController:(UIViewController *)vc
            picekerEvent:(void (^ __nullable)(NSDate *selectedDate, TLDatePickerEventType type))event;
- (void)dismissAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;

+ (instancetype)showInController:(UIViewController *)vc
                            mode:(TLDatePickerMode)mode
                            date:(NSDate * _Nullable)date
                         minDate:(NSDate * _Nullable)minDate
                         maxDate:(NSDate * _Nullable)maxDate
                    picekerEvent:(void (^ _Nullable)(NSDate *selectedDate, TLDatePickerEventType type))event;


// ================ Other ==============

/// 是否显示单位， Default is NO
@property(nonatomic, assign) BOOL hideUnit;

/// 取消按钮
@property(nonatomic, weak, readonly) UIButton *cancelButton;
/// 确定按钮
@property(nonatomic, weak, readonly) UIButton *doneButton;

/// 禁止通过取消按钮来Dismiss, 不影响picekerEvent
@property(nonatomic, assign) BOOL disableDismissByCancelButton;
/// 禁止通过确定按钮来Dismiss, 不影响picekerEvent
@property(nonatomic, assign) BOOL disableDismissByDoneButton;
/// 禁止通过点击蒙层来Dismiss, 不影响picekerEvent
@property(nonatomic, assign) BOOL disableDismissByTapMaskView;
@end

NS_ASSUME_NONNULL_END
