//
//  ChangePassViewController.m
//  TableCross
//
//  Created by DANGLV on 25/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "ChangePassViewController.h"


@interface ChangePassViewController ()

@end

@implementation ChangePassViewController

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
    [self setupTitle:@"パスワード変更" isShowSetting:NO andBack:YES];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onChangePass:(id)sender {
    [self.txtOldPass resignFirstResponder];
    [self.txtNewPass resignFirstResponder];
    [self.txxNewPassConfirm resignFirstResponder];
    
    if([self.txtNewPass.text isEqualToString:@""] || [self.txtOldPass.text isEqualToString:@""] ||[self.txxNewPassConfirm.text isEqualToString:@""])
    {
        [Util showMessage:@"Please input all fields to continue" withTitle:@"Error"];
        return ;
    }
    if(![self.txtNewPass.text isEqualToString:self.txxNewPassConfirm.text ])
    {
        [Util showMessage:@"New password and confirm password not the same" withTitle:@"Error"];
        return ;
        
    }
    
    START_LOADING;
    [[APIClient sharedClient] changePass:self.txtOldPass.text newPass:self.txtNewPass.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        STOP_LOADING;
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            [Util setValue:self.txtNewPass.text forKey:KEY_PASSWORD];
            
            [Util showMessage:@"Your password was changed successfully" withTitle:kAppNameManager];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
            [Util showError:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        STOP_LOADING;
        SHOW_POUP_NETWORK;
    }];
}
@end
