//
//  SearchBySpecifyViewController.m
//  TableCross
//
//  Created by DangLV on 10/1/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//

#import "SearchBySpecifyViewController.h"

@interface SearchBySpecifyViewController ()
{
    NSString *currentTitle;
}

@end

@implementation SearchBySpecifyViewController

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
  
     [self makeSearch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super  viewWillAppear:animated];
    
    if(self.currentDict)
    {
        currentTitle=[self.currentDict objectForKey:@"name"];
        [self setupTitle:currentTitle isShowSetting:YES andBack:YES andBackTitle:@"戻る"];
        [self.navigationController.navigationBar.backItem setTitle:@"戻る"];
    }
    else
    {
        currentTitle = kSearchSpecific;
        [self setupTitle:currentTitle isShowSetting:YES andBack:YES];
        
    }
    
    [self addSearchAllInParentCategory];


  }

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
 
    self.navigationItem.title  =currentTitle;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if(currentTitle.length>6)
        self.navigationItem.title = @"戻る";}


-(void)makeSearch{
    
    if(!self.categoryId)
        self.categoryId= @"";
    
    START_LOADING;
    [[APIClient sharedClient] getRestaurantByCategory:self.categoryId withsucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue])
            
        {
            self.arrData = [responseObject objectForKey:@"items"];
            [self.tblData reloadData];
        }
        else
            [Util showError:responseObject];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
        
    }];
    
    
 }


#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrData count];
    //    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    NSDictionary *dict =(NSDictionary*)[self.arrData objectAtIndex:indexPath.row];
    
    cell.textLabel.text =[dict valueForKey:@"name"];
    if(![[dict objectForKey:@"isChild"] boolValue])
   
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict =(NSDictionary*)[self.arrData objectAtIndex:indexPath.row];
    // Has child
    if(![[dict objectForKey:@"isChild"] boolValue])
    {
        SearchBySpecifyViewController *vc =[[SearchBySpecifyViewController alloc] initWithNibName:@"SearchBySpecifyViewController" bundle:nil];
        vc.categoryId = [[dict objectForKey:@"id"] stringValue];
        vc.currentDict = dict;
        if(self.currentDict)
        self.navigationItem.title =[self.currentDict objectForKey:@"name"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    // No child
    else
    {
        [self makeSearch:[dict valueForKey:@"id"]];
    }
}

- (void)addSearchAllInParentCategory {
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setTitle:@"閉じる" forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(searchParent) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    CGSize expectedLabelSize = [[Util valueForKey:KEY_AREA_NAME] sizeWithFont:[UIFont systemFontOfSize:14.0]];
    settingBtn.frame =CGRectMake(0, 0, expectedLabelSize.width+5, expectedLabelSize.height);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:settingBtn] ;
    self.navigationItem.rightBarButtonItem= backButton;
}

- (void)searchParent {
    
    [self makeSearch:[[self.currentDict objectForKey:@"id"] stringValue]];
}



-(void)makeSearch:(NSString*)categoryId {
    
    START_LOADING;
    [[APIClient sharedClient] searchByKeyWord:@"" type:@"3" latitude:@"" longitude:@"" distance:@"" total:@"-1" category:categoryId withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        
        NSLog(@"Response :%@ ",responseObject);
        SearchResultViewController *vc =[[SearchResultViewController alloc] initWithNibName:@"SearchResultViewController" bundle:nil];
        vc.searchType = SearchByCC ;
        
        
        vc.arrData = [APIClient parserListRestaunt:responseObject];
        // vc.arrData = gArrRestaurant;
        if([vc.arrData count]==0)
                        [Util showMessage:msg_no_result withTitle:kAppNameManager];
        else
        {
            self.navigationItem.title = @"戻る";
            [self.navigationController.navigationBar.backItem setTitle:@"戻る"];

            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    
}

@end
