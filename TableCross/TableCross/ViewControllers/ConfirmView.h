//
//  ConfirmView.h
//  TableCross
//
//  Created by DANGLV on 20/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmDelegate <NSObject>

- (void)onCall:(NSInteger)value;

@end

@interface ConfirmView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (retain, nonatomic)  UIPickerView *picker;
- (IBAction)onCancel:(id)sender;
- (IBAction)onCall:(id)sender;
- (IBAction)onBackgroundClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBackground;


@property (retain, nonatomic) id<ConfirmDelegate> confirmDelegate;

-(void)setup;


@end
