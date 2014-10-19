//
//  SearchLocationViewController.h
//  TableCross
//
//  Created by TableCross on 16/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "RestaurantCellTableViewCell.h"
#import "RestaurantDetailViewController.h"

@interface SearchLocationViewController : BaseViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblResult;
@property (weak, nonatomic) IBOutlet UILabel *lblGuide;
@property (retain,nonatomic) NSMutableArray *arrData;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)segmentChange:(id)sender;

@end
