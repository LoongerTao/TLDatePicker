//
//  NSDate+TLCalendarExtention.h
//  OusiCanteen
//
//  Created by 故乡的云 on 2018/8/20.
//  Copyright © 2018年 何青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TLCalendarExtention)

// MARK: - 比较
/**
 * 比较from和self的时间差值 self - from
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;
/**
 * 比较from和self的时间差值,返回秒 self - from
 */
- (NSTimeInterval)compareFrom:(NSDate *)from;

// MARK: - 判断
/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为同一日期（date=nil时，判断是否为今天）
 */
- (BOOL)isSameDate:(NSDate *)date;;

/**
 * 是否与date同一月（date=nil时，判断是否为本月）
 */
- (BOOL)isThisMonth:(NSDate *)date;

/**
 * 是否与date同一年（date=nil时，判断是否为今年）
 */
- (BOOL)isThisYear:(NSDate *)date;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
/**
 * 是否为明天
 */
- (BOOL)isTomorrow;



// MARK: - dateFormat(格式化)
/// 世界时间-->本地时间(只是时间偏移，本质还是世界时间)
- (NSDate *)worldDateToLocalDate;
+ (NSDate *)dateWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;
/// 日期格式化：yyyy-MM-dd HH:mm:ss --> NSDate 世界时间
+ (NSDate *)dateWithFormatString:(NSString *)dateStr;
/// 日期格式化：yyyy-MM-dd HH:mm:ss --> NSDate 本地时间
+ (NSDate *)loaclDateWithFormatString:(NSString *)dateStr;
- (NSString *)dateToFormatString:(NSString *)dateFormat;



// MARK: - 取值
/// 全局默认NSCalendar对象，单粒
@property(nonatomic, strong, readonly) NSCalendar *curCalendar;

/// NSCalendar会转化为本地时间（不能用来转换 - worldDateToLocalDate 格式化的时间，否则会有8小时误差）
@property(nonatomic, assign, readonly) NSInteger year;
/// 本地时间 月
@property(nonatomic, assign, readonly) NSInteger month;
/// 本地时间 日
@property(nonatomic, assign, readonly) NSInteger day;
/// 本地时间 时
@property(nonatomic, assign, readonly) NSInteger hour;
/// 本地时间 分
@property(nonatomic, assign, readonly) NSInteger minute;
/// 本地时间 秒
@property(nonatomic, assign, readonly) NSInteger second;

/// 1: 星期天，2: 星期一...
@property(nonatomic, assign, readonly) NSInteger weekday;
/// 当月第一天的星期
@property(nonatomic, assign, readonly) NSInteger startWeekOfMonth;
/// 当月天数
@property(nonatomic, assign, readonly) NSInteger countOfMonth;

- (NSCalendar *)curCalendar;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)weekday;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)startWeekOfMonth;
- (NSInteger)countOfMonth;


@end
