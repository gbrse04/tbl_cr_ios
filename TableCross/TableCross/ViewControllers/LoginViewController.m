//
//  LoginViewController.m
//  TableCross
//
//  Created by TableCross on 17/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
   
}

@end


@implementation LoginViewController

 NSInteger currentTabLogin = 1;

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
    
    [self.txtEmail setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txtPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    gNavigationViewController = self.navigationController;
    self.navigationItem.title = @"ログイン";

    [self initTabbar];
    
    if(gIsLogin)
       [self  pushToHomeView];
    
}


-(void)createFakeData {
    gArrRestaurant = [[NSMutableArray alloc] init];
    
    RestaurantObj *obj = [[RestaurantObj alloc] init];
    
    obj.name = @"McDonald's Kagurazaka ";
    obj.address = @"124-6 Yaraicho Shinjuku, Tokyo 162-0805";
    obj.imageUrl = @"http://www.sott.net/image/s5/109922/medium/mcdonalds.jpg";
    obj.description = @"Classic, long-running fast-food chain known for its burgers, fries & shakes";
    obj.phone = @"+81 3-5206-1836";
    obj.website = @"http://www.mcdonalds.co.jp/";
    obj.orderDate = @"2014/09/23";
    obj.latitude = @"35.7037931";
    obj.longitude = @"139.7402782";
    
    [gArrRestaurant addObject:obj];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
	keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}

- (IBAction)onRegister:(id)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onRegisterFacebook:(id)sender {
    
  
    //Clear old session
    [FBSession.activeSession closeAndClearTokenInformation];
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for(NSHTTPCookie *cookie in [storage cookies])
    {
        NSString *domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
    START_LOADING;
    NSArray *permissions = [NSArray arrayWithObjects:@"user_checkins",@"email", @"user_about_me",@"user_birthday"/*,@"publish_actions"*/,nil];
    // if the session is closed, then we open it here, and establish a handler for state changes
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState state,
                                                      NSError *error) {
                                      
                                      if (error) {
                                          STOP_LOADING;
                                          [FBSession.activeSession closeAndClearTokenInformation];
                                          NSLog(@"error:%@",error);
                                          [Util showMessage:@"Login error" withTitle:@"Error"];
                                      } else if (session.isOpen) {
                                          [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                                              if (!error)
                                              {
                                                  //NSString *storeUserName = user.name;
                                                  
                                                  NSString *storeEmail = [user objectForKey:@"email"];
                                                  NSString *storeFirstname = user.first_name;
                                                  NSString *storeLastname = user.last_name;
                                                  NSString *storeBirthdate = user.birthday;
                                                  
                                                  
                                                  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                                                  
                                                  [userDefault setValue:user.id forKey:@"facebookID"];
                                                  [userDefault setValue:storeEmail forKey:@"FBemail"];
                                                  [userDefault setValue:storeFirstname forKey:@"FBfirst_name"];
                                                  [userDefault setValue:storeLastname forKey:@"FBlast_name"];
                                                  [userDefault setValue:storeBirthdate forKey:@"FBbirthdate"];
                                                  [userDefault synchronize];
                                                  
                                                  DebugLog(@"%@----%@", user.id, storeEmail);
                                                  
                                                  [self loginFacebook:storeEmail];
                                               
                                              }
                                          }];
                                          // If the Facebook app isn't available, show the Feed dialog as a fallback
                                          
                                          
                                      }
                                      
                                  }];
    
    
}

- (IBAction)onLogin:(id)sender {
    
    if([self.txtEmail.text isEqualToString:@""] && [self.txtPassword.text isEqualToString:@""])
        [Util showMessage:@"Please input your email and password" withTitle:@"Error"];
    
    else if(![Util isValidEmail:self.txtEmail.text])
       [Util showMessage:@"Invalid email address" withTitle:@"Error"];
    else
    {
    START_LOADING;
    
    [[APIClient sharedClient] login:self.txtEmail.text pass:self.txtPassword.text loginType:@"0" areaId:[Util valueForKey:KEY_AREAID] phone:@"" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
//    [self pushToHomeView];
}

-(void)loginFacebook:(NSString*)email {
    START_LOADING;
    
    [[APIClient sharedClient] login:email pass:@"" loginType:@"1" areaId:[Util valueForKey:KEY_AREAID] phone:@"" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        STOP_LOADING;
        gIsLoginFacebook = TRUE;
        if([[responseObject objectForKey:@"success"] boolValue])
        {
             gIsLogin = true;
            //Save username and pass
            [Util setValue:email  forKey:KEY_EMAIL];
            [Util setValue:@""  forKey:KEY_PASSWORD];
            [Util setValue:@"1" forKey:KEY_LOGIN_TYPE];
            [Util setValue:[responseObject objectForKey:@"phone"] forKey:KEY_PHONE];
            [Util setValue:[responseObject objectForKey:@"userId"] forKey:KEY_USER_ID];
            [Util setValue:[responseObject objectForKey:@"point"] forKey:KEY_POINT];
            [Util setValue:[Validator getSafeString:[responseObject objectForKey:@"orderCount"]] forKey:KEY_TOTAL_MEAL];
            [Util setValue:[responseObject objectForKey:@"birthday"] forKey:KEY_BIRTHDAY];
            [Util setValue:[responseObject objectForKey:@"shareLink"] forKey:KEY_SHARELINK];
            
            [self pushToHomeView];
        }
        else
        {
            [Util showMessage:[responseObject objectForKey:@"errorMess"] withTitle:@"Error"];
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
    searchHomeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"検索" image:[UIImage imageNamed:@"ic_tab_search"] tag:0];
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
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"紹介" image:[UIImage imageNamed:@"ic_tab_share"] tag:0];
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
    
//    HomeViewController *vc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    
    [self.navigationController pushViewController:_tabbarController animated:YES];
}


- (IBAction)useWithOutLogin:(id)sender {
    
    gIsLogin = FALSE;
    [self getShareLinkApp];
    gNavigationViewController = self.navigationController;
    [_tabbarController setSelectedIndex:1];
    [self pushToHomeView];
}

-(void)getShareLinkApp
{
    [[APIClient sharedClient]  getShareLinkWithsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            [Util setValue:[responseObject objectForKey:@"shareLink"] forKey:KEY_SHARELINK];
        }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - Tabbar Delegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    if(gIsLogin)
    {
        
        NSInteger tabitem = _tabbarController.selectedIndex;
        [[tabBarController.viewControllers objectAtIndex:tabitem] popToRootViewControllerAnimated:YES];
        if(tabitem == 0)
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RELOAD_NOTIFICATION object:nil];

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
            
            [Util showMessage:kMessageLoginRequired withTitle:kAppNameManager cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK" delegate:self andTag:1];
            
        }
    }
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex==1)
    {
        [self backToLogin];
    }
    else
        
        [_tabbarController setSelectedIndex:currentTabLogin];
    
}
@end
