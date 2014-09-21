//
//  ProfileViewController.h
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
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
- (IBAction)onButtonClick:(id)sender;

@end
