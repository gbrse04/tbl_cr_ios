//
//  BaseViewController.h
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "RestaurantObj.h"
#import "Line.h"
#import "LKLineActivity.h"


@interface BaseViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>

@property (assign,nonatomic) BOOL isShowRightButton;


- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)showSetting andBack:(BOOL)isShowBack;
- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)showSetting andBack:(BOOL)isShowBack andBackTitle:(NSString*)title;

- (void)addBackLocationButton;
- (void)backToLogin;

- (void)openMailWithBody:(NSString*)body andSubject:(NSString*)subject;

- (void)openSMSWithContent:(NSString*)body;
- (void)postToTwitterWithText:(NSString*)text andImage:(UIImage*)img andURL:(NSString*)url;
- (void)postToFacebookWithText:(NSString*)text andImage:(UIImage*)img andURL:(NSString*)url;
- (void)postToLineWithText:(NSString*)text;

-(NSString*)getShareLinkRestaurant:(RestaurantObj*)res;
-(NSString*)getShareLinkRestaurantForTwitter:(RestaurantObj*)res;
-(NSString*)getShareLinkRestaurantForLine:(RestaurantObj*)res;
-(NSString*)getShareLinkApp;


@end
