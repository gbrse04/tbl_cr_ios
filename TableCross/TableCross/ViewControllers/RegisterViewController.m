//
//  RegisterViewController.m
//  TableCross
//
//  Created by TableCross on 15/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end



@implementation RegisterViewController

NSInteger currentTabLogin;

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
    self.navigationItem.title = @"サインアップ";
    [self.txtEmail setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txtPassword setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txtPasswordConfirm setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txtPhone setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
 
    self.navigationItem.hidesBackButton = NO;
    
//    [self initTabbar];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    //[datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
//    [self.txt setInputView:datePicker];
    
    [self initTabbar];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.navigationItem.backBarButtonItem setTitle:@"ログイン"];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)onLogin:(id)sender {
    
    if(![Util isValidEmail:self.txtEmail.text])
    {
        [Util showMessage:msg_invalid_email withTitle:kAppNameManager];
        return;
    }
    if([self.txtEmail.text isEqualToString:@""] || [self.txtPassword.text isEqualToString:@""] || [self.txtPhone.text isEqualToString:@""])
    {
        [Util showMessage:msg_input_required_field withTitle:kAppNameManager];
        return;
    }
     if(![self.txtPassword.text isEqualToString:self.txtPasswordConfirm.text])
     {
         [Util showMessage:msg_password_notmatch withTitle:kAppNameManager];
         return;
     }

    
        if(![self.txtEmail.text isEqualToString:@""] && ![self.txtPassword.text isEqualToString:@""])
            
        {
            START_LOADING ;
            
            [[APIClient sharedClient] registerWithEmail:self.txtEmail.text pass:self.txtPassword.text phone:self.txtPhone.text birthday:@"" regionId:[Util valueForKey:KEY_AREAID] refUserId:[Util getUDID] withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
               
                STOP_LOADING;
                if([[responseObject objectForKey:@"success"] boolValue])
                {
                
                    [self login:self.txtEmail.text andPass:self.txtPassword.text];
                }
                else
                {
                    [Util showError:responseObject];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                STOP_LOADING;
                SHOW_NETWORK_ERROR;
            }];
        }
        else {
            
            [Util showMessage:msg_input_required_field withTitle:kAppNameManager];
        }
}
-(void)login :(NSString*)email andPass:(NSString*)pass {
    
    START_LOADING;
    
    [[APIClient sharedClient] login:email pass:pass loginType:@"0" areaId:[Util valueForKey:KEY_AREAID] phone:@"" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue])
        {
             gIsLogin = true;
            //Save username and pass
            [Util setValue:self.txtEmail.text  forKey:KEY_EMAIL];
            [Util setValue:self.txtPassword.text  forKey:KEY_PASSWORD];
            [Util setValue:@"0" forKey:KEY_LOGIN_TYPE];
            [Util setValue:[responseObject objectForKey:@"phone"] forKey:KEY_PHONE];
            [Util setValue:[responseObject objectForKey:@"userId"] forKey:KEY_USER_ID];
            [Util setValue:[responseObject objectForKey:@"point"] forKey:KEY_POINT];
            [Util setValue:[responseObject objectForKey:@"orderCount"] forKey:KEY_TOTAL_MEAL];
            [Util setValue:[responseObject objectForKey:@"birthday"] forKey:KEY_BIRTHDAY];
            [Util setValue:[responseObject objectForKey:@"shareLink"] forKey:KEY_SHARELINK];
            
            [self pushToHomeView];
        }
        else
        {
            [Util showError:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    

    
    
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
                                                            [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
                                                            nil] forState:UIControlStateNormal];
    
    [notifViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                            [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
                                                            nil] forState:UIControlStateSelected];
    
    _notifNavigationViewController = [[UINavigationController alloc] initWithRootViewController:notifViewController];
    
    [controllers addObject:_notifNavigationViewController];
    
    
    //category tab view controller
    SearchHomeViewController *searchHomeViewController = [[SearchHomeViewController alloc] initWithNibName:@"SearchHomeViewController" bundle:nil];
    searchHomeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"店舗検査" image:[UIImage imageNamed:@"ic_tab_search"] tag:0];
    [searchHomeViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_search"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_search"]];
    
    [searchHomeViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                                 [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                 [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
                                                                 nil] forState:UIControlStateNormal];
    
    [searchHomeViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                                 [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                 [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
                                                                 nil] forState:UIControlStateSelected];
    
    _searchNavigationViewController = [[UINavigationController alloc] initWithRootViewController:searchHomeViewController];
    
    [controllers addObject:_searchNavigationViewController];
    
    //  video tab view controller
    ShareViewController *profileViewController = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"友達紹介" image:[UIImage imageNamed:@"ic_tab_share"] tag:0];
    [profileViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_share"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_share"]];
    
    [profileViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
                                                              nil] forState:UIControlStateNormal];
    
    [profileViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
                                                              nil] forState:UIControlStateSelected];
    
    _historyNavigationViewController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    
    [controllers addObject:_historyNavigationViewController];
    
    
    
    
    ProfileViewController  *settingViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    settingViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"マイページ" image:[UIImage imageNamed:@"ic_tab_user"] tag:0];
    [settingViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"ic_tab_user"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_user"]];
    
    [settingViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_ACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
                                                              nil] forState:UIControlStateNormal];
    
    [settingViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              COLOR_INACTIVE, UITextAttributeTextColor,[UIColor colorWithWhite:1 alpha:1], UITextAttributeTextShadowColor,
                                                              [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                              [UIFont boldSystemFontOfSize:10], UITextAttributeFont,
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


-(void) pushToHomeView
{
    self.txtEmail.text = @"";
    self.txtPassword.text = @"";
    [_tabbarController setSelectedIndex:1];
    gNavigationViewController = self.navigationController;
      [self.navigationController pushViewController:_tabbarController animated:YES];
}



#pragma mark - Tabbar Delegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    if(gIsLogin)
    {
        
        NSInteger tabitem = _tabbarController.selectedIndex;
        [[tabBarController.viewControllers objectAtIndex:tabitem] popToRootViewControllerAnimated:YES];
        if(tabitem == 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RELOAD_NOTIFICATION object:nil];
            
            
        }
        
    }
    else
    {
        if((_tabbarController.selectedIndex == 1) || (_tabbarController.selectedIndex == 2 ))
        {
            currentTabLogin = _tabbarController.selectedIndex;
            [_tabbarController setSelectedIndex: _tabbarController.selectedIndex];
            [[tabBarController.viewControllers objectAtIndex:_tabbarController.selectedIndex] popToRootViewControllerAnimated:YES];
        }
        else
        {
            
            [Util showMessage:kMessageLoginRequired withTitle:kAppNameManager cancelButtonTitle:btn_cancel otherButtonTitles:@"OK" delegate:self andTag:1];
            
        }
    }
}

@end
