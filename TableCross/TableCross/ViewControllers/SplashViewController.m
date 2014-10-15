//
//  SplashViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SplashViewController.h"
#import "ChooseRegionViewController.h"
#import "ChooseRegionViewController.h"
#import "HomeViewController.h"
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
    
//    [self performSelector:@selector(loadListRegion) withObject:nil afterDelay:3];
}
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self performSelector:@selector(loadListRegion) withObject:nil afterDelay:2];
    
    self.viewOverlay.layer.cornerRadius = 8.0;

}
- (void)loadListRegion{
    if(gIsHasNetwork)
    {
    [[APIClient sharedClient] getListAresWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
          NSArray *arrData =[responseObject objectForKey:@"items"];
            
            SelectRegionViewController *vc=[[SelectRegionViewController alloc] initWithNibName:@"SelectRegionViewController" bundle:nil];
            vc.arrRegion = arrData;
            [self.navigationController pushViewController:vc animated:YES];
            
//            HomeViewController *vc=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];

            
         }
        else
        {
            [Util showError:responseObject];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

        SHOW_POUP_NETWORK;
        
    }];
    }
    else
        SHOW_POUP_NETWORK;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
