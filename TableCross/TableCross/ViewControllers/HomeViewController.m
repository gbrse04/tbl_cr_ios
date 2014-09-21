//
//  HomeViewController.m
//  TableCross
//
//  Created by DANGLV on 16/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO];
    
    [self setupTitle:@"ホーム" isShowSetting:NO andBack:NO];
    [self initTabbar];
    self.navigationItem.hidesBackButton = YES;
//    [self performSelector:@selector(pushToHomeView) withObject:nil afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTabbar
{
    _tabbarController = [[UITabBarController alloc] init];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    //home tab view controllers
    NotificationViewController *notifViewController = [[NotificationViewController alloc] initWithNibName:@"NotificationViewController" bundle:nil];
    notifViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"お知らせ" image:[UIImage imageNamed:@"ic_tab_notification"] tag:0];
    [notifViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_notification"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_notification"]];
    
    
    [notifViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                            [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                            nil] forState:UIControlStateNormal];
    
    [notifViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                            [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                            nil] forState:UIControlStateSelected];
    
    _notifNavigationViewController = [[UINavigationController alloc] initWithRootViewController:notifViewController];
    
    [controllers addObject:_notifNavigationViewController];
    
    
    //category tab view controller
    SearchHomeViewController *searchHomeViewController = [[SearchHomeViewController alloc] initWithNibName:@"SearchHomeViewController" bundle:nil];
    searchHomeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"検索" image:[UIImage imageNamed:@"ic_tab_search"] tag:0];
    [searchHomeViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_search"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_search"]];
    
    [searchHomeViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                                 [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                 [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                                 nil] forState:UIControlStateNormal];
    
    [searchHomeViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                                 [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                 [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                                 nil] forState:UIControlStateSelected];
    
    _searchNavigationViewController = [[UINavigationController alloc] initWithRootViewController:searchHomeViewController];
    
    [controllers addObject:_searchNavigationViewController];
    
    //  video tab view controller
    ShareViewController *profileViewController = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"紹介" image:[UIImage imageNamed:@"ic_tab_share"] tag:0];
    [profileViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_share"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_share"]];
    
    [profileViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                              nil] forState:UIControlStateNormal];
    
    [profileViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                              nil] forState:UIControlStateSelected];
    
    _historyNavigationViewController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    
    [controllers addObject:_historyNavigationViewController];
    
    
    
    
    ProfileViewController  *settingViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    settingViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"マイページ" image:[UIImage imageNamed:@"ic_tab_user"] tag:0];
    [settingViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_user"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_user"]];
    
    [settingViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                              nil] forState:UIControlStateNormal];
    
    [settingViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                              nil] forState:UIControlStateSelected];
    
    _profileNavigationViewController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    
    [controllers addObject:_profileNavigationViewController];
    
    
    _tabbarController.viewControllers = controllers;
    _tabbarController.customizableViewControllers = controllers;
    _tabbarController.delegate = self;
    //Hide text tabbar item
    [_tabbarController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-30,0)];
    
    [_tabbarController.tabBar setBackgroundImage:[UIImage imageNamed:@"bg_tab.png"]];
    
    [[_tabbarController tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"bg_tab_selected"]];
    
    
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger tabitem = _tabbarController.selectedIndex;
    [[tabBarController.viewControllers objectAtIndex:tabitem] popToRootViewControllerAnimated:YES];
    
}

-(void) pushToHomeView
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:_tabbarController animated:YES];
}

- (IBAction)onTabOne:(id)sender {
    
    [_tabbarController setSelectedIndex:0];
    [self pushToHomeView];
}

- (IBAction)onTabTwo:(id)sender {
    [_tabbarController setSelectedIndex:1];
    [self pushToHomeView];
}

- (IBAction)onTabThree:(id)sender {
    [_tabbarController setSelectedIndex:2];
    [self pushToHomeView];
}

- (IBAction)onTabFour:(id)sender {
    [_tabbarController setSelectedIndex:3];
    [self pushToHomeView];
}

@end
