//
//  SearchByConditionViewController.m
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SearchByConditionViewController.h"
#import "SearchResultViewController.h"

@interface SearchByConditionViewController ()

@end

@implementation SearchByConditionViewController

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
    
    [self setupTitle:@"条件から探す" isShowSetting:YES andBack:YES];
    [self.lblSearch1 setShouldUnderline:YES];
    [self.lblSearch2 setShouldUnderline:YES];
    [self.lblSearch3 setShouldUnderline:YES];
    [self.lblSearch4 setShouldUnderline:YES];
    [self.txtSearch setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"条件から探す";
    [self.navigationController.navigationBar.backItem setTitle:@"検索"];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"履歴検索";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if(![textField.text isEqualToString:@""])
    {
        SearchResultViewController *vc =[[SearchResultViewController alloc] initWithNibName:@"SearchResultViewController" bundle:nil];
        vc.searchType = SearchByCondition ;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    return  YES;
}

@end
