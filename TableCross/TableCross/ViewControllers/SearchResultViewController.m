//
//  SearchResultViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()
{
    NSString *currentTitle;
}


@end

@implementation SearchResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    currentTitle = (self.searchType == SearchByCC)?kSearchSpecificResult:kSearchKeywordResult;
     // NSString *backTitle = (self.searchType == SearchByCC)?@"カテゴリーから探す":@"キーワード検索";
    [self setupTitle:currentTitle isShowSetting:YES andBack:YES ];

}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title =currentTitle;

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(currentTitle.length >6)
    self.navigationItem.title = @"戻る";
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrData count];
//    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"RestaurantCellTableViewCell";
    
    RestaurantCellTableViewCell *cell = (RestaurantCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RestaurantCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell fillData:[self.arrData objectAtIndex:indexPath.row]];
      
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return     [Util getheightRowForRestaurant:[self.arrData objectAtIndex:indexPath.row] isShowDescription:TRUE];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantDetailViewController *detail=[[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
    detail.backTitle = (self.searchType == SearchByCC)?@"カテゴリー結果":@"履歴結果";
   if(self.searchType == SearchByCC)
        self.navigationItem.title = @"カテゴリー結果";
    detail.restaurant = [self.arrData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
