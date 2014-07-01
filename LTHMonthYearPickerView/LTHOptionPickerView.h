//
//  LTHMonthYearPickerView.m
//  LTHMonthYearPickerView Demo
//
//  Created by Roland Leth on 30/11/13.
//  Copyright (c) 2014 Roland Leth. All rights reserved.
//
@class LTHOptionPickerView;
@protocol LTHOptionPickerViewDelegate <NSObject>
@optional
- (void)pickerDidSelectRow:(NSInteger)row inComponent:(NSInteger)component withPicker:(LTHOptionPickerView *)picker;
- (void)pickerDidSelectOption:(NSString *)option withPicker:(LTHOptionPickerView *)picker;
- (void)pickerDidPressDoneWithOption:(NSString *)option withPicker:(LTHOptionPickerView *)picker;
- (void)pickerDidPressCancelwithPicker:(LTHOptionPickerView *)picker;
/**
 @brief				  If you want to change your text field (and/or variables) dynamically by implementing any of the pickerDidSelect__ delegate methods, instead of doing the change when Done was pressed, you should implement this method too, so the Cancel button restores old values.
 @param initialValue
 */
- (void)pickerDidPressCancelWithInitialValue:(NSString *)initialValue withPicker:(LTHOptionPickerView *)picker;
@end

@interface LTHOptionPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<LTHOptionPickerViewDelegate> delegate;
@property (nonatomic, strong) UIPickerView *optionPicker;
@property (nonatomic, strong) NSString *option;


/**
 @brief				   Option picker view, intended to emulate a drop down list.
 @param options        an array of available options for the picker view.
 @param option         the default option when nothing is selected, only set if it exists in the options array, first element of the options array as the default option otherwise.
 @param showToolbar    set to YES if you want the picker to have a Cancel/Done toolbar.
 @return a container view which contains the UIPicker and toolbar
 */
- (id)initWithOptions:(NSArray *)options defaultOption:(NSString *)option andToolbar:(BOOL)showToolbar;

@end
