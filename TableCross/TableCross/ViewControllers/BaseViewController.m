//
//  BaseViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "SettingViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
{
    
    NSString *backTitle;
}

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
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;

    if(IS_IOS7)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.isShowRightButton)
    {
        
        if(gIsLogin)
        {
            
            UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *settingImage = [UIImage imageNamed:@"btn_setting.png"]  ;
            
            [settingBtn setBackgroundImage:settingImage forState:UIControlStateNormal];
            [settingBtn addTarget:self action:@selector(gotoSetting) forControlEvents:UIControlEventTouchUpInside];
            settingBtn.frame = CGRectMake(0, 0, 20, 20);
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:settingBtn] ;
            self.navigationItem.rightBarButtonItem = backButton;
            
        } else {
            
            UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [loginBtn setTitle:@"ログイン" forState:UIControlStateNormal];
            [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
            [loginBtn addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
            CGSize expectedLabelSize = [@"ログイン" sizeWithFont:[UIFont systemFontOfSize:14.0]];
            loginBtn.frame =CGRectMake(0, 0, expectedLabelSize.width+5, expectedLabelSize.height);
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:loginBtn] ;
            self.navigationItem.rightBarButtonItem = backButton;
            
        }
        
    }
}
-(void)viewDidAppear:(BOOL)animated {
    
    
    [super viewDidAppear:YES];
    
    if(IS_IOS7)
    {
        [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
         setTitleTextAttributes:[NSDictionary
                                 dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]
         forState:UIControlStateNormal];
        [[self.navigationController.navigationBar.subviews lastObject] setTintColor:[UIColor whiteColor]];
    }
//    if(backTitle)
//       [self.navigationController.navigationBar.backItem setTitle:backTitle];

    
   
    
}

- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)isShowSetting andBack:(BOOL)isShowBack {
    
    self.isShowRightButton = isShowSetting;
    
    self.navigationItem.title = title;
   self.navigationItem.hidesBackButton = NO;
   if(IS_IOS7)
   {
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]
     forState:UIControlStateNormal];
        [[self.navigationController.navigationBar.subviews lastObject] setTintColor:[UIColor whiteColor]];
   }
    
 
}

- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)showSetting andBack:(BOOL)isShowBack andBackTitle:(NSString*)backStr{

    backTitle =  backStr;
    [self setupTitle:title isShowSetting:showSetting andBack:isShowBack];
    [self.navigationController.navigationBar.backItem setTitle:backTitle];

    if(IS_IOS7)
    {
        [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
         setTitleTextAttributes:[NSDictionary
                                 dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]
         forState:UIControlStateNormal];
        [[self.navigationController.navigationBar.subviews lastObject] setTintColor:[UIColor whiteColor]];
    }
}

