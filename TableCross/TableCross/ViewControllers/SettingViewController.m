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
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtBirthday setInputView:datePicker];
    
    [self.scrollMain setContentSize:CGSizeMake(self.scrollMain.frame.size.width, 440)];
    

    
}
-(void)updateTextField:(UIDatePicker *)dtPicker{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"dd/MM/yyyy"];
    self.txtBirthday.text = [timeFormatter stringFromDate:dtPicker.date];
}
 -(void)initDefaulSetting {
     
     self.txtUserId.text = [NSString stringWithFormat:@"%@",[Util valueForKey:KEY_USER_ID]];
     self.txtEmail.text = [Util valueForKey:KEY_EMAIL];
     self.txtPhone.text= [Util valueForKey:KEY_PHONE];
     self.txtBirthday.text = [Util valueForKey:KEY_BIRTHDAY];
     
//     if(gIsLoginFacebook)
//     {
//         self.txtUserId.text = [Util valueForKey:@"facebookID"];
//         self.txtEmail.text = [Util valueForKey:@"FBemail"];
//         self.txtPhone.text= [Util valueForKey:KEY_PHONE];
//         self.txtBirthday.text = [Util valueForKey:@"FBbirthdate"];
//     }
     
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
    
    if([[Util valueForKey:KEY_LOGIN_TYPE] isEqualToString:@"1"])
        [self.btnChangePass setEnabled:FALSE];
    else
        [self.btnChangePass setEnabled:TRUE];
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
        SHOW_NETWORK_ERROR;
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
    
    [Util showMessage:@"Are you sure ?" withTitle:@"Logout" cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK" delegate:self andTag:1];
}

- (IBAction)onChangePass:(id)sender {
    
    ChangePassViewController  *vc =[[ChangePassViewController alloc] initWithNibName:@"ChangePassViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex ==1)
    {
        START_LOADING;
        [[APIClient sharedClient] logout:@"" succes:^(AFHTTPRequestOperation *operation, id responseObject) {
            STOP_LOADING;
                    NSLog(@"Response : %@",responseObject);
            if([[responseObject objectForKey:@"success"] boolValue])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_LOGOUT object:nil];

                    
                    [Util setValue:@"0" forKey:KEY_POINT];
                    [Util setValue:@"0" forKey:KEY_TOTAL_MEAL_VIAAPP];
                    [Util setValue:@"" forKey:KEY_USER_ID];
//                    [Util setValue:@"" forKey:KEY_AREA_NAME];
//                    [Util setValue:@"" forKey:KEY_AREAID];
                    [Util setValue:@"" forKey:KEY_SHARELINK];
                    for (UINavigationController  *vc in [self.tabBarController viewControllers]) {
                        
                        [vc popToRootViewControllerAnimated:NO];
                    }
                   
                    [gNavigationViewController popToViewController:[[gNavigationViewController viewControllers]objectAtIndex:2] animated:NO];
                    gIsLogin = FALSE;
                                    }
                else
                    [Util showError:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            STOP_LOADING;
            SHOW_NETWORK_ERROR;
        }];
    }
    
}

- (IBAction)txtEmail:(id)sender {
}
@end
