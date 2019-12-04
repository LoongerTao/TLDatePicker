//
//  TLPickerComponent.m
//  Demo
//
//  Created by 故乡的云 on 2019/11/29.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLPickerComponent.h"
#import "NSDate+TLCalendarExtention.h"

@implementation TLPickerComponent

// MARK: - class methods
+ (instancetype)componentWithName:(NSString *)name
                         minValue:(NSInteger)minVal
                         maxValue:(NSInteger)maxValue
                             unit:(NSString *)unit
{
    TLPickerComponent *cpt = [[self alloc] init];
    cpt.name = name;
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = minVal; i <= maxValue; i++) {
        TLPickerItem *item = [[TLPickerItem alloc] init];
        item.showField = @(i).stringValue;
        item.value = i;
        item.unit = unit;
        [items addObject:item];
    }
    cpt.items = items;
    return cpt;
}

+ (instancetype)yearComponent {
    return [TLPickerComponent componentWithName:@"year"
                                       minValue:1970
                                       maxValue:[NSDate date].year + 100
                                           unit:@"年"];
}

+ (instancetype)monthComponent {
    return [TLPickerComponent componentWithName:@"month"
                                       minValue:1
                                       maxValue:12
                                           unit:@"月"];
}

+ (instancetype)dayComponent {
    return [TLPickerComponent componentWithName:@"day"
                                       minValue:1
                                       maxValue:31
                                           unit:@"日"];
}

+ (instancetype)hourComponent {
    return [TLPickerComponent componentWithName:@"hour"
                                       minValue:0
                                       maxValue:23
                                           unit:@"时"];
}

+ (instancetype)minuteComponent {
    return [TLPickerComponent componentWithName:@"minute"
                                       minValue:0
                                       maxValue:59
                                           unit:@"分"];
}

+ (instancetype)secondComponent {
    return [TLPickerComponent componentWithName:@"second"
                                       minValue:0
                                       maxValue:59
                                           unit:@"秒"];
}

// MARK: - instance methods
- (TLPickerItem *)selectedItem {
    for (TLPickerItem *item in self.items) {
        if (item.isSelected) {
            return item;
        }
    }
    return self.items.firstObject;
}

- (NSUInteger)selectedIndex {
    return [self.items indexOfObject:self.selectedItem];
}

- (NSUInteger)indexOfValue:(NSUInteger)value {
    for (TLPickerItem *item in self.items) {
        if (item.value == value) {
            return [self.items indexOfObject:item];
        }
    }
    return 0;
}

- (void)selectItemOfIndex:(NSUInteger)index {
    [self selectedItem].selected = NO;
    self.items[index].selected = YES;
}

- (void)selectedItemWithValue:(NSUInteger)value; {
    [self selectItemOfIndex:[self indexOfValue:value]];
}

/// 有效的激活item个数
- (NSUInteger)count {
    if(![self.name isEqualToString:@"day"]) return self.items.count;
        
    NSUInteger i = 0;
    for (TLPickerItem *item in self.items) {
        if (item.isDisable == NO) { // 激活
            i++;
        }
    }
    return i;
}
@end
