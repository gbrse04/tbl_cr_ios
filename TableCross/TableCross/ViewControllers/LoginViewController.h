//
//  LoginViewController.h
//  TableCross
//
//  Created by TableCross on 17/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"

#import "SearchHomeViewController.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "NotificationViewController.h"
#import "ShareViewController.h"
#import "UIKeyboardViewController.h"
#import "HomeViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "RegisterViewController.h"


@interface LoginViewController : BaseViewController<UITabBarControllerDelegate,UITextFieldDelegate,UIKeyboardViewControllerDelegate>
{
    UIKeyboardViewController *keyBoardController;
}
- (IBAction)onRegister:(id)sender;
- (IBAction)onRegisterFacebook:(id)sender;
- (IBAction)onLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;


@property (nonatomic,retain) UITabBarController *tabbarController;
@property (nonatomic,retain) UINavigationController *notifNavigationViewController;
@property (nonatomic,retain) UINavigationController *searchNavigationViewController;
@property (nonatomic,retain) UINavigationController *historyNavigationViewController;
@property (nonatomic,retain) UINavigationController *profileNavigationViewController;
- (IBAction)useWithOutLogin:(id)sender;

@end
