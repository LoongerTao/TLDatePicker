//
//  ViewController.m
//  TLDatePickerDemo
//
//  Created by 故乡的云 on 2019/12/4.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "ViewController.h"
#import "TLDatePicker.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmt;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *minDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxDateLabel;
@property (weak, nonatomic) IBOutlet UISwitch *minDateSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *maxDateSwitch;

@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) NSDate *minDate;
@property(nonatomic, strong) NSDate *maxDate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker)];
    [self.dateView addGestureRecognizer:tap];
    
    [_sgmt addTarget:self
             action:@selector(setDateType)
    forControlEvents:UIControlEventValueChanged];
    
    self.sgmt.selectedSegmentIndex = 2;
    self.date = [NSDate date];
    
    NSString *minDateSting = [NSString stringWithFormat:@"%zi-%02zi-%02zi %02zi:%02zi:%02zi",
                              self.date.year - 3, self.date.month, self.date.day,
                              self.date.hour, self.date.minute, self.date.second];
    NSString *maxDateSting = [NSString stringWithFormat:@"%zi-%02zi-%02zi %02zi:%02zi:%02zi",
                              self.date.year + 3, self.date.month, self.date.day,
                              self.date.hour, self.date.minute, self.date.second];
    self.minDate = [NSDate dateWithFormatString:minDateSting];
    self.maxDate = [NSDate dateWithFormatString:maxDateSting];
    [self setDateType];
}

- (void)setDateType {
    NSString *fmt = self.dateFmtString;
    self.minDateLabel.text = [NSString stringWithFormat:@"最小日期:    %@",
                              [self.minDate dateToFormatString:fmt]];
    self.maxDateLabel.text = [NSString stringWithFormat:@"最小日期:    %@",
                              [self.maxDate dateToFormatString:fmt]];
    self.dateLabel.text = [_date dateToFormatString:fmt];
}

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSString *fmt = self.dateFmtString;
    self.dateLabel.text = [date dateToFormatString:fmt];
}

- (NSString *)dateFmtString {
    return @[@"yyyy", @"yyyy-MM", @"yyyy-MM-dd", @"HH:mm", @"HH:mm:ss",
             @"yyyy-MM-dd HH:mm", @"yyyy-MM-dd HH:mm:ss"][self.sgmt.selectedSegmentIndex];
}

- (void)showDatePicker {
    NSDate *minDate = _minDateSwitch.isOn ? _minDate : nil;
    NSDate *maxDate = _maxDateSwitch.isOn ? _maxDate : nil;
    __weak ViewController *wself = self;
    [[TLDatePicker showInController:self
                               mode:self.sgmt.selectedSegmentIndex
                               date:self.date
                            minDate:minDate
                            maxDate:maxDate
                       picekerEvent:^(NSDate * _Nonnull selectedDate, TLDatePickerEventType type)
      {
        if (type == TLDatePickerEventTypeDoneButtonDidClicked) {
            wself.date = selectedDate;
        }
    }] setPlaceholder:@"请选择日期"];
}

@end
