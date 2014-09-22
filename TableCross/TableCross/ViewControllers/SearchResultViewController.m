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
    [self setupTitle:@"履歴" isShowSetting:YES andBack:YES andBackTitle:self.backTitle];
}

//-(void)viewWillAppear:(BOOL)animated {
//    
//    [self viewWillAppear:animated];
//    // Set title
//    self.navigationItem.title=@"履歴";
//}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"履歴結果" ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.arrData count];
    return 10;
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
    
    //    cell.lblCompany.text=item.companyName;
    //    cell.lblProgress.text=item.status;
    //    cell.lblTime.text=[LMDateTimeUtility reformat:item.startDate inputFormat:@"yyyy-MM-dd HH:mm" withFormat:@"hh:mm aa"];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantDetailViewController *detail=[[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
    detail.backTitle = @"履歴結果";
    [self.navigationController pushViewController:detail animated:YES];
}

@end
