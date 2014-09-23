//
//  SearchByConditionViewController.h
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "UnderLineLabel.h"
#import "RecentSearchCell.h"

@interface SearchByConditionViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

@property (weak, nonatomic) IBOutlet UITableView *tblRecentSearch;

@end
