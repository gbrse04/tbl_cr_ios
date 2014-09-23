//
//  ChooseRegionViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "ChooseRegionViewController.h"
#import "SearchLocationViewController.h"
#import "LoginViewController.h"
#import "SplashViewController.h"
@interface ChooseRegionViewController ()
{
    
    NSMutableArray *arrTitle;
}

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
    
    if(self.arrRegion)
        arrTitle =[[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.arrRegion) {
        [arrTitle addObject:[dict objectForKey:@"areaName"]];
    }
    
   // [self bindDataCombobox];
    
    [self goNext];
    
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
    
    [self performSelector:@selector(goNext) withObject:nil afterDelay:0.2];
}
-(void)goNext {
    
    SplashViewController *vc=[[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
