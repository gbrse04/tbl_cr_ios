//
//  HomeViewController.h
//  TableCross
//
//  Created by TableCross on 16/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "SearchHomeViewController.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "NotificationViewController.h"
#import "ShareViewController.h"
#import "UIKeyboardViewController.h"

@interface HomeViewController : BaseViewController<UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) IBOutlet UIButton *number1;

@property (weak, nonatomic) IBOutlet UIButton *number2;

@property (weak, nonatomic) IBOutlet UIButton *number3;

@property (nonatomic,retain) UITabBarController *tabbarController;
@property (nonatomic,retain) UINavigationController *notifNavigationViewController;
@property (nonatomic,retain) UINavigationController *searchNavigationViewController;
@property (nonatomic,retain) UINavigationController *historyNavigationViewController;
@property (nonatomic,retain) UINavigationController *profileNavigationViewController;

- (IBAction)onTabOne:(id)sender;
- (IBAction)onTabTwo:(id)sender;
- (IBAction)onTabThree:(id)sender;

- (IBAction)onTabFour:(id)sender;

@end