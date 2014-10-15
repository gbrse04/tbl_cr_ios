//
//  ProfileViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    [self setupTitle:@"マイページ" isShowSetting:YES andBack:FALSE];
    
    [self addBackLocationButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupData) name:NOTIF_LOGOUT object:nil];
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setupData];
}
-(void)setupData{
    
    if(!gIsLogin)
    {
        
        [Util setValue:@"0" forKey:KEY_POINT];
        [Util setValue:@"0" forKey:KEY_TOTAL_MEAL_VIAAPP];
        [Util setValue:@"0" forKey:KEY_TOTAL_SHARE];
        
    }
    
    NSString *numberPoint = [NSString stringWithFormat:@"%@",[Util objectForKey:KEY_POINT]];
    
    [Util SetTitleForArrayButton:numberPoint andArray:[NSMutableArray arrayWithObjects:self.number1,self.number2,self.number3,self.number4,self.number5, nil]];
    
    NSString *totalOrder = [NSString stringWithFormat:@"%@",[Util objectForKey:KEY_TOTAL_MEAL_VIAAPP]];

    [Util SetTitleForArrayButton:totalOrder andArray:[NSMutableArray arrayWithObjects:self.number6,self.number7,self.number8,self.number9,self.number10, nil]];
    
    self.lblInfo.text = [NSString stringWithFormat:@"あなた紹介したユーザーは%@人です ",[Util valueForKey:KEY_TOTAL_SHARE]];
    

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    
    [self.tabBarController setSelectedIndex:2];
}
@end
