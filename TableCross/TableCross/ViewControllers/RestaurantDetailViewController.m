//
//  RestaurantDetailViewController.m
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "Util.h"
@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController

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
//    [self setupTitle:@"お店の情報" isShowSetting:YES andBack:YES];
    
    [self.scrollViewMain setContentSize:CGSizeMake(320, 460)];
    
    [self setupTitle:@"お店の情報" isShowSetting:YES andBack:YES];
    [self addShareButton];
}
-(void)addShareButton
{
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setTitle:@"シェア" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [settingBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(onClickShare) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.frame = CGRectMake(0, 0, 55, 30);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:settingBtn] ;
    self.navigationItem.rightBarButtonItem = backButton;
}
-(void)onClickShare
{
    
    [Util showMessage:@"Coming Soon" withTitle:@"Share this restaurant"];
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

- (IBAction)onOpenWeb:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.google.com"]];

}

- (IBAction)onShowLocation:(id)sender {
    
    [Util showMessage:@"Coming soon" withTitle:@"Notice"];
}

- (IBAction)onShowCalendar:(id)sender {
    
    [self onChangeDateTimeAction];
}

- (IBAction)onPhoneCall:(id)sender {
    
//    [Util showMessage:@"発信してもいいですか？" withTitle:@"Are you sure ?" cancelButtonTitle:@"NO" otherButtonTitles:@"YES" delegate:self andTag:1];
    
    ConfirmView *confirm  = (ConfirmView*)[[[NSBundle mainBundle] loadNibNamed:@"ConfirmView" owner:nil options:nil] objectAtIndex:0];
    confirm.confirmDelegate = self;
    confirm.btnBackground.frame =  self.view.window.bounds;
    [confirm setup];
    [self.view.window addSubview:confirm];
    
}

-(void)onChangeDateTimeAction
{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Select Date" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:2];

    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker showInView:self.view];
}

#pragma mark - IQActionSheetPickerViewDelegate

-(void)actionSheetPickerView:(IQActionSheetPickerView *)tpickerView didSelectTitles:(NSArray *)titles
{
    
    NSDate* date = tpickerView.date;
    [self.txtTwo setText:[Util stringFromDate:date withFormat:@"yyyy/MM/dd"]];
    
}
#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex ==1)
    {
        NSURL *phoneNumber = [[NSURL alloc] initWithString: @"tel:123456789"];
        [[UIApplication sharedApplication] openURL: phoneNumber];
    }
}

#pragma mark - Confirm AlertView Delegate


- (void)onCall:(NSInteger)value {
   if(IS_IPHONE) {
       NSURL *phoneNumber = [[NSURL alloc] initWithString: @"tel:123456789"];
       [[UIApplication sharedApplication] openURL: phoneNumber];
  } else {
     [Util showMessage:@"Your device not support this feature" withTitle:@"Error"];
  }
      
    
}


@end
