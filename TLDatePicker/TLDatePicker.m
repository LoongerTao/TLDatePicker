//
//  TLDatePicker.m
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLDatePicker.h"



@interface TLDatePicker () {
    TLDatePickerAppearance *__appearance;
    UIButton *__cancelButton, *__doneButton;
    UILabel *__placeholderLabel;
}
@property(nonatomic, weak) UIView *topBar;
@property(nonatomic, weak) TLDatePickerView *datePicker;

@end

@implementation TLDatePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self resetParams];
}

// MARK: - lazy
- (UIView *)topBar {
    if (_topBar == nil) {
        UIView *topBar = [[UIView alloc] init];
        _topBar = topBar;
        [self.view addSubview:topBar];
        
        __placeholderLabel = [[UILabel alloc] init];
        [topBar addSubview:__placeholderLabel];
        __placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _topBar;
}

- (TLDatePickerView *)datePicker {
    if (_datePicker == nil) {
        TLDatePickerView *datePicker = [[TLDatePickerView alloc] init];
        _datePicker = datePicker;
        [self.view addSubview:datePicker];
    }
    return  _datePicker;
}

- (TLDatePickerAppearance *)appearance {
    if (!__appearance) {
        __appearance = [TLDatePickerAppearance appearance];
    }
    return __appearance;
}

- (UIButton *)doneButton {
    if (!__doneButton) {
        __doneButton = [[UIButton alloc] init];
        [__doneButton addTarget:self
                  action:@selector(commit:)
        forControlEvents:UIControlEventTouchUpInside];
        if (@available(iOS 13.0, *)) {
            [__doneButton setTitleColor:[UIColor tertiaryLabelColor]
                               forState:UIControlStateHighlighted];
            [__doneButton setTitleColor:[UIColor quaternaryLabelColor]
                               forState:UIControlStateDisabled];
        } else {
            [__doneButton setTitleColor:[UIColor lightTextColor]
                               forState:UIControlStateHighlighted];
            [__doneButton setTitleColor:[UIColor lightTextColor]
                               forState:UIControlStateDisabled];
        }
        [self.topBar addSubview:__doneButton];
    }
    return __doneButton;
}

- (UIButton *)cancelButton {
    if (!__cancelButton) {
        __cancelButton = [[UIButton alloc] init];
        [__cancelButton addTarget:self
                           action:@selector(cancel:)
                 forControlEvents:UIControlEventTouchUpInside];
        if (@available(iOS 13.0, *)) {
            [__cancelButton setTitleColor:[UIColor tertiaryLabelColor]
                               forState:UIControlStateHighlighted];
            [__cancelButton setTitleColor:[UIColor quaternaryLabelColor]
                               forState:UIControlStateDisabled];
        } else {
            [__cancelButton setTitleColor:[UIColor lightTextColor]
                               forState:UIControlStateHighlighted];
            [__cancelButton setTitleColor:[UIColor lightTextColor]
                               forState:UIControlStateDisabled];
        }
        [self.topBar addSubview:__cancelButton];
    }
    return __cancelButton;
}

// MARK: - Layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect rect;
    if (@available(iOS 11.0, *)) {
        rect = self.view.safeAreaLayoutGuide.layoutFrame;
    } else {
        rect = self.view.frame;
    }
    
    CGRect frame = rect;
    frame.size.height = 50;
    self.topBar.frame = frame;
    
    rect.origin.y = self.isIPhoneXOrLater ? 25 : 10;
    self.datePicker.frame = rect;
    
    [self.view bringSubviewToFront:self.topBar];
    
    [self layoutTopBarSubviews];
}

- (void)layoutTopBarSubviews {
    CGFloat marginLeft = 3;
    CGFloat marginRight = 3;
    if(self.appearance.cancelButtonFillColor &&
       ![self.appearance.cancelButtonFillColor isEqual:[UIColor clearColor]]) {
        marginLeft = 12;
    }
    if(self.appearance.doneButtonFillColor &&
    ![self.appearance.doneButtonFillColor isEqual:[UIColor clearColor]]) {
        marginRight = 12;
    }
    
    self.cancelButton.frame = CGRectMake(marginLeft, 10, 60, 30);
    self.doneButton.frame = CGRectMake(self.topBar.bounds.size.width - marginRight - 60, 10, 60, 30);
    
    CGFloat left = CGRectGetMaxX(self.cancelButton.frame) + 12;
    CGFloat right = CGRectGetMinX(self.doneButton.frame) - 12;
    __placeholderLabel.frame = CGRectMake(left , 10, right - left, 30);
}

