//
//  SearchByConditionViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SearchByConditionViewController.h"
#import "SearchResultViewController.h"

@interface SearchByConditionViewController ()
{
    NSMutableArray *arrRecent;
}

@end

@implementation SearchByConditionViewController

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
    
    [self setupTitle:@"条件から探す" isShowSetting:YES andBack:YES];
    [self.txtSearch setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    arrRecent = [[NSMutableArray alloc] initWithObjects:@"Pizza",@"Hotdog",@"KFC",@"Humberger", nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"条件から探す";
    [self.navigationController.navigationBar.backItem setTitle:@"検索"];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"履歴検索";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if(![textField.text isEqualToString:@""])
    {
        
        [self makeSearch:textField.text];
    }

    return  YES;
}

#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return [self.arrData count];
    return [arrRecent count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecentSearchCell";
    
    RecentSearchCell *cell = (RecentSearchCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecentSearchCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    cell.lblContent.text = [arrRecent objectAtIndex:indexPath.row];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
       return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [self makeSearch:@""];
//     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)makeSearch:(NSString*)keyword {

    
    START_LOADING;
    [[APIClient sharedClient] searchByKeyWord:keyword type:@"2" latitude:@"" longitude:@"" distance:@"" total:@"-1" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        SearchResultViewController *vc =[[SearchResultViewController alloc] initWithNibName:@"SearchResultViewController" bundle:nil];
        vc.searchType = SearchByCondition ;
        
        
        vc.arrData = [APIClient parserListRestaunt:responseObject];
       // vc.arrData = gArrRestaurant;
        if([vc.arrData count]==0)
               [Util showMessage:@"No result found" withTitle:@"Notice"];
         else
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];

}



@end
