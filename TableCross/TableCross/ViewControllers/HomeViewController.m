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

 NSInteger currentTab = 1;

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
       
    }
   [self addBackLocationButton];
}

-(void)getHomeRestaurant {
    
    START_LOADING;
    
    [[APIClient sharedClient] getRestaurantInfo:@"-1" withsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        
        if(gIsLogin)
            [self getUserInfo];
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            
            NSDictionary *resDict = [responseObject objectForKey:@"restaurant"];
            homeRestaurant =[[RestaurantObj alloc] initWithDict:resDict];
            
            [self.imgRestaurant setImageWithURL:[NSURL URLWithString:[resDict objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"img_restaurant"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
                if(image)
                    [self.imgRestaurant setImage:image];
            }];
            
            self.lblAddress.text = [resDict objectForKey:@"address"];
            //self.lblAddress.text = @"128 basfhjs   jshg dsajh asdghjsdag jhsdgsag hjsdf hsajfh hjashf";
            self.lblName.text = [resDict objectForKey:@"restaurantName"];
            
            
            self.lblAddress.numberOfLines= 0;
            [self.lblAddress sizeToFit];
            
            CGFloat heightName = [[resDict objectForKey:@"restaurantName"] heightOfTextViewToFitWithFont:[UIFont boldSystemFontOfSize:17.0] andWidth:190];

            CGFloat heightAddress = [ self.lblAddress.text heightOfTextViewToFitWithFont:[UIFont systemFontOfSize:17.0] andWidth:190];

            self.lblName.numberOfLines=0;
            [self.lblName sizeToFit];
            
            [Util moveDow:self.lblAddress offset:(heightName - 44)];
            
            [Util moveDow:self.imgNumberPoint offset:(heightName + heightAddress - 90)];
            [Util moveDow:self.lblNumberMeal offset:(heightName + heightAddress - 90)];
        }
        else
            [Util showError:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        STOP_LOADING;
        SHOW_POUP_NETWORK;
    }];
    
}

-(void)getUserInfo {
    
    START_LOADING;
    [[APIClient sharedClient] getUserInfoWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            [Util setValue:[responseObject objectForKey:@"mobile"] forKey:KEY_PHONE];
            [Util setValue:[responseObject objectForKey:@"userId"] forKey:KEY_USER_ID];
            [Util setValue:[responseObject objectForKey:@"point"] forKey:KEY_POINT];
            [Util setValue:[responseObject objectForKey:@"point"] forKey:KEY_TOTAL_MEAL];
            [Util setValue:[responseObject objectForKey:@"totalPoint"] forKey:KEY_TOTAL_MEAL_VIAAPP];
            [Util setValue:[responseObject objectForKey:@"totalUserShare"] forKey:KEY_TOTAL_SHARE];
            [Util setValue:[responseObject objectForKey:@"birthday"] forKey:KEY_BIRTHDAY];
            
            NSString *numberPoint = [NSString stringWithFormat:@"%@",[Util objectForKey:KEY_TOTAL_MEAL]];

            [Util SetTitleForArrayButton:numberPoint andArray:[NSMutableArray arrayWithObjects:self.number1,self.number2,self.number3,self.number4,self.number5, nil]];
            
//            if([numberPoint length]==1)
//            {
//                [self.number3 setTitle:numberPoint forState:UIControlStateNormal];
//            }
//            else if([numberPoint length]==2)
//            {
//                 [self.number2 setTitle: [NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:0]] forState:UIControlStateNormal];
//                 [self.number3 setTitle:[NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:1]] forState:UIControlStateNormal];
//            }
//            else if([numberPoint length] > 2)
//            {
//                [self.number1 setTitle: [NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:0]] forState:UIControlStateNormal];
//                [self.number2 setTitle: [NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:1]] forState:UIControlStateNormal];
//                [self.number3 setTitle:[NSString stringWithFormat:@"%C",[numberPoint characterAtIndex:2]] forState:UIControlStateNormal];
//
//                
//            }
//            
            
            
        }
          STOP_LOADING;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
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

-(void) pushToHomeView
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:_tabbarController animated:YES];
//    [self getNumberNotificationUnPush];

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
            currentTab = _tabbarController.selectedIndex;
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
        
        [_tabbarController setSelectedIndex:currentTab];
}

@end
