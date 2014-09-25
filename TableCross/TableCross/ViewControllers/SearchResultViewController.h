//
//  SearchResultViewController.h
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "RestaurantCellTableViewCell.h"
#import "RestaurantDetailViewController.h"
#import "NSString+TextSize.h"

@interface SearchResultViewController : BaseViewController
@property (nonatomic,retain) NSString *backTitle;
@property (nonatomic,retain) NSMutableArray *arrData;
@property (weak, nonatomic) IBOutlet UITableView *tblResult;
@property (assign,nonatomic) SearchType searchType;



@end
