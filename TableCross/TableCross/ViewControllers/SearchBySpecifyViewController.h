//
//  SearchBySpecifyViewController.h
//  TableCross
//
//  Created by DangLV on 10/1/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "RestaurantCellTableViewCell.h"
#import "RestaurantDetailViewController.h"
#import "NSString+TextSize.h"
#import "SearchResultViewController.h"

@interface SearchBySpecifyViewController : BaseViewController

@property (retain,nonatomic) NSMutableArray *arrData;

@property (weak, nonatomic) IBOutlet UITableView *tblData;
@property (retain, nonatomic)  NSString *categoryId;
@property (retain, nonatomic)  NSDictionary *currentDict;

@end
