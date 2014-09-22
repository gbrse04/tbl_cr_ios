//
//  SplashViewController.m
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SplashViewController.h"
#import "ChooseRegionViewController.h"
@interface SplashViewController ()

@end

@implementation SplashViewController

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
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if(gIsHasNetwork)
       [self loadListRegion];
    else
        SHOW_POUP_NETWORK;
        
}
- (void)loadListRegion{
    
    [[APIClient sharedClient] getListAresWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject && [responseObject objectForKey:@""])
        {
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        SHOW_POUP_NETWORK;
        
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goNext {
    
    ChooseRegionViewController *vc=[[ChooseRegionViewController alloc] initWithNibName:@"ChooseRegionViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
