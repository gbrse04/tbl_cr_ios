//
//  RestaurantDetailViewController.h
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "UIKeyboardViewController.h"
#import "PMCalendar.h"
#import "IQActionSheetPickerView.h"
#import "RestaurantObj.h"
#import "ConfirmView.h"
@interface RestaurantDetailViewController : BaseViewController<UIAlertViewDelegate,UIKeyboardViewControllerDelegate,PMCalendarControllerDelegate,IQActionSheetPickerView,ConfirmDelegate>
{
    UIKeyboardViewController *keyBoardController;
}
@property (retain, nonatomic) NSString *backTitle;
@property (retain, nonatomic) RestaurantObj *restaurant;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewMain;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) IBOutlet UITextView *lblDescription;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextField *txtOne;
@property (weak, nonatomic) IBOutlet UITextField *txtTwo;
- (IBAction)onOpenWeb:(id)sender;
- (IBAction)onShowLocation:(id)sender;
- (IBAction)onShowCalendar:(id)sender;

- (IBAction)onPhoneCall:(id)sender;
@end
