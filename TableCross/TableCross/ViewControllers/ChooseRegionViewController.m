//
//  ChooseRegionViewController.m
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "ChooseRegionViewController.h"
#import "SearchLocationViewController.h"
#import "LoginViewController.h"
@interface ChooseRegionViewController ()


@end

@implementation ChooseRegionViewController

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
    [self bindDataCombobox];
}
- (void)bindDataCombobox {
    
    ComboBox *comboBox = [[ComboBox alloc]initWithFrame:CGRectMake(50, 235, 220, 36)];
    comboBox.delegate = self;
    [comboBox setComboBoxSize:CGSizeMake(220, 44*3)];
    [self.view addSubview:comboBox];
    
    self.arrRegion = [[NSMutableArray alloc] initWithObjects:@"東京",@"大阪府",@"愛知県",@"千葉県",@"Kansai",@"Okinawa" ,nil];
    
    [comboBox setComboBoxDataArray:self.arrRegion];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)comboBox:(ComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", [self.arrRegion objectAtIndex:indexPath.row]);
//    
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
//
//    SearchByLocationViewController *vc = [[SearchByLocationViewController alloc] initWithNibName:@"SearchByLocationViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
