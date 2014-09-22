//
//  RestaurantCellTableViewCell.h
//  TableCross
//
//  Created by TableCross on 15/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@end
