//
//  TLDatePickerView.m
//  Demo
//
//  Created by 故乡的云 on 2019/11/28.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLDatePickerView.h"
#import "TLPickerComponent.h"
#import "TLPickerData.h"
#import "TLDatePickerAppearance.h"
#import "NSDate+TLCalendarExtention.h"

@interface TLDatePickerView () <UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic, strong) NSMutableArray <TLPickerComponent *>*components;
@property(nonatomic, strong) TLPickerData *data;
@property(nonatomic, weak) UILabel *tipLabel;
@property(nonatomic, assign) NSUInteger tipCount;

@end

@implementation TLDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.data = [[TLPickerData alloc] init];
        self.components = [NSMutableArray array];
    }
    return self;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel = label;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];        
    }
    
    return _tipLabel;
}

- (void)setMode:(TLDatePickerMode)mode
{
    _mode = mode;
    
    [self.components removeAllObjects];
    
    switch (_mode) {
        case TLDatePickerModeYear:
            [self.components addObject:self.data.yearComponent];
            break;
        case TLDatePickerModeYearAndMonth:
            [self.components addObject:self.data.yearComponent];
            [self.components addObject:self.data.monthComponent];
            break;
        case TLDatePickerModeDate:
            [self.components addObject:self.data.yearComponent];
            [self.components addObject:self.data.monthComponent];
            [self.components addObject:self.data.dayComponent];
            break;
        case TLDatePickerModeTime:
            [self.components addObject:self.data.hourComponent];
            [self.components addObject:self.data.minuteComponent];
            break;
        case TLDatePickerModeTime2:
            [self.components addObject:self.data.hourComponent];
            [self.components addObject:self.data.minuteComponent];
            [self.components addObject:self.data.secondComponent];
            break;
        case TLDatePickerModeDateAndTime:
            [self.components addObject:self.data.yearComponent];
            [self.components addObject:self.data.monthComponent];
            [self.components addObject:self.data.dayComponent];
            [self.components addObject:self.data.hourComponent];
            [self.components addObject:self.data.minuteComponent];
            break;
        default: // TLDatePickerModeDateAndTime2
            [self.components addObject:self.data.yearComponent];
            [self.components addObject:self.data.monthComponent];
            [self.components addObject:self.data.dayComponent];
            [self.components addObject:self.data.hourComponent];
            [self.components addObject:self.data.minuteComponent];
            [self.components addObject:self.data.secondComponent];
            break;
    }
    
    [self reloadAllComponents];
}

- (void)resetParams
{
    if (!self.date) {
        self.date = [NSDate date];
    }
    
    [self.data updateComponentWithDate:self.date];
    [self reloadAllComponents];
    
    [self scrollToSelectedDateWithAnimatedComponent:nil];
    
    for (UIView *subview in self.subviews) {
        if (subview.bounds.size.height <= 1.f) {
            subview.backgroundColor = self.appearance.centerLineColor;
        }
    }
}

/// 需要动画的component
- (void)scrollToSelectedDateWithAnimatedComponent:(TLPickerComponent *)component
{
    for (TLPickerComponent *cpt in self.components) {
        NSInteger row = [cpt selectedIndex];
        if (![cpt.name isEqualToString:@"year"]) {
            row += cpt.count * 100;
        }
        NSInteger cptIdx = [self.components indexOfObject:cpt];
        BOOL animated = component && [cpt isEqual:component];
        [self selectRow:row inComponent:cptIdx animated:animated];
    }
}

#pragma mark - UIPickerViewDataSource UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.components.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.components[component].name isEqualToString:@"year"]) {
        return self.components[component].count;
    }
    return self.components[component].count * 200; // 伪无限循环
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    NSInteger index = row % self.components[component].count; // 真实索引
    TLPickerItem *item = self.components[component].items[index];
    NSString *text = item.showField;
    if (!self.isHideUnit) {
        text = [NSString stringWithFormat:@"%@%@", text, item.unit];
    }

    NSDictionary *atts = [self attributesWithItem:item isUnit:NO];
   
    NSMutableAttributedString *attsStr = [[NSMutableAttributedString alloc] initWithString:text
                                                                                attributes:atts];
    if (!self.isHideUnit) {
         NSDictionary *unitAtts = [self attributesWithItem:item isUnit:YES];
        [attsStr setAttributes:unitAtts range:[text rangeOfString:item.unit]];
    }
    
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.attributedText = attsStr;
    [label sizeToFit];
    
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.bounds.size.width / (self.components.count + 1.5); // 1.5 为两边留边
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50.f;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"component: %zi row: %zi", component, row);
    TLPickerComponent *cpt = self.components[component];
    NSInteger curIndex = row % self.components[component].count; // 真实索引
    
    NSInteger index = [cpt selectedIndex]; // 上次选中的item索引
    
    [cpt selectItemOfIndex:curIndex];
    NSDate *willSelectDate = [self.data selectedDate];
    if (self.minDate && [self.minDate compareFrom:willSelectDate] > 0) {
        // 无效选择，日期不能小于self.minDate
        
        // 恢复到上次选中的item
        [cpt selectItemOfIndex:index];
        [self scrollToSelectedDateWithAnimatedComponent:cpt];
        [self showTip:@"无效选择，日期小于下限"];
        return;
    }else if (self.maxDate && [self.maxDate compareFrom:willSelectDate] < 0) {
        // 无效选择，日期不能大于self.maxDate
        
        [cpt selectItemOfIndex:index];
        [self scrollToSelectedDateWithAnimatedComponent:cpt];
        [self showTip:@"无效选择，日期超出上限"];
        return;
    }
    
    [self.data updateComponentWithDate:[self.data selectedDate]];
    [pickerView reloadAllComponents];
    /// 更新日期后，日所对应的索引发生变化
    [self scrollToSelectedDateWithAnimatedComponent:nil];
}

// MARK: - Help Methods
- (NSDictionary *)attributesWithItem:(TLPickerItem *)item isUnit:(BOOL)isUnit
{
    UIFont *font = nil;
    UIColor *color = nil;
    
    if (isUnit) {
        if (item.isSelected) {
            font = self.appearance.seletedUnitFont;
            color = self.appearance.seletedTextColor;
        }else {
            font = self.appearance.unitFont;
            color = self.appearance.textColor;
        }
    }else {
        if (item.isSelected) {
            font = self.appearance.seletedTextFont;
            color = self.appearance.seletedTextColor;
        }else {
            font = self.appearance.textFont;
            color = self.appearance.textColor;
        }
    }
    
    return @{
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: color
    };
}

- (NSDate *)selectedDate {
    return [self.data selectedDate];
}

- (void)showTip:(NSString *)tip {
    self.tipLabel.textColor = self.appearance.tipTextColor;
    self.tipLabel.font = self.appearance.tipFont;
    self.tipLabel.hidden = NO;
    
    self.tipLabel.text = tip;
    
    CGSize size = self.frame.size;
    self.tipLabel.frame = CGRectMake(0, size.height - 40, size.width, 30);
    self.tipCount += 1;
    
    [self performSelector:@selector(hideTipLable) withObject:nil afterDelay:3.f];
}

- (void)hideTipLable {
    self.tipCount -= 1;
    
    if (self.tipCount == 0) {
        self.tipLabel.hidden = YES;
    }    
}

@end
