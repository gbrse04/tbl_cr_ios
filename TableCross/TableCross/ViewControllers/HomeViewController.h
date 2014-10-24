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
#import "NSString+TextSize.h"
#import "MarqueeLabel.h"


@interface HomeViewController : BaseViewController<UITabBarControllerDelegate,UIAlertViewDelegate>

@property (assign, nonatomic) BOOL isNeedLoadData;

@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblName;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lblAddress;

@property (weak, nonatomic) IBOutlet UIButton *number1;

@property (weak, nonatomic) IBOutlet UIButton *number2;

@property (weak, nonatomic) IBOutlet UIButton *number3;

@property (weak, nonatomic) IBOutlet UIButton *number4;

@property (weak, nonatomic) IBOutlet UIButton *number5;

@property (weak, nonatomic) IBOutlet UILabel *lblNumberMeal;

@property (weak, nonatomic) IBOutlet UIImageView *imgNumberPoint;
@property (nonatomic,retain) UITabBarController *tabbarController;
@property (nonatomic,retain) UINavigationController *notifNavigationViewController;
@property (nonatomic,retain) UINavigationController *searchNavigationViewController;
@property (nonatomic,retain) UINavigationController *historyNavigationViewController;
@property (nonatomic,retain) UINavigationController *profileNavigationViewController;

- (IBAction)onTabOne:(id)sender;
- (IBAction)onTabTwo:(id)sender;
- (IBAction)onTabThree:(id)sender;

- (IBAction)onTabFour:(id)sender;
- (IBAction)onShowDetail:(id)sender;

@end