- (void)addBackLocationButton {
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setTitle:[Util valueForKey:KEY_AREA_NAME] forState:UIControlStateNormal];
    
    [settingBtn addTarget:self action:@selector(gotoSelectRegion) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    CGSize expectedLabelSize = [[Util valueForKey:KEY_AREA_NAME] sizeWithFont:[UIFont systemFontOfSize:14.0]];
    settingBtn.frame =CGRectMake(0, 0, expectedLabelSize.width+5, expectedLabelSize.height);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:settingBtn] ;
    
      self.navigationItem.leftBarButtonItem = backButton;

    
    
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backToLogin {
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [gNavigationViewController popToViewController:[gNavigationViewController.viewControllers objectAtIndex:2] animated:YES];
    });
    
    
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoSelectRegion
{
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [gNavigationViewController popToViewController:[gNavigationViewController.viewControllers objectAtIndex:1] animated:TRUE];
    });

}
-(void)gotoSetting {
    
    if(gIsLogin)
    {
        
        SettingViewController *vc= [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
        
        [Util showMessage:kMessageLoginRequired withTitle:kAppNameManager cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK" delegate:self andTag:1];
}
-(void)gotoLogin {
   
    [self backToLogin];
    
   }

#pragma mark - Share functions
#pragma mark - Share SMS

- (void)openSMSWithContent:(NSString*)body {
    //check if the device can send text messages
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title_error message:msg_not_support_call delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    [messageController setBody:body];
    
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

#pragma mark - share Mail

- (void)openMailWithBody:(NSString*)body andSubject:(NSString*)subject
{
    
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *messageBody = body;
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:subject];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Present mail view controller on screen
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            mc.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    
    else
        
    {
        
        NSString *recipients = @"mailto:";
        NSString *body = @"";
        
        NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString* msg = nil;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            msg = @"Mail saved: you saved the email message in the drafts folder.";
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            msg = @"Mail send: the email message is queued in the outbox. It is ready to send.";
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            msg = @"Mail failed: the email message was not saved or queued, possibly due to an error.";
            break;
        default:
            NSLog(@"Mail not sent.");
            msg  = @"Mail coundn't be sent by unknown error";
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - share TW

- (void)postToTwitterWithText:(NSString*)text andImage:(UIImage*)img andURL:(NSString*)url
{
    
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    if(img == nil) img = [UIImage imageNamed:@"no_img_big.png"];
    [tweetSheet addImage:img];
    [tweetSheet addURL:[NSURL URLWithString:url]];
    [tweetSheet setInitialText:text];
    
    [self presentViewController:tweetSheet animated:YES completion:nil];
}

#pragma mark - share FB

- (void)postToFacebookWithText:(NSString*)text andImage:(UIImage*)img andURL:(NSString*)url
{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if(img == nil) img = [UIImage imageNamed:@"no_img_big.png"];
    [controller addImage:img];
    [controller addURL:[NSURL URLWithString:url]];
    [controller setInitialText:text];
    [self presentViewController:controller animated:YES completion:Nil];
}

#pragma mark - SHARE LINE
- (void)postToLineWithText:(NSString*)text {
    
    
//    NSString* url = [NSString stringWithFormat: @"http://line.me/R/msg/text/?%@", text];
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    if(![self checkIfLineInstalled])
            [Line openLineInAppStore];
    else
        [Line shareText:text];
}


- (BOOL)checkIfLineInstalled {
    BOOL isInstalled = [Line isLineInstalled];
    
    if (!isInstalled) {
        [[[UIAlertView alloc] initWithTitle:@"Line is not installed." message:@"Please download Line from App Store, and try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    return isInstalled;
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex==1)
    {
        [self backToLogin];
    }
}

#pragma mark - Util functions

-(NSString*)getShareLinkRestaurant:(RestaurantObj*)res {
    return [NSString stringWithFormat:@"店舗名\n%@\n電話番号\n%@\n住所\n%@\nURL\n%@(現在はお店のホームページURLです。\nそのうちWEB版のテーブルクロスのURLのお店詳細を載せる)\n予約するだけで途上国の給食支援が出来る無料チャリティアプリ テーブルクロス\nはこちらからダウンロード\n%@\n(ユーザー紐付け入りのダウンロードURL)",res.name,res.phone,res.address,res.orderWebUrl,[Util objectForKey:KEY_SHARELINK]];
}

-(NSString*)getShareLinkRestaurantForTwitter:(RestaurantObj*)res {
    return [NSString stringWithFormat:@"%@\n(ユーザー紐付け入りのダウンロードURL)\n店舗名\n%@\n電話番号\n%@\n住所\n%@\nURL\n%@(現在はお店のホームページURLです。\n予約するだけで途上国の給食支援が出来る無料チャリティアプリ テーブルクロス\nはこちらからダウンロード",[Util objectForKey:KEY_SHARELINK],res.name,res.phone,res.address,res.orderWebUrl];
}

-(NSString*)getShareLinkRestaurantForLine:(RestaurantObj*)res {
     return [NSString stringWithFormat:@"店舗名%@ 電話番号%@住所\n%@\nURL\n%@(現在はお店のホームページURLです。そのうちWEB版のテーブルクロスのURLのお店詳細を載せる) 予約するだけで途上国の給食支援が出来る無料チャリティアプリ テーブルクロス\nはこちらからダウンロード%@(ユーザー紐付け入りのダウンロードURL)",res.name,res.phone,res.address,res.orderWebUrl,[Util objectForKey:KEY_SHARELINK]];
}

-(NSString*)getShareLinkApp {
    return [NSString stringWithFormat:@"%@\n(ユーザー紐付け入りのダウンロードURL)\n日本中の飲食店が世界の飢餓を救う予約アプリ登場！\n予約するだけで途上国の給食支援が出来る無料チャリティアプリ テーブルクロス\n はこちらからダウンロード",[Util objectForKey:KEY_SHARELINK]];
}

@end