// MARK: - Actions
- (void)cancel:(UIButton *)btn {
    
    if (self.picekerEvent) {
        self.picekerEvent(self.selectedDate, TLDatePickerEventTypeCancelButtonDidClicked);
    }
    
    if(self.disableDismissByCancelButton) return;

    [self dismissAnimated:YES completion:nil];
}

- (void)commit:(UIButton *)btn {
    if (self.picekerEvent) {
        self.picekerEvent(self.selectedDate, TLDatePickerEventTypeDoneButtonDidClicked);
    }
    
    if(self.disableDismissByDoneButton) return;
    
    [self dismissAnimated:YES completion:nil];
}

// MARK: - API
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    __placeholderLabel.text = self.placeholder;
}

- (void)resetParams {
    self.datePicker.mode = self.mode;
    self.datePicker.date = self.date;
    self.datePicker.minDate = self.minDate;
    self.datePicker.maxDate = self.maxDate;
    self.datePicker.hideUnit = self.hideUnit;
    self.datePicker.appearance = self.appearance;
    
    self.view.backgroundColor = self.appearance.backgroundColor;
    self.datePicker.backgroundColor = self.appearance.backgroundColor;
    self.topBar.backgroundColor = self.appearance.topBarbackgroundColor;
    
    [self.cancelButton setTitle:self.appearance.cancelButtonText forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:self.appearance.cancelButtonTextColor forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = self.appearance.cancelButtonFont;
    self.cancelButton.layer.cornerRadius = self.appearance.cancelButtonCornerRadius;
    self.cancelButton.backgroundColor = self.appearance.cancelButtonFillColor;
    
    [self.doneButton setTitle:self.appearance.doneButtonText forState:UIControlStateNormal];
    [self.doneButton setTitleColor:self.appearance.doneButtonTextColor forState:UIControlStateNormal];
    self.doneButton.titleLabel.font = self.appearance.doneButtonTextFont;
    self.doneButton.layer.cornerRadius = self.appearance.doneButtonCornerRadius;
    self.doneButton.backgroundColor = self.appearance.doneButtonFillColor;
    
    __placeholderLabel.textColor = self.appearance.placeholderColor;
    __placeholderLabel.font = self.appearance.placeholderFont;
    __placeholderLabel.text = self.placeholder;
    
    [self layoutTopBarSubviews];
    
    [self.datePicker resetParams];
}

- (NSDate *)selectedDate {
    return self.datePicker.selectedDate;
}

+ (instancetype)datePickerWithMode:(TLDatePickerMode)mode {
    return [self datePickerWithMode:mode date:[NSDate date]];
}

+ (instancetype)datePickerWithMode:(TLDatePickerMode)mode date:(NSDate *)date {
    TLDatePicker *picker = [self new];
    picker.mode = mode;
    picker.date = date;
    return picker;
}

+ (instancetype)showInController:(UIViewController *)vc
                            mode:(TLDatePickerMode)mode
                            date:(NSDate * _Nullable)date
                         minDate:(NSDate * _Nullable)minDate
                         maxDate:(NSDate * _Nullable)maxDate
                    picekerEvent:(void (^ _Nullable)(NSDate *selectedDate, TLDatePickerEventType type))event
{
    TLDatePicker *picker = [self datePickerWithMode:mode date:date];
    picker.minDate = minDate;
    picker.maxDate = maxDate;
    [picker showInController:vc picekerEvent:event];
    return picker;
}

- (void)showInController:(UIViewController *)vc
            picekerEvent:(void (^ __nullable)(NSDate *date, TLDatePickerEventType type))event
{
    NSAssert( vc && [vc isKindOfClass:[UIViewController class]],
             @"%s 中vc不能为nil,且必须是UIViewController或其子类",
             __func__);
    
    __weak TLDatePicker *wself = self;
    self.didTapMaskView = ^{
        if (wself.picekerEvent) {
            wself.picekerEvent(wself.selectedDate, TLDatePickerEventTypeDidDismissByTapMaskView);
        }
    };
    self.picekerEvent = event;
    [self showInViewController:vc];
}

- (void)dismissAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    [self dismissViewControllerAnimated:flag completion:completion];
}
@end
