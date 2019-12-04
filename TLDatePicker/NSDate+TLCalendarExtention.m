//
//  NSDate+TLCalendarExtention.m
//  OusiCanteen
//
//  Created by 故乡的云 on 2018/8/20.
//  Copyright © 2018年 何青. All rights reserved.
//

#import "NSDate+TLCalendarExtention.h"

@implementation NSDate (TLCalendarExtention)

// MARK: - 比较
- (NSDateComponents *)deltaFrom:(NSDate *)from {
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (NSTimeInterval)compareFrom:(NSDate *)from {
    NSTimeInterval time = [self timeIntervalSinceDate:from];
    
    return time;
}

// MARK: - 判断

- (BOOL)isToday {
    return [[self curCalendar] isDateInToday:self];
}

- (BOOL)isSameDate:(NSDate *)date {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    date = date ? date : [NSDate date];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:date];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day;
}

- (BOOL)isThisMonth:(NSDate *)date;{
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth;
    
    date = date ? date : [NSDate date];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:date];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month;
}

- (BOOL)isThisYear:(NSDate *)date;{
    NSCalendar *calendar = [self curCalendar];
    
    date = date ? date : [NSDate date];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:date];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isYesterday{
    return [[self curCalendar] isDateInYesterday:self];
}

- (BOOL)isTomorrow{
    return [[self curCalendar] isDateInTomorrow:self];
}


// MARK: - dateFormat(格式化)
+ (NSDate *)dateWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    NSString *dateStr = [NSString stringWithFormat:@"%zi-%zi-%zi", year, month, day];
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-MM-dd";
   
    return [fmt dateFromString:dateStr];
}

+ (NSDate *)dateWithFormatString:(NSString *)dateStr {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [fmt dateFromString:dateStr];
}

+ (NSDate *)loaclDateWithFormatString:(NSString *)dateStr {
    return [[NSDate dateWithFormatString:dateStr] worldDateToLocalDate];
}

- (NSString *)dateToFormatString:(NSString *)dateFormat {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = dateFormat;
    return [fmt stringFromDate:self];
}

// 世界时间转换为本地时间
- (NSDate *)worldDateToLocalDate
{
    //获取本地时区(中国时区)
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    //计算世界时间与本地时区的时间偏差值
    NSInteger offset = [localTimeZone secondsFromGMTForDate:self];
    //世界时间＋偏差值 得出中国区时间
    NSDate *localDate = [self dateByAddingTimeInterval:offset];
    
    return localDate;
}

// MARK: - 取值
static NSCalendar *CALENDAR;
- (NSCalendar *)curCalendar {
    if (CALENDAR == nil) {
        // 使用静态CALENDAR，防止高频创建影响性能
        CALENDAR = [NSCalendar currentCalendar];
    }
    return CALENDAR;
}

- (NSInteger)year {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:self];
    
    return cmps.year;
}

- (NSInteger)month {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:self];
    
    return cmps.month;
}

- (NSInteger)day {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:self];
    
    return cmps.day;
}

- (NSInteger)hour {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:self];
    
    return cmps.hour;
}

- (NSInteger)minute {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:self];
    
    return cmps.minute;
}

- (NSInteger)second {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:self];
    
    return cmps.second;
}

- (NSInteger)weekday {
    NSCalendar *calendar = [self curCalendar];
    NSCalendarUnit unit = NSCalendarUnitWeekday;
    NSDateComponents *cmps = [calendar components:unit fromDate:self];
    
    return cmps.weekday;
}

- (NSInteger)startWeekOfMonth {
    NSDate *date = [NSDate dateWithYear:self.year month:self.month day:1];
    
    return date.weekday;
}

- (NSInteger)countOfMonth {
    NSCalendar *calendar = [self curCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:self];
    
    return range.length;
}

@end
