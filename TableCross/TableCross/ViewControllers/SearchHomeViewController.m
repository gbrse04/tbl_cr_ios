//
//  SearchHomeViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SearchHomeViewController.h"
#import "SearchLocationViewController.h"
#import "SearchByConditionViewController.h"
#import "SearchResultViewController.h"
#import "HomeViewController.h"


@interface SearchHomeViewController ()

@end

@implementation SearchHomeViewController

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
    [self setupTitle:@"検索" isShowSetting:YES andBack:FALSE];
    
    if(!gIsShowHome && gIsLogin)
    {
        HomeViewController *vc =[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        
        vc.isNeedLoadData = TRUE;
        gIsShowHome = TRUE;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [self addBackLocationButton];
    
    [self startTrackingNumberUnpush];
    
}

//Refresh Number Unpush each REFRESH_TIME

-(void)startTrackingNumberUnpush{
    
    [self getNumberNotificationUnPush];
    [NSTimer scheduledTimerWithTimeInterval:TIME_REFRESH target:self selector:@selector(getNumberNotificationUnPush) userInfo:nil repeats:YES];
    
}

-(void)getNumberNotificationUnPush{
    
    if(gIsLogin)
        
    {
    
    [[APIClient sharedClient] getListUnpushNotifiycationWithsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response get unpush : %@",responseObject);
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
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"検索";
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSearch1Click:(id)sender {
    
    SearchByConditionViewController *vc= [[SearchByConditionViewController alloc] initWithNibName:@"SearchByConditionViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onSearch2Click:(id)sender {
    SearchLocationViewController *vc= [[SearchLocationViewController alloc] initWithNibName:@"SearchLocationViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onSearch3Click:(id)sender {
    SearchHistoryViewController *vc= [[SearchHistoryViewController alloc] initWithNibName:@"SearchHistoryViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onSearch4Click:(id)sender {
    SearchBySpecifyViewController *vc= [[SearchBySpecifyViewController alloc] initWithNibName:@"SearchBySpecifyViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
