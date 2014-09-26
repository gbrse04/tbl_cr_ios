//
//  HomeViewController.m
//  TableCross
//
//  Created by TableCross on 16/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "HomeViewController.h"
#import "RestaurantObj.h"

@interface HomeViewController ()
{
    RestaurantObj *homeRestaurant;
    
}

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
    

//    [self initTabbar];
    self.navigationItem.hidesBackButton = YES;
//    [self performSelector:@selector(pushToHomeView) withObject:nil afterDelay:2];

//    if(gIsLogin)
//        [self getUserInfo];
//    
//    [self getHomeRestaurant];
    if(!self.isNeedLoadData)
    {
        [self initTabbar];
        [self pushToHomeView];
    }
    else
    {
        [self getHomeRestaurant];
        if(gIsLogin)
        [self getUserInfo];
    }
    
}

-(void)getHomeRestaurant {
    
    START_LOADING;
    
    [[APIClient sharedClient] getRestaurantInfo:@"-1" withsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            
            NSDictionary *resDict = [responseObject objectForKey:@"restaurant"];
            homeRestaurant =[[RestaurantObj alloc] initWithDict:resDict];
            
            [self.imgRestaurant setImageWithURL:[NSURL URLWithString:[resDict objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"img_restaurant"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
                if(image)
                    [self.imgRestaurant setImage:image];
            }];
            
            self.lblAddress.text = [resDict objectForKey:@"address"];
            self.lblName.text = [resDict objectForKey:@"restaurantName"];
        }
        else
            [Util showError:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        STOP_LOADING;
        SHOW_POUP_NETWORK;
    }];
    
}

-(void)getUserInfo {
    
    
    [[APIClient sharedClient] getUserInfoWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            [Util setValue:[responseObject objectForKey:@"mobile"] forKey:KEY_PHONE];
            [Util setValue:[responseObject objectForKey:@"userId"] forKey:KEY_USER_ID];
            [Util setValue:[responseObject objectForKey:@"point"] forKey:KEY_POINT];
            [Util setValue:[responseObject objectForKey:@"orderCount"] forKey:KEY_TOTAL_MEAL];
            [Util setValue:[responseObject objectForKey:@"birthday"] forKey:KEY_BIRTHDAY];
            
            NSString *numberPoint = [NSString stringWithFormat:@"%@",[Util objectForKey:KEY_TOTAL_MEAL]];

            if([numberPoint length]==1)
            {
                [self.number3 setTitle:numberPoint forState:UIControlStateNormal];
            }
            else if([numberPoint length]==2)
            {
                 [self.number2 setTitle: [NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:0]] forState:UIControlStateNormal];
                 [self.number3 setTitle:[NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:1]] forState:UIControlStateNormal];
            }
            else if([numberPoint length] > 2)
            {
                [self.number1 setTitle: [NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:0]] forState:UIControlStateNormal];
                [self.number2 setTitle: [NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:1]] forState:UIControlStateNormal];
                [self.number3 setTitle:[NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:2]] forState:UIControlStateNormal];

                
            }
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
    
    [_tabbarController setSelectedIndex:1];
    
    [_tabbarController.tabBar setBackgroundImage:[UIImage imageNamed:@"bg_tab.png"]];
    
    [[_tabbarController tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"bg_tab_selected"]];
    
    
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(gIsLogin)
    {
    
        NSInteger tabitem = _tabbarController.selectedIndex;
        [[tabBarController.viewControllers objectAtIndex:tabitem] popToRootViewControllerAnimated:YES];
    }
    else
    {
        if(_tabbarController.selectedIndex !=1)
         [_tabbarController setSelectedIndex:1];
        [[tabBarController.viewControllers objectAtIndex:_tabbarController.selectedIndex] popToRootViewControllerAnimated:YES];
    }
    
}

-(void) pushToHomeView
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:_tabbarController animated:YES];
    [self getNumberNotificationUnPush];

}


//Refresh Number Unpush each REFRESH_TIME

-(void)startTrackingNumberUnpush{
    
    [NSTimer scheduledTimerWithTimeInterval:TIME_REFRESH target:self selector:@selector(getNumberNotificationUnPush) userInfo:nil repeats:YES];

}

-(void)getNumberNotificationUnPush{
    
    [[APIClient sharedClient] getListUnpushNotifiycationWithsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            NSInteger numberBadge = [[responseObject objectForKey:@"items"] count];
            // Set Badge number
            if(numberBadge>0)
                [[super.tabBarController.viewControllers objectAtIndex:0] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d",numberBadge];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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

- (IBAction)onShowDetail:(id)sender {
    
    RestaurantDetailViewController *vc = [[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
    vc.restaurant = homeRestaurant;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
