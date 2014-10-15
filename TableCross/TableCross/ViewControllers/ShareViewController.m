//
//  ShareViewController.m
//  TableCross
//
//  Created by TableCross on 16/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

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
    [self setupTitle:@"シェア" isShowSetting:TRUE andBack:FALSE];
    
    shareAppUrl  = [Util valueForKey:KEY_SHARELINK];

    [self addBackLocationButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShareFacebook:(id)sender {
    
    //[self postToFacebookWithText:shareAppMessage andImage:nil andURL:shareAppUrl];
    [self postToFacebookWithText:[self getShareLinkApp] andImage:nil andURL:nil];
}

- (IBAction)onShareTwitter:(id)sender {
    //[self postToTwitterWithText:shareAppMessage andImage:nil andURL:shareAppUrl];
    [self postToFacebookWithText:[self getShareLinkApp] andImage:nil andURL:nil];
}

- (IBAction)onShareGooglePlus:(id)sender {
    
//    [Util showMessage:@"Coming soon" withTitle:@"Notice"];
    //[self postToLineWithText:shareAppUrl];
    [self postToLineWithText:[self getShareLinkApp]];
}

- (IBAction)onShareSMS:(id)sender {
    //check if the device can send text messages
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kAppNameManager message:msg_not_support_call delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //set receipients
    NSArray *recipients = [NSArray arrayWithObjects: nil];
    
    //set message text
    //NSString * message = [NSString stringWithFormat: @"%@ : %@",shareAppMessage,shareAppUrl];
    NSString * message = [self getShareLinkApp];
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



- (IBAction)onShareEmail:(id)sender {
    
    [self openMailWithBody:[self getShareLinkApp] andSubject:kAppNameManager];
    
//    
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[self getShareLinkApp] applicationActivities:nil];
//    
//    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
//                                   UIActivityTypePrint,
//                                   UIActivityTypeAssignToContact,
//                                   UIActivityTypeSaveToCameraRoll,
//                                   UIActivityType
//                                   UIActivityTypeAddToReadingList,
//                                   UIActivityTypePostToFlickr,
//                                   UIActivityTypePostToVimeo];
//    
//    activityVC.excludedActivityTypes = excludeActivities;
    
//    [self presentViewController:activityVC animated:YES completion:nil];
    
}
@end
