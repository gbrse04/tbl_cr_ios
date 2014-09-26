//
//  SettingViewController.h
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "UIKeyboardViewController.h"
#import "CustomizeTextField.h"
#import "ChangePassViewController.h"



@interface SettingViewController : BaseViewController<UITextFieldDelegate,UIKeyboardViewControllerDelegate,UIAlertViewDelegate>
{
    UIKeyboardViewController *keyBoardController;
}


- (IBAction)onSave:(id)sender;

- (IBAction)onSetttingChange:(id)sender;
- (IBAction)onSaveBottom:(id)sender;
- (IBAction)onChangePass:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollMain;
@property (weak, nonatomic) IBOutlet CustomizeTextField *txtPhone;
@property (weak, nonatomic) IBOutlet CustomizeTextField *txtUserId;
@property (weak, nonatomic) IBOutlet CustomizeTextField *txtEmail;
@property (weak, nonatomic) IBOutlet CustomizeTextField *txtBirthday;

@end
