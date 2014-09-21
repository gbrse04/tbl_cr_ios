//
//  RegisterViewController.m
//  TableCross
//
//  Created by DANGLV on 15/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

#define COLOR_ACTIVE kColorOrange
#define COLOR_INACTIVE [UIColor whiteColor]

@implementation RegisterViewController

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
    self.navigationItem.hidesBackButton = YES;
    self.title = @"SIGN UP";
    
    [self initTabbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRegisterFacebook:(id)sender {
}

- (IBAction)onLinkClick:(id)sender {
}

-(void)initTabbar
{
    _tabbarController = [[UITabBarController alloc] init];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    //home tab view controllers
    NotificationViewController *notifViewController = [[NotificationViewController alloc] initWithNibName:@"NotificationViewController" bundle:nil];
    notifViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Login" image:[UIImage imageNamed:@"ic_tab_mybooking.png"] tag:0];
    [notifViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_notification"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_notification"]];
    [notifViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                            [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                            nil] forState:UIControlStateNormal];
    [notifViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                            [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                            nil] forState:UIControlStateSelected];
    _notifNavigationViewController = [[UINavigationController alloc] initWithRootViewController:notifViewController];
    
    [controllers addObject:_notifNavigationViewController];
    
    
    //category tab view controller
    SearchHomeViewController *searchHomeViewController = [[SearchHomeViewController alloc] initWithNibName:@"SearchHomeViewController" bundle:nil];
    searchHomeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"ic_newbooking.png"] tag:0];
    [searchHomeViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_search"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_search"]];
    [searchHomeViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                                 [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                                 [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                                 nil] forState:UIControlStateNormal];
    [searchHomeViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                                 [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                                 [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                                 nil] forState:UIControlStateSelected];
    _searchNavigationViewController = [[UINavigationController alloc] initWithRootViewController:searchHomeViewController];
    
    [controllers addObject:_searchNavigationViewController];
    
    //  video tab view controller
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Share" image:[UIImage imageNamed:@"ic_tab_contact.png"] tag:0];
    [profileViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_share"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_share"]];
    [profileViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                               COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                               [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                               [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                               nil] forState:UIControlStateNormal];
    [profileViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                               COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                               [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                               [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                               nil] forState:UIControlStateSelected];
    _historyNavigationViewController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    
    [controllers addObject:_historyNavigationViewController];
    
    
    
    //About tab view controller
    SettingViewController  *settingViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    settingViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Setting" image:[UIImage imageNamed:@"ic_tab_recommend.png"] tag:0];
    [settingViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_user"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_user"]];
    [settingViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                                [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                                [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                                nil] forState:UIControlStateNormal];
    
    [settingViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:0.0 alpha:0.3], UITextAttributeTextShadowColor,
                                                                [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                                [UIFont boldSystemFontOfSize:11], UITextAttributeFont,
                                                                nil] forState:UIControlStateSelected];
    _profileNavigationViewController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    
    [controllers addObject:_profileNavigationViewController];
    
    
    _tabbarController.viewControllers = controllers;
    _tabbarController.customizableViewControllers = controllers;
    _tabbarController.delegate = self;
    
    
    [_tabbarController.tabBar setBackgroundImage:[UIImage imageNamed:@"bg_tab.png"]];
    //    [[_tabbarController tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"bg_tab_selected.png"]];
    
    [self performSelector:@selector(pushToHomeView) withObject:nil afterDelay:2.0];
    
    
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

@end
