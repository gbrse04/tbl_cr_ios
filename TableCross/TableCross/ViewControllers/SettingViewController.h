//
//  SettingViewController.h
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "UIKeyboardViewController.h"

@interface SettingViewController : BaseViewController<UITextFieldDelegate,UIKeyboardViewControllerDelegate>
{
    UIKeyboardViewController *keyBoardController;
}

- (IBAction)onSave:(id)sender;

- (IBAction)onSetttingChange:(id)sender;
- (IBAction)onSaveBottom:(id)sender;

@end
