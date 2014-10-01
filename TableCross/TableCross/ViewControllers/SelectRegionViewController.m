//
//  SelectRegionViewController.m
//  TableCross
//
//  Created by DANGLV on 22/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SelectRegionViewController.h"
#import "LoginViewController.h"

@interface SelectRegionViewController ()
{
    
    NSMutableArray *arrTitle;
    ComboBox *comboBox;
}


@end

@implementation SelectRegionViewController

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
    self.title = @"WELCOME";
    [self.navigationController setNavigationBarHidden:YES];
    
    if(self.arrRegion)
        arrTitle =[[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.arrRegion) {
        [arrTitle addObject:[dict objectForKey:@"areaName"]];
    }
    [self bindDataCombobox];
    [self checkLogin];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     gIsShowHome = FALSE;
}

- (void)checkLogin
{
     if([Util valueForKey:KEY_USER_ID] && ![[NSString stringWithFormat:@"%@",[Util valueForKey:KEY_USER_ID]] isEqualToString:@""])
        {
       
            
            [comboBox setComboBoxTitle:[Util valueForKey:KEY_AREA_NAME]];
            
        START_LOADING;
            [[APIClient sharedClient] login:[Util valueForKey:KEY_EMAIL] pass:[Util valueForKey:KEY_PASSWORD] loginType:[Util valueForKey:KEY_LOGIN_TYPE] areaId:[Util valueForKey:KEY_AREAID] phone:@"" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            STOP_LOADING;
            if([[responseObject objectForKey:@"success"] boolValue])
            {
                gIsLogin = TRUE;
                gNavigationViewController  = self.navigationController;
               
                double delayInSeconds = 0.4;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    gNavigationViewController = self.navigationController;
                    [self.navigationController setNavigationBarHidden:YES];
                    LoginViewController *home =[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                    [self.navigationController pushViewController:home animated:NO];
                });
               
            }
            else
                [Util showError:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            STOP_LOADING;
            SHOW_POUP_NETWORK;
        }];
    }

}

- (void)bindDataCombobox {
    
     comboBox = [[ComboBox alloc]initWithFrame:CGRectMake(50, 235, 220, 36)];
    comboBox.delegate = self;
    [comboBox setComboBoxSize:CGSizeMake(220, 44*3)];
    [self.view addSubview:comboBox];
    
    [comboBox setComboBoxDataArray:arrTitle];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)comboBox:(ComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [self.arrRegion objectAtIndex:indexPath.row]);
    
    [Util setValue:[arrTitle objectAtIndex:indexPath.row] forKey:KEY_AREA_NAME];
    [Util setValue:[[self.arrRegion objectAtIndex:indexPath.row] objectForKey:@"areaId"] forKey:KEY_AREAID];
    
    if(gIsLogin)
        [self checkLogin];
    else
       [self goNext];
}
-(void)goNext {
    
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self.navigationController setNavigationBarHidden:YES];
        LoginViewController *home =[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:home animated:YES];
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
