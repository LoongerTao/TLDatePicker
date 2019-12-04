//
//  TLPickerData.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/29.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class TLPickerComponent;
@interface TLPickerData : NSObject

@property(nonatomic, strong) TLPickerComponent *yearComponent;
@property(nonatomic, strong) TLPickerComponent *monthComponent;
@property(nonatomic, strong) TLPickerComponent *dayComponent;
@property(nonatomic, strong) TLPickerComponent *weekComponent;
@property(nonatomic, strong) TLPickerComponent *hourComponent;
@property(nonatomic, strong) TLPickerComponent *minuteComponent;
@property(nonatomic, strong) TLPickerComponent *secondComponent;

/// 更新数据
- (void)updateComponentWithDate:(NSDate *)date;
- (NSDate *)selectedDate;
@end

NS_ASSUME_NONNULL_END


