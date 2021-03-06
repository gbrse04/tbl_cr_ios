//
//  SettingViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()


{
    NSDate *currentBirthdayDate;

    NSDateFormatter *timeFormatter;
    NSString *dateStr;

}
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
     timeFormatter = [[NSDateFormatter alloc] init];

    
     [timeFormatter setDateFormat:@"yyyy/MM/dd"];
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtBirthday setInputView:datePicker];
    
    [self.scrollMain setContentSize:CGSizeMake(self.scrollMain.frame.size.width, 440)];
    
}
-(void)updateTextField:(UIDatePicker *)dtPicker{

    currentBirthdayDate = dtPicker.date;
    self.txtBirthday.text = [Util stringFromDate:currentBirthdayDate withFormat:@"yyyy年MM月dd日"];
    
}
 -(void)initDefaulSetting {
     
     self.txtUserId.text = [NSString stringWithFormat:@"%@",[Util valueForKey:KEY_NAME_KANJI]];
     self.txtEmail.text = [Util valueForKey:KEY_EMAIL];
     self.txtPhone.text= [Util valueForKey:KEY_PHONE];

     if(![[Util valueForKey:KEY_BIRTHDAY] isEqualToString:@""])
     {
         currentBirthdayDate = [Util dateFromString:[Util valueForKey:KEY_BIRTHDAY] withFormat:@"yyyy/MM/dd"];
         self.txtBirthday.text = [Util stringFromDate:currentBirthdayDate withFormat:@"yyyy年MM月dd日"];
     }

     [self.btnNotifi1 setSelected:[Util getBoolValueForKey:KEY_NOTIFY_ORDER defaultValue:TRUE]];
     [self.btnNotify2 setSelected:[Util getBoolValueForKey:KEY_NOTIFY_BEFORE_DATE defaultValue:TRUE]];
     [self.btnNoitfy3 setSelected:[Util getBoolValueForKey:KEY_NOTIFY_RESTAURANT defaultValue:TRUE]];
     
//     if(gIsLoginFacebook)
//         self.txtUserId.text = [NSString stringWithFormat:@"%@ %@",[Util valueForKey:@"FBfirst_name"] ,[Util valueForKey:@"FBlast_name"]];
     
     
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
    
    [self initDefaulSetting];
    
    if([[Util valueForKey:KEY_LOGIN_TYPE] isEqualToString:@"1"])
        [self.btnChangePass setEnabled:FALSE];
    else
        [self.btnChangePass setEnabled:TRUE];
 }


#pragma mark - IBOutlet Actions

- (void)updateSuccess {
    
    [Util setValue:self.txtUserId.text forKey:KEY_NAME_KANJI];
    [Util setValue:self.txtEmail.text forKey:KEY_EMAIL];
    [Util setValue:self.txtPhone.text forKey:KEY_PHONE];
    
    [Util setBoolValue:self.btnNotifi1.isSelected forKey:KEY_NOTIFY_ORDER];
    [Util setBoolValue:self.btnNotify2.isSelected forKey:KEY_NOTIFY_BEFORE_DATE];
    [Util setBoolValue:self.btnNoitfy3.isSelected forKey:KEY_NOTIFY_RESTAURANT];
    
    [Util setValue:[Util stringFromDate:currentBirthdayDate withFormat:@"yyyy/MM/dd"] forKey:KEY_BIRTHDAY];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSave:(id)sender {
    
    NSString *birthday =  [Util stringFromDate:currentBirthdayDate withFormat:@"yyyy/MM/dd"];
    if(![self.txtBirthday.text isEqualToString:@""])
        
    START_LOADING;
    [[APIClient sharedClient] updateUserEmail:self.txtEmail.text kanjiName:self.txtUserId.text phone:self.txtPhone.text birthday:birthday notifyOrder:(self.btnNotifi1.isSelected?@"1":@"0") notifyResrautrant:(self.btnNoitfy3.isSelected?@"1":@"0") notifyBeforeDate:(self.btnNotify2.isSelected?@"1":@"0") sucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue]) {
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
//    switch (btn.tag) {
//        case 4:
//            [Util setBoolValue:btn.isSelected forKey:KEY_NOTIF_SETTING_1];
//            break;
//        case 5:
//            [Util setBoolValue:btn.isSelected forKey:KEY_NOTIF_SETTING_2];
//            break;
//        case 6:
//            [Util setBoolValue:btn.isSelected forKey:KEY_NOTIF_SETTING_3];
//            break;
//        default:
//            break;
//    }
}

- (IBAction)onSaveBottom:(id)sender {
    
    [Util showMessage:msg_confirm_logout withTitle:title_logout cancelButtonTitle:btn_cancel otherButtonTitles:@"OK" delegate:self andTag:1];
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
