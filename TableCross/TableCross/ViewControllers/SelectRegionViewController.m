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

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self checkLogin];
}

- (void)checkLogin
{
        if([Util valueForKey:KEY_USER_ID] && ![[NSString stringWithFormat:@"%@",[Util valueForKey:KEY_USER_ID]] isEqualToString:@""])
        {
        
        START_LOADING;
        [[APIClient sharedClient] login:[Util valueForKey:KEY_EMAIL] pass:[Util valueForKey:KEY_PASSWORD] loginType:@"1" areaId:[Util valueForKey:KEY_AREAID] withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            STOP_LOADING;
            if([[responseObject objectForKey:@"success"] boolValue])
            {
                
                gNavigationViewController  = self.navigationController;
                HomeViewController *home =[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
                double delayInSeconds = 0.4;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self.navigationController pushViewController:home animated:YES];
                });
               
            }
            else
                [Util showError:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            STOP_LOADING;
            SHOW_POUP_NETWORK;
            
        }];
        
       
    }
    
     [self bindDataCombobox];
}

- (void)bindDataCombobox {
    
    ComboBox *comboBox = [[ComboBox alloc]initWithFrame:CGRectMake(50, 235, 220, 36)];
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
    
    
   [self goNext];
    
//    [self performSelector:@selector(goNext) withObject:nil afterDelay:0.5];
}
-(void)goNext {
    
    double delayInSeconds = 0.4;
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
