//
//  SettingViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    [self setupTitle:@"設定" isShowSetting:NO andBack:YES];
    [self initDefaulSetting];
}
 -(void)initDefaulSetting {
     
     self.txtUserId.text =[Util valueForKey:KEY_USER_ID];
     self.txtEmail.text =[Util valueForKey:KEY_EMAIL];
     self.txtPhone.text= [Util valueForKey:KEY_PHONE];
     self.txtBirthday.text = [Util valueForKey:KEY_BIRTHDAY];
     
     if(gIsLoginFacebook)
     {
         
         self.txtUserId.text =[Util valueForKey:@"facebookID"];
         self.txtEmail.text =[Util valueForKey:@"FBemail"];
         self.txtPhone.text= [Util valueForKey:KEY_PHONE];
         self.txtBirthday.text = [Util valueForKey:@"FBbirthdate"];
     }
     
     [((UIButton*)[self.view viewWithTag:4]) setSelected:[Util getBoolValueForKey:KEY_NOTIF_SETTING_1]];
     [((UIButton*)[self.view viewWithTag:5]) setSelected:[Util getBoolValueForKey:KEY_NOTIF_SETTING_2]];
     [((UIButton*)[self.view viewWithTag:6]) setSelected:[Util getBoolValueForKey:KEY_NOTIF_SETTING_3]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}


#pragma mark - IBOutlet Actions

- (void)updateSuccess {
    
    [Util setValue:self.txtUserId.text forKey:KEY_USER_ID];
    [Util setValue:self.txtEmail.text forKey:KEY_EMAIL];
    [Util setValue:self.txtPhone.text forKey:KEY_PHONE];
    [Util setValue:self.txtBirthday.text forKey:KEY_BIRTHDAY];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSave:(id)sender {
    START_LOADING;
    [[APIClient sharedClient] updateUserEmail:self.txtEmail.text phone:self.txtPhone.text birthday:self.txtBirthday.text sucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue])
        {

            [self updateSuccess];
            
        }
        else
            [Util showError:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        
    }];
    
    
}

- (IBAction)onSetttingChange:(id)sender {
    
    UIButton *btn = sender;
    [btn setSelected:![btn isSelected]];
    switch (btn.tag) {
        case 4:
            [Util setBoolValue:btn.isSelected forKey:KEY_NOTIF_SETTING_1];
            break;
        case 5:
            [Util setBoolValue:btn.isSelected forKey:KEY_NOTIF_SETTING_2];
            break;
        case 6:
            [Util setBoolValue:btn.isSelected forKey:KEY_NOTIF_SETTING_3];
            break;
        default:
            break;
    }
}

- (IBAction)onSaveBottom:(id)sender {
    
    START_LOADING;
    [[APIClient sharedClient] logout:@"" succes:^(AFHTTPRequestOperation *operation, id responseObject) {
        STOP_LOADING;
//        if([[responseObject objectForKey:@"success"] boolValue])
//        {
         [gNavigationViewController popViewControllerAnimated:YES];
//        }
//        else
//             [Util showError:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    
    
}

- (IBAction)txtEmail:(id)sender {
}
@end
