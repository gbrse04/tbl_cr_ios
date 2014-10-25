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
    
    shareAppUrl = [Util valueForKey:KEY_SHARELINK];
    [self bindData];
    
}
- (void)bindData {
    if(self.restaurant)
    {
     
        [self.imgRestaurant setImageWithURL:[NSURL URLWithString:self.restaurant.imageUrl] placeholderImage:[UIImage imageNamed:@"img_restaurant"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if(image)
                [self.imgRestaurant setImage:image];
        }];
        
        if([self.restaurant.orderDate isEqualToString:@""])
        {
            [self.imgTime setHidden:YES];
        }
        
        self.lblDateTime.text = self.restaurant.orderDate;
        self.lblAddress.text = self.restaurant.name;
        self.lblName.text =self.restaurant.address;
        self.lblNumberMeal.text =self.restaurant.numberOrder;
        
        self.lblName.numberOfLines= 0 ;
        [self.lblName sizeToFit];
        
        self.lblAddress.numberOfLines = 0;
        [self.lblAddress sizeToFit];
        
        CGFloat heightName = [self.restaurant.name heightOfTextViewToFitWithFont:[UIFont boldSystemFontOfSize:17.0] andWidth:304];
        
        CGFloat heightAddress = [self.restaurant.address heightOfTextViewToFitWithFont:[UIFont systemFontOfSize:17.0] andWidth:304];
        
        
        [Util moveDow:self.lblName offset:heightName];
        
        CGRect currenTopFrame = self.viewTop.frame;
        
        currenTopFrame.size.height = heightAddress + heightName ;
        
        self.viewTop.frame = currenTopFrame;
        
        [Util moveDow:self.viewDateTime offset:self.viewTop.frame.size.height];
        
        
        self.lblShortDescription.text = self.restaurant.shortDescription;
        self.lblShortDescription.numberOfLines = 0 ;
        [self.lblShortDescription sizeToFit];
        
        self.lblDescription.text = self.restaurant.descriptionRestaurant;
        self.lblDescription.numberOfLines = 0 ;
        [self.lblDescription sizeToFit];
        CGFloat shortDescriptionHeight = [self.restaurant.shortDescription heightOfTextViewToFitWithFont:[UIFont boldSystemFontOfSize:16.0] andWidth:300];
        CGFloat descriptionHeight = [self.restaurant.descriptionRestaurant heightOfTextViewToFitWithFont:[UIFont systemFontOfSize:16.0] andWidth:300];
        
        
        [Util moveDow:self.lblDescription offset:shortDescriptionHeight+10];
        
        
        CGRect currenFrame = self.viewBottom.frame;
        
        
        
        currenFrame.size.height  = shortDescriptionHeight + descriptionHeight + 190;
        
        [self.viewBottom setFrame:currenFrame];
       
        
        [Util moveDow:self.viewButton offset:(self.viewTop.frame.size.height + self.viewDateTime.frame.size.height)];
        
        [Util moveDow:self.viewBottom offset:(self.viewTop.frame.size.height + self.viewDateTime.frame.size.height + self.viewButton.frame.size.height)];
        
        [self.scrollViewMain setContentSize:CGSizeMake(self.scrollViewMain.frame.size.width, self.viewTop.frame.size.height + self.viewDateTime.frame.size.height + self.viewButton.frame.size.height + self.viewBottom.frame.size.height)];
        
    }
    
    else {
              START_LOADING;
        
        [[APIClient sharedClient] getRestaurantInfo:self.restaurantId
    withsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            
            NSDictionary *resDict = [responseObject objectForKey:@"restaurant"];
            self.restaurant =[[RestaurantObj alloc] initWithDict:resDict];
            
            if([self.restaurant.restaurantId isEqualToString:@""])
            {
                [Util showError:responseObject];
                [self.navigationController popViewControllerAnimated:NO];
            }

            [self bindData];
        }
        else
        {
            [Util showError:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
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
    
    [self addShareButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onOpenWeb:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.restaurant.orderWebUrl]];

}

- (IBAction)onShowLocation:(id)sender {
    
    MapViewController *vc= [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    vc.restaurant= self.restaurant;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
   
    
}

- (IBAction)onShowCalendar:(id)sender {
    
    [self onChangeDateTimeAction];
}

- (IBAction)onViewMoreImage:(id)sender {
  
        
        START_LOADING;
        [[APIClient sharedClient] getImages:self.restaurant.restaurantId withsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            STOP_LOADING;
            if([[responseObject objectForKey:@"success"] boolValue])
            {
              NSMutableArray *arrData = [responseObject objectForKey:@"items"];
                if(!arrData)
                {
                    [Util showError:responseObject];
                    //                [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    GalleryListViewController *vc2 =[[GalleryListViewController alloc] initWithNibName:@"GalleryListViewController" bundle:nil];
                    vc2.arrData = arrData;
                    self.navigationItem.title = @"お店の情報";
                    //vc2.restautId= self.restaurant.restaurantId;
                    
                    [self.navigationController pushViewController:vc2 animated:YES];
                }
            }
            else
            {
                [Util showError:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            STOP_LOADING;
            SHOW_NETWORK_ERROR;
        }];
    
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
   // [self.txtTwo setText:[Util stringFromDate:date withFormat:@"yyyy/MM/dd"]];
    
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
      
        START_LOADING;
        [[APIClient sharedClient] sendOrder:self.restaurant.restaurantId andNumber:[NSString stringWithFormat:@"%d",value]  withsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
            STOP_LOADING;

            if([[responseObject objectForKey:@"success"] boolValue])
            {
             
            NSURL *phoneNumber = [[NSURL alloc] initWithString: [NSString stringWithFormat:@"tel:%@",self.restaurant.phone]];
            [[UIApplication sharedApplication] openURL: phoneNumber];
            }
            else
            {
                [Util showMessage:[responseObject objectForKey:@"errorMess"] withTitle:title_error];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            STOP_LOADING;
            SHOW_NETWORK_ERROR;
        }];
        
    } else {
        
        [Util showMessage:msg_not_support_call withTitle:title_error];
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
    NSString *msg = [self getShareLinkRestaurant:self.restaurant];
        NSString *url = self.restaurant.shareLink;
    switch (indexPath.row) {
        case 0:
            [self postToFacebookWithText:msg andImage:nil andURL:url];
            break;
        case 1:
            [self postToTwitterWithText:[self getShareLinkRestaurantForTwitter:self.restaurant] andImage:nil andURL:url];
            break;
        case 2:
            [self postToLineWithText:msg];
            break;
        case 3:
            [self openSMS:msg];
            break;
        case 4:
           [self openMailWithBody:msg andSubject:kAppNameManager];
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
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title_error message:msg_not_support_call delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //set receipients
    NSArray *recipients = [NSArray arrayWithObjects: nil];
    
    //set message text
    NSString * message = content;
    
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
