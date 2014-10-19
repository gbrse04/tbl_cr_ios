//
//  SearchResultViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

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
    NSString *title = (self.searchType == SearchByCC)?@"カテゴリー結果":@"条件結果";
    
    [self setupTitle:title isShowSetting:YES andBack:YES andBackTitle:self.backTitle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.searchType == SearchByCC)
        self.navigationItem.title = @"特集結果" ;
    else
        self.navigationItem.title = @"条件結果" ;
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
    
    CGFloat  heightDescription = [((RestaurantObj*)[self.arrData objectAtIndex:indexPath.row]).shortDescription heightOfTextViewToFitWithFont:[UIFont systemFontOfSize:16.0] andWidth:300];
    return heightDescription + 124;

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
