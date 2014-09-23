//
//  ConfirmView.m
//  TableCross
//
//  Created by TableCross on 20/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "ConfirmView.h"



@implementation ConfirmView {
    int currentValue;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)onCancel:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)onCall:(id)sender {
    if(self.confirmDelegate)
       [self.confirmDelegate onCall:currentValue];
    
}

- (IBAction)onBackgroundClick:(id)sender {
    
    [self removeFromSuperview];
    
}

-(void)setup{
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 97, 280, 162)];
    self.picker.backgroundColor = [UIColor whiteColor];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    [self addSubview:self.picker];
    [self.picker reloadAllComponents];
    
}

#pragma mark - Picker Delegate


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 20;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"%d",row+1];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    currentValue = component;
    
}

@end
