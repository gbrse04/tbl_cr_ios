//
//  SearchHistoryViewController.h
//  TableCross
//
//  Created by TableCross on 17/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "RestaurantCellTableViewCell.h"
#import "RestaurantDetailViewController.h"

@interface SearchHistoryViewController : BaseViewController
@property (nonatomic,retain) NSMutableArray *arrData;

@property (weak, nonatomic) IBOutlet UITableView *tblData;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchBar;


@end
