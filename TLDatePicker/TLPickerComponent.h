//
//  TLPickerComponent.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/29.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPickerItem.h"

NS_ASSUME_NONNULL_BEGIN


@interface TLPickerComponent : NSObject
/// 当NADate 属性的key使用，如“year”、“month”等
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSArray <TLPickerItem *>*items;

+ (instancetype)yearComponent;
+ (instancetype)monthComponent;
+ (instancetype)dayComponent;
+ (instancetype)hourComponent;
+ (instancetype)minuteComponent;
+ (instancetype)secondComponent;


/// 返回当前选中的item, default : items.firstObject
- (TLPickerItem *)selectedItem;
/// default 0
- (NSUInteger)selectedIndex;
/// default 0
- (NSUInteger)indexOfValue:(NSUInteger)value;
/// 选中index项
- (void)selectItemOfIndex:(NSUInteger)index;
- (void)selectedItemWithValue:(NSUInteger)value;

/// 有效的激活item个数
- (NSUInteger)count;
@end

NS_ASSUME_NONNULL_END
