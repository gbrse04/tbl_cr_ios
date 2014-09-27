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
    if(backTitle)
    [self.navigationController.navigationBar.backItem setTitle:backTitle];

}

- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)isShowSetting andBack:(BOOL)isShowBack {
    
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
    
  if(isShowSetting)
    {
        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *settingImage = [UIImage imageNamed:@"btn_setting.png"]  ;
        
        [settingBtn setBackgroundImage:settingImage forState:UIControlStateNormal];
        [settingBtn addTarget:self action:@selector(gotoSetting) forControlEvents:UIControlEventTouchUpInside];
        settingBtn.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:settingBtn] ;
        self.navigationItem.rightBarButtonItem = backButton;
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
    CGSize expectedLabelSize = [[Util valueForKey:KEY_AREA_NAME] sizeWithFont:[UIFont systemFontOfSize:16.0]];
    settingBtn.frame =CGRectMake(0, 0, expectedLabelSize.width+10, expectedLabelSize.height);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:settingBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoSelectRegion
{
    
    gIsLogin = FALSE;
    [Util setValue:@"" forKey:KEY_USER_ID];
    [gNavigationViewController popToViewController:[gNavigationViewController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)gotoSetting {
    
    if(gIsLogin)
    {
        
        SettingViewController *vc= [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark - Share functions
#pragma mark - Share SMS

- (void)openSMSWithContent:(NSString*)body {
    //check if the device can send text messages
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
    [messageController setRecipients:message];
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
    
    
    NSString* url = [NSString stringWithFormat: @"http://line.me/R/msg/text/?%@", text];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}

@end
