# TLDatePicker
- 一款简单的日历选择器
- 支持pod
```
pod 'TLDatePicker', '~> 1.0.0'
```

### 示例图
![date picker.jpg](https://upload-images.jianshu.io/upload_images/3333500-cdc2d088a21db431.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/414)

### 1、支持的日期模式
> `年`、`年月`、`年月日`、`时分`、`时分秒`、`年月日时分`、`年月日时分秒`

### 2、支持设置最大日期和最小日期

### 3、支持外观属性自定义
> - 可以自定义所有的文字的颜色字体
> - 可以自定义中心选择线的颜色、顶部工具条和整个picker view的背景色
> - 可以自定义按钮事件
> - 默认外观已适配黑暗模式

### 4、缺陷
选择日期时，只能一个字段一个字段选择，不支持同时滚动多个轮子来选择多个字段。同时滚动多个轮子，在第一个轮子停止时会将其他轮子的滚动取消回复到滚动之前的状态。

### 5、使用介绍
```
// 导入头文件
#import "TLDatePicker.h"

NSDate *minDate = _minDateSwitch.isOn ? _minDate : nil;
NSDate *maxDate = _maxDateSwitch.isOn ? _maxDate : nil;
__weak ViewController *wself = self;

TLDatePicker *datePicker = 
[TLDatePicker showInController:self
                           mode:self.sgmt.selectedSegmentIndex // 模式
                           date:self.date     // 初始化日期
                        minDate:minDate       // 最小日期限制
                        maxDate:maxDate       // 最da日期限制
                   picekerEvent:^(NSDate * _Nonnull selectedDate, TLDatePickerEventType type)
  {
    // 事件回调
    if (type == TLDatePickerEventTypeDoneButtonDidClicked) {
        // 点击确定按钮提交选择时间
        wself.date = selectedDate;
    }else if (type == TLDatePickerEventTypeDoneButtonDidClicked) {
        // 点击取消按钮
    }else if (type == TLDatePickerEventTypeDoneButtonDidClicked) {
        // 点击蒙层取消选中
    }
}] ;

// 设置placeholder
[datePicker setPlaceholder:@"请选择日期"];

//  外观设置
//  通过datePicker 实例的appearance属性来修改外观样式，
//  然后执行[datePicker resetParams]来使设置生效
//  具体可修改属性请查看TLDatePickerAppearance.h

// 其他可设置属性
/// 是否显示单位， Default is NO
@property(nonatomic, assign) BOOL hideUnit;
/// 禁止通过取消按钮来Dismiss, 不影响picekerEvent
@property(nonatomic, assign) BOOL disableDismissByCancelButton;
/// 禁止通过确定按钮来Dismiss, 不影响picekerEvent
@property(nonatomic, assign) BOOL disableDismissByDoneButton;
/// 禁止通过点击蒙层来Dismiss, 不影响picekerEvent
@property(nonatomic, assign) BOOL disableDismissByTapMaskView;
```
