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
    
    [self setupData];
}

-(void)setupData{
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    
    [self.tabBarController setSelectedIndex:2];
}
@end
