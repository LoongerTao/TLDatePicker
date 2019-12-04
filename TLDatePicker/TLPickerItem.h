//
//  TLPickerItem.h
//  Demo
//
//  Created by 故乡的云 on 2019/11/29.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLPickerItem : NSObject
/// 用来显示的字段(不带单位)
@property(nonatomic, copy) NSString *showField;
/// 真实值
@property(nonatomic, assign) NSInteger value;
/// 单位
@property(nonatomic, copy) NSString *unit;
/// 选中
@property(nonatomic, assign, getter=isSelected) BOOL selected;
/// 不可选择（未激活）,针对每月最后几天
@property(nonatomic, assign, getter=isDisable) BOOL disable;

@end

NS_ASSUME_NONNULL_END
