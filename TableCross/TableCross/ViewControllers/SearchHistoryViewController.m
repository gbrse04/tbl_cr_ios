//
//  SearchHistoryViewController.m
//  TableCross
//
//  Created by TableCross on 17/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SearchHistoryViewController.h"

@interface SearchHistoryViewController ()


@end

@implementation SearchHistoryViewController

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
    
    [self setupTitle:@"履歴" isShowSetting:YES andBack:YES];
    [self.txtSearchBar setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = @"履歴から探す";
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationItem.title = @"特集結果";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return [self.arrData count];
  
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
    
    [cell fillData:[self.arrData  objectAtIndex:indexPath.row] isShowContent:FALSE];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat  heightDescription = [((RestaurantObj*)[self.arrData objectAtIndex:indexPath.row]).shortDescription heightOfTextViewToFitWithFont:[UIFont systemFontOfSize:16.0] andWidth:300];
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantDetailViewController *detail=[[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
    
    
    detail.restaurant=  [self.arrData objectAtIndex:indexPath.row];
    detail.backTitle = @"特集結果";
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark  - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if(![self.txtSearchBar.text isEqualToString:@""])
    {
        [self makeSearch:self.txtSearchBar.text];
    }
    return  YES;
}


-(void)makeSearch:(NSString*)keyword {
    
    
    START_LOADING;
    [[APIClient sharedClient] searchByKeyWord:keyword type:@"0" latitude:@"" longitude:@"" distance:@"" total:@"-1"  category:@""  withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response : %@",responseObject);
        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue])
            
        {
            self.arrData = [APIClient parserListRestaunt:responseObject];
            if([self.arrData count]== 0)
            {
                            [Util showMessage:msg_no_result withTitle:kAppNameManager];
                return ;
            }
            
            [self.tblData reloadData];
        }
        else
            [Util showError:responseObject];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    
}




@end
