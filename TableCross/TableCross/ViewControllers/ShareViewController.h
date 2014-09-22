//
//  ShareViewController.h
//  TableCross
//
//  Created by TableCross on 16/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareViewController : BaseViewController<MFMessageComposeViewControllerDelegate>
- (IBAction)onShareFacebook:(id)sender;
- (IBAction)onShareTwitter:(id)sender;
- (IBAction)onShareGooglePlus:(id)sender;
- (IBAction)onShareSMS:(id)sender;
- (IBAction)onShareEmail:(id)sender;

@end
