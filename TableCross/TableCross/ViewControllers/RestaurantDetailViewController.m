//
//  RestaurantDetailViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "Util.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"


@interface RestaurantDetailViewController ()
{
    UIPopoverListView *poplistview;

}
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
    shareAppUrl = [Util valueForKey:KEY_SHARELINK];
    [self bindData];
    
}
- (void)bindData {
    if(self.restaurant)
    {
        if([self.restaurant.imageUrl rangeOfString:@"http:"].location == NSNotFound)
            self.restaurant.imageUrl = @"http://www.sott.net/image/s5/109922/medium/mcdonalds.jpg";
        
        [self.imgRestaurant setImageWithURL:[NSURL URLWithString:self.restaurant.imageUrl] placeholderImage:[UIImage imageNamed:@"img_restaurant"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if(image)
                [self.imgRestaurant setImage:image];
        }];
        
        self.lblAddress.text = self.restaurant.name;
        self.lblName.text =self.restaurant.address;
       
    }
    
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
    
    [self showSharePopup];
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
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.restaurant.website]];

}

- (IBAction)onShowLocation:(id)sender {
    
    //[Util showMessage:@"Coming soon" withTitle:@"Notice"];
    [self showPointOnMap:self.restaurant];
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


#pragma mark - Show Share Popup

-(void)showSharePopup {
    
    if(!poplistview)
    {
        CGFloat xWidth = self.view.bounds.size.width - 20.0f;
        CGFloat yHeight = 233;
        CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
        
        poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
        poplistview.delegate = self;
        [poplistview setTitleBackground:kColorOrange];
        poplistview.datasource = self;
        poplistview.listView.scrollEnabled = NO;
        
        [poplistview setTitle:@"Share with"];
    }
    
    [poplistview show];
    
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
        NSURL *phoneNumber = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel:%@",self.restaurant.phone]];
        [[UIApplication sharedApplication] openURL: phoneNumber];
    }
}

#pragma mark - Confirm AlertView Delegate


- (void)onCall:(NSInteger)value {
   if(IS_IPHONE) {
       NSURL *phoneNumber = [[NSURL alloc] initWithString: [NSString stringWithFormat:@"tel:%@",self.restaurant.phone]];
       [[UIApplication sharedApplication] openURL: phoneNumber];
  } else {
     [Util showMessage:@"Your device not support this feature" withTitle:@"Error"];
  }
}

-(void)showPointOnMap:(RestaurantObj*)resObj
{
    NSString* versionNum = [[UIDevice currentDevice] systemVersion];
    NSString *nativeMapScheme = @"maps.apple.com";
    if ([versionNum compare:@"6.0" options:NSNumericSearch] == NSOrderedAscending)
        nativeMapScheme = @"maps.google.com";
    double userLatitude;
    double userLongitude;
    if (gIsEnableLocation)
    {
        userLatitude = gCurrentLatitude;
        userLongitude = gCurrentLongitude;
    }
    
    NSString* url = [NSString stringWithFormat: @"http://%@/maps?q=%f,%f", nativeMapScheme, [resObj.latitude floatValue], [resObj.longitude floatValue]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:identifier];
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            cell.textLabel.text=@"Facebook";
            break;

        case 1:
            cell.textLabel.text=@"Twitter";
            break;

        case 2:
            cell.textLabel.text=@"LINE";
            break;

        case 3:
            cell.textLabel.text=@"SMS";
            break;
        case 4:
            cell.textLabel.text=@"Email";
            break;


        default:
            break;
    }
   
    //    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSString *msg = @"Please go and enjoy ";
        NSString *url = self.restaurant.shareLink;
    switch (indexPath.row) {
        case 0:
            [self postToFacebookWithText:msg andImage:nil andURL:url];
            break;
        case 1:
            [self postToTwitterWithText:msg andImage:nil andURL:url];
            break;
        case 2:
            [self postToLineWithText:shareAppUrl];
            break;
        case 3:
            [self openSMS:[NSString stringWithFormat:@"%@ :%@",msg,url]];
            break;
        case 4:
           [self openMailWithBody:[NSString stringWithFormat:@"%@ :%@",msg,url] andSubject:@"Share Restaurant"];
            break;
        default:
            break;
    }
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)openSMS:(NSString*)content {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device cannot send text messages" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //set receipients
    NSArray *recipients = [NSArray arrayWithObjects: nil];
    
    //set message text
    NSString * message = [NSString stringWithFormat: @"%@ : %@",shareAppMessage,shareAppUrl];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipients];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result {
    //[self.navigationController popToRootViewControllerAnimated:YES];
    switch (result) {
        case MessageComposeResultCancelled: break;
            
        case MessageComposeResultFailed:
            
            break;
            
        case MessageComposeResultSent: break;
            
        default: break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
