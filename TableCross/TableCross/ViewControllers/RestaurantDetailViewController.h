//
//  RestaurantDetailViewController.h
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "UIKeyboardViewController.h"
#import "PMCalendar.h"
#import "IQActionSheetPickerView.h"
#import "RestaurantObj.h"
#import "ConfirmView.h"
#import "UIPopoverListView.h"
#import "NSString+TextSize.h"


@interface RestaurantDetailViewController : BaseViewController<UIAlertViewDelegate,UIKeyboardViewControllerDelegate,PMCalendarControllerDelegate,IQActionSheetPickerView,ConfirmDelegate,UIPopoverListViewDelegate,UIPopoverListViewDataSource>
{
    UIKeyboardViewController *keyBoardController;
}

@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@property (weak, nonatomic) IBOutlet UIImageView *imgNumberOrder;

@property (weak, nonatomic) IBOutlet UIImageView *imgTime;
@property (retain, nonatomic) NSString *backTitle;
@property (retain, nonatomic) RestaurantObj *restaurant;
@property (retain, nonatomic) NSString *restaurantId;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewMain;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberMeal;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;


@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextField *txtOne;
@property (weak, nonatomic) IBOutlet UITextField *txtTwo;
- (IBAction)onOpenWeb:(id)sender;
- (IBAction)onShowLocation:(id)sender;
- (IBAction)onShowCalendar:(id)sender;

- (IBAction)onPhoneCall:(id)sender;
@end
