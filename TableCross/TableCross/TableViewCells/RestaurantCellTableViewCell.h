//
//  RestaurantCellTableViewCell.h
//  TableCross
//
//  Created by TableCross on 15/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantObj.h"

@interface RestaurantCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imgClock;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property (weak, nonatomic) IBOutlet UILabel *lblNumberMeal;

@property (weak, nonatomic) IBOutlet UIImageView *imgNumberMeal;

@property (nonatomic) CGFloat  rowHeight;

-(void)fillData:(RestaurantObj*)obj;
-(void)fillData:(RestaurantObj*)obj isShowContent:(BOOL)showContent;
-(CGFloat)getHeightForRow;
@end
