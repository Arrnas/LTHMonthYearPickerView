//
//  LTHMonthYearPickerView.m
//  LTHMonthYearPickerView Demo
//
//  Created by Roland Leth on 30/11/13.
//  Copyright (c) 2014 Roland Leth. All rights reserved.
//

#import "LTHOptionPickerView.h"

#define kOptionColor [UIColor darkGrayColor]
#define kOptionFont [UIFont systemFontOfSize: 22.0]
#define kWinSize [UIScreen mainScreen].bounds.size

const NSUInteger kOptionsComponent = 0;
const CGFloat kRowHeight = 30.0;

@interface LTHOptionPickerView ()

@property (readwrite) NSInteger optionsIndex;
@property (nonatomic, strong) NSString *initialValue;
@property (nonatomic, strong) NSMutableArray *options;

@end


@implementation LTHOptionPickerView


#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_options.count <= _optionsIndex)
    {
        return;
    }
    if (!_initialValue) _initialValue = [_options objectAtIndex:_optionsIndex];
    if (component == 0) {
        _optionsIndex = [_optionPicker selectedRowInComponent: 0];
        if ([self.delegate respondsToSelector: @selector(pickerDidSelectOption:withPicker:)])
            [self.delegate pickerDidSelectOption: _options[_optionsIndex] withPicker:self];
    }
    if ([self.delegate respondsToSelector: @selector(pickerDidSelectRow:inComponent:withPicker:)])
        [self.delegate pickerDidSelectRow: row inComponent: component withPicker:self];
//	[[NSNotificationCenter defaultCenter]
//     postNotificationName: @"pickerDidSelectRow"
//     object: self
//     userInfo: @{ @"row" : @(row), @"component" : @(component) }];
//	[[NSNotificationCenter defaultCenter] postNotificationName: @"pickerDidSelectYear"
//														object: self
//													  userInfo: _years[_currentYear]];
//	[[NSNotificationCenter defaultCenter] postNotificationName: @"pickerDidSelectMonth"
//														object: self
//													  userInfo: _months[_currentMonth]];
//	[[NSNotificationCenter defaultCenter]
//     postNotificationName: @"pickerDidSelectMonth"
//     object: self
//     userInfo: @{ @"month" : _months[_currentMonth], @"year" : _years[_currentYear] }];
	_option = _options[_optionsIndex];
}


//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if (component == kMonthComponent) {
//        return _months[row];
//    }
//    return [NSString stringWithFormat: @"%@", _years[row]];
//}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *label = [[UILabel alloc] initWithFrame: CGRectZero];
	label.textAlignment = NSTextAlignmentCenter;
    label.text = [_options objectAtIndex:row];
    label.textColor = kOptionColor;
    label.font = kOptionFont;
    label.frame = CGRectMake(kWinSize.width, 0, kWinSize.width, kRowHeight);
	return label;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.bounds.size.width;
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return kRowHeight;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _options.count;
}


#pragma mark - Actions
- (void)_done {
    if (_options.count <= _optionsIndex)
    {
        if ([self.delegate respondsToSelector: @selector(pickerDidPressDoneWithOption:withPicker:)])
            [self.delegate pickerDidPressDoneWithOption:@"" withPicker:self];
        return;
    }
    if ([self.delegate respondsToSelector: @selector(pickerDidPressDoneWithOption:withPicker:)])
        [self.delegate pickerDidPressDoneWithOption:_options[_optionsIndex] withPicker:self];
//	[[NSNotificationCenter defaultCenter]
//     postNotificationName: @"pickerDidPressDone"
//     object: self
//     userInfo: @{ @"month" : _months[_currentMonth], @"year" : _years[_currentYear] }];
    _initialValue = nil;
	_option = _options[_optionsIndex];
}


- (void)_cancel {
    if (_options.count <= _optionsIndex)
    {
        if ([self.delegate respondsToSelector: @selector(pickerDidPressCancelWithInitialValue:withPicker:)]) {
            [self.delegate pickerDidPressCancelWithInitialValue: @"" withPicker:self];
        }
        else if ([self.delegate respondsToSelector: @selector(pickerDidPressCancelwithPicker:)])
            [self.delegate pickerDidPressCancelwithPicker:self];
        return;
    }
    if (!_initialValue) _initialValue  =_options[_optionsIndex];
    if ([self.delegate respondsToSelector: @selector(pickerDidPressCancelWithInitialValue:withPicker:)]) {
        [self.delegate pickerDidPressCancelWithInitialValue: _initialValue withPicker:self];
        [self.optionPicker selectRow: [_options indexOfObject: _initialValue]
                       inComponent: 0
                          animated: NO];
    }
    else if ([self.delegate respondsToSelector: @selector(pickerDidPressCancelwithPicker:)])
        [self.delegate pickerDidPressCancelwithPicker:self];
//	[[NSNotificationCenter defaultCenter]
//     postNotificationName: @"pickerDidPressDone"
//     object: self
//     userInfo: _initialValues];
	_optionsIndex = [_options indexOfObject: _initialValue];
    _option = _options[_optionsIndex];
	_initialValue = nil;
}



#pragma mark - Init
- (void)_setupComponentsFromOption:(NSString *)option {

    _optionsIndex = [_options indexOfObject: option];
    if (_optionsIndex == NSNotFound) {
        _optionsIndex = 0;
    }
	[_optionPicker selectRow: _optionsIndex
			   inComponent: 0
				  animated: YES];
    [self performSelector: @selector(_sendFirstPickerValues) withObject: nil afterDelay: 0.1];
}

- (void)_sendFirstPickerValues {
	if ([self.delegate respondsToSelector: @selector(pickerDidSelectRow:inComponent:withPicker:)]) {
		[self.delegate pickerDidSelectRow: [self.optionPicker selectedRowInComponent:0]
							  inComponent: 0 withPicker:self];
	}
    if ([self.delegate respondsToSelector: @selector(pickerDidSelectOption:withPicker:)])
        [self.delegate pickerDidSelectOption:_options[_optionsIndex] withPicker:self];
    if(_options.count > _optionsIndex)
    {
        _option = _options[_optionsIndex];
    }
}


#pragma mark - Init
- (id)initWithOptions:(NSArray *)options defaultOption:(NSString *)option andToolbar:(BOOL)showToolbar {
    self = [super init];
    if (self) {
        _options = [options copy];

		CGRect datePickerFrame;
        if (showToolbar) {
            self.frame = CGRectMake(0.0, 0.0, kWinSize.width, 260.0);
			datePickerFrame = CGRectMake(0.0, 44.5, self.frame.size.width, 216.0);

            UIToolbar *toolbar = [[UIToolbar alloc]
                                  initWithFrame: CGRectMake(0.0, 0.0, self.frame.size.width, datePickerFrame.origin.y - 0.5)];

            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                             target: self
                                             action: @selector(_cancel)];
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                          target: self
                                          action: nil];
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                        target: self
                                        action: @selector(_done)];

            [toolbar setItems: @[cancelButton, flexSpace, doneBtn]
                     animated: YES];
            [self addSubview: toolbar];
        }
        else {
			self.frame = CGRectMake(0.0, 0.0, kWinSize.width, 216.0);
			datePickerFrame = self.frame;
		}
        _optionPicker = [[UIPickerView alloc] initWithFrame: datePickerFrame];
        _optionPicker.dataSource = self;
        _optionPicker.delegate = self;
        [self addSubview: _optionPicker];
        if (option) {
            [self _setupComponentsFromOption:option];
        }
        else
        {
            [self _setupComponentsFromOption:[options firstObject]];
        }
        
    }
    return self;
}


@end
