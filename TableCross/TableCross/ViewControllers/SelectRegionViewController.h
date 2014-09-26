//
//  SelectRegionViewController.h
//  TableCross
//
//  Created by DANGLV on 22/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "ComboBoxCell.h"
#import "ComboBox.h"
#import "RegisterViewController.h"

@interface SelectRegionViewController : BaseViewController<ComBoxDelegate>
@property (nonatomic,retain) NSArray *arrRegion;
@property (nonatomic,retain) UITabBarController *tabbarController;
@property (nonatomic,retain) UINavigationController *notifNavigationViewController;
@property (nonatomic,retain) UINavigationController *searchNavigationViewController;
@property (nonatomic,retain) UINavigationController *historyNavigationViewController;
@property (nonatomic,retain) UINavigationController *profileNavigationViewController;

@end
