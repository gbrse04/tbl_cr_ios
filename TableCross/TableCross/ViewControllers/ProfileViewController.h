//
//  ProfileViewController.h
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"

@interface ProfileViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *number1;
@property (weak, nonatomic) IBOutlet UIButton *number2;
@property (weak, nonatomic) IBOutlet UIButton *number3;
@property (weak, nonatomic) IBOutlet UIButton *number4;
@property (weak, nonatomic) IBOutlet UIButton *number5;
@property (weak, nonatomic) IBOutlet UIButton *number6;
@property (weak, nonatomic) IBOutlet UIButton *number7;
@property (weak, nonatomic) IBOutlet UIButton *number8;
@property (weak, nonatomic) IBOutlet UIButton *number9;
@property (weak, nonatomic) IBOutlet UIButton *number10;



- (IBAction)onButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;

@end
