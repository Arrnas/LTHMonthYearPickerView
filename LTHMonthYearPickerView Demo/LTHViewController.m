//
//  LTHViewController.m
//  LTHMonthYearPickerView Demo
//
//  Created by Roland Leth on 30/11/13.
//  Copyright (c) 2014 Roland Leth. All rights reserved.
//

#import "LTHViewController.h"


@interface LTHViewController ()

@property (nonatomic, strong) UITextField *dateTextField;
@property (nonatomic, strong) LTHOptionPickerView *monthYearPicker;
@end


@implementation LTHViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	CGSize winSize = [UIScreen mainScreen].bounds.size;
	_dateTextField = [[UITextField alloc] initWithFrame: CGRectMake(winSize.width * 0.5 - 75.0,
																	winSize.height * 0.5 - 20.0,
																	150.0,
																	40.0)];
	
	_monthYearPicker = [[LTHOptionPickerView alloc] initWithOptions:[NSArray arrayWithObjects:@"vienas",@"du",@"trys",@"keturi",@"penki",@"sesi",@"septyni",@"astuoni",@"devyni",@"desimt",nil] defaultOption:nil andToolbar:YES];
	_monthYearPicker.delegate = self;
	_dateTextField.delegate = self;
	_dateTextField.textAlignment = NSTextAlignmentCenter;
	_dateTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_dateTextField.layer.borderWidth = 1.0;
	_dateTextField.textColor = [UIColor purpleColor];
	_dateTextField.tintColor = [UIColor purpleColor];
	_dateTextField.inputView = _monthYearPicker;
	[self.view addSubview: _dateTextField];
	[_dateTextField becomeFirstResponder];
}


#pragma mark - LTHMonthYearPickerView Delegate
- (void)pickerDidPressCancelWithInitialValue:(NSString *)initialValue withPicker:(LTHOptionPickerView *)picker
{
	_dateTextField.text = initialValue;
    [_dateTextField resignFirstResponder];
}


- (void)pickerDidPressDoneWithOption:(NSString *)option withPicker:(LTHOptionPickerView *)picker
{
    _dateTextField.text = option;
	[_dateTextField resignFirstResponder];
}


- (void)pickerDidPressCancelwithPicker:(LTHOptionPickerView *)picker
{
	[_dateTextField resignFirstResponder];
}


- (void)pickerDidSelectRow:(NSInteger)row inComponent:(NSInteger)component withPicker:(LTHOptionPickerView *)picker
{
	NSLog(@"row: %i in component: %i", row, component);
}

- (void)pickerDidSelectOption:(NSString *)option withPicker:(LTHOptionPickerView *)picker
{
    _dateTextField.text = option;
}


@end
