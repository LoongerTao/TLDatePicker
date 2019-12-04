//
//  TLPickerData.m
//  Demo
//
//  Created by 故乡的云 on 2019/11/29.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLPickerData.h"
#import "TLPickerComponent.h"
#import "NSDate+TLCalendarExtention.h"

@implementation TLPickerData

- (instancetype)init
{
    if (self = [super init]) {
        _yearComponent = [TLPickerComponent yearComponent];
        _monthComponent = [TLPickerComponent monthComponent];
        _dayComponent = [TLPickerComponent dayComponent];
        _hourComponent = [TLPickerComponent hourComponent];
        _minuteComponent = [TLPickerComponent minuteComponent];
        _secondComponent = [TLPickerComponent secondComponent];
    }
    return self;
}


// MARK: - Api
- (void)updateComponentWithDate:(NSDate *)date
{
    [_yearComponent selectedItemWithValue:date.year];
    [_monthComponent selectedItemWithValue:date.month];
    [_dayComponent selectedItemWithValue:date.day];
    [_hourComponent selectedItemWithValue:date.hour];
    [_minuteComponent selectedItemWithValue:date.minute];
    [_secondComponent selectedItemWithValue:date.second];

    NSInteger count = date.countOfMonth;
    for (NSUInteger i = 28; i < 31; i++ ) {
        TLPickerItem *item = _dayComponent.items[i];
        item.disable = item.value > count;
        if (_dayComponent.items[i].disable && _dayComponent.items[i].isSelected) {
            [_dayComponent selectedItemWithValue:count];
        }
    }
}

- (NSDate *)selectedDate
{
    NSInteger year = _yearComponent.selectedItem.value;
    NSInteger month = _monthComponent.selectedItem.value;
    NSInteger day = _dayComponent.selectedItem.value;
    NSInteger hour = _hourComponent.selectedItem.value;
    NSInteger minute = _minuteComponent.selectedItem.value;
    NSInteger second = _secondComponent.selectedItem.value;
    
    NSDate *date = [NSDate dateWithYear:year month:month day:1];
    if (day > date.countOfMonth) { // 即将选择的日期
        day = date.countOfMonth;
    }
    
    NSString *dateString = [NSString stringWithFormat:@"%zi-%02zi-%02zi %02zi:%02zi:%02zi",
                         year, month, day, hour, minute, second];
    
    return [NSDate dateWithFormatString:dateString];
}


@end
