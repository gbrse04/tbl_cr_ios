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
    NSArray *arrDisplay;
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
    
//    arrRecent = [[NSMutableArray alloc] initWithObjects:@"Pizza",@"Hotdog",@"KFC",@"Humberger", nil];
    
    [self displayRecentSearch];
}

-(void)displayRecentSearch {
    
    arrRecent = [Util getRecentSearch];
    arrDisplay = [[arrRecent reverseObjectEnumerator] allObjects];
    [self.tblRecentSearch reloadData];
//    self.txtSearch.text = @"店";
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"条件から探す";
    [self.navigationController.navigationBar.backItem setTitle:@"検索"];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    self.navigationItem.title = @"履歴検索";
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
    if([arrDisplay count] <10)
        return [arrDisplay count];
    else
        return 10;
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
   
    cell.lblContent.text = [arrDisplay objectAtIndex:indexPath.row];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
       return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [self makeSearch:[arrDisplay objectAtIndex:indexPath.row]];
//     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark - SEARCH FUNCTIONS


-(void)makeSearch:(NSString*)keyword {


    START_LOADING;
    [[APIClient sharedClient] searchByKeyWord:keyword type:@"2" latitude:@"" longitude:@"" distance:@"" total:@"-1" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        
        NSLog(@"Response :%@ ",responseObject);
        SearchResultViewController *vc =[[SearchResultViewController alloc] initWithNibName:@"SearchResultViewController" bundle:nil];
        vc.searchType = SearchByCondition ;
        
        
        vc.arrData = [APIClient parserListRestaunt:responseObject];
       // vc.arrData = gArrRestaurant;
        if([vc.arrData count]==0)
               [Util showMessage:@"No result found" withTitle:@"Notice"];
         else
         {
             if(![arrRecent containsObject:self.txtSearch.text])
             [arrRecent addObject:self.txtSearch.text];
              [Util storeRecentSearch:arrRecent];
             [self displayRecentSearch];
          [self.navigationController pushViewController:vc animated:YES];
         }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];

}



@end
