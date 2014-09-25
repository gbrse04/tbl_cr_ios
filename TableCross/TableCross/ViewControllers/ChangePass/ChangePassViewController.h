//
//  ChangePassViewController.h
//  TableCross
//
//  Created by DANGLV on 25/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomizeTextField.h"
#import "UIKeyboardViewController.h"


@interface ChangePassViewController : BaseViewController<UITextFieldDelegate,UIKeyboardViewControllerDelegate>
{
    UIKeyboardViewController *keyBoardController;
}

@property (weak, nonatomic) IBOutlet CustomizeTextField *txtOldPass;
@property (weak, nonatomic) IBOutlet CustomizeTextField *txtNewPass;
@property (weak, nonatomic) IBOutlet CustomizeTextField *txxNewPassConfirm;
- (IBAction)onChangePass:(id)sender;

@end
