//
//  SearchLocationViewController.m
//  TableCross
//
//  Created by TableCross on 16/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SearchLocationViewController.h"
#import "Config.h"

@interface SearchLocationViewController ()

@end

@implementation SearchLocationViewController

@synthesize segmented,tblResult,txtSearch,lblGuide;

int numberResult;

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
    [self setupTitle:@"履現在地から探す歴" isShowSetting:YES andBack:YES];
    [self.txtSearch setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    numberResult = 0;
    [tblResult reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super  viewWillAppear:animated];
    // Set title
    self.navigationItem.title=@"履現在地から探す歴";
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.title=@"現在地結果";
}

#pragma mark - Internal Functions

-(void)setupView {
    
    
    
    NSArray *arrTab = @[@{@"text":@"1.5km", @"icon":[UIImage imageNamed:@"square"]},@{@"text":@"3km", @"icon":[UIImage imageNamed:@"square"]},@{@"text":@"10km", @"icon":[UIImage imageNamed:@"square"]}];
    
    
    segmented = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 50, 280, 30)
                                                         items:arrTab
                                                  iconPosition:IconPositionLeft
                                             andSelectionBlock:^(NSUInteger segmentIndex) {
                                                 
                                                 NSString *distance = @"1.5";
                                                 if(segmentIndex==0)
                                                     distance = @"1.5";
                                                 else if(segmentIndex==1)
                                                     distance = @"3";
                                                 else if(segmentIndex==2)
                                                     distance = @"10";
                                                 
                                                 [self makeSearch:self.txtSearch.text   distance:distance];
                                                 
                                                 
                                                 
                                                 
                                             }
                                                iconSeparation:0];
    
    
    
    segmented.color = [UIColor whiteColor];
    segmented.borderWidth = 1.0;
    segmented.borderColor = kColorOrange;
    segmented.selectedColor = kColorOrange;
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor colorWithRed:70.0/255.0 green:70.0f/255.0 blue:70.0f/255.0 alpha:1]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    if([self.view viewWithTag:111])
        [((UIView*)[self.view viewWithTag:111]) removeFromSuperview];
    
    [segmented setTag:111];
    
    [self.view addSubview:segmented];
    [segmented setEnabled:YES forSegmentAtIndex:0];
    
}

#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.arrData count];
//    return numberResult;

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
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantDetailViewController *detail=[[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
    
    detail.backTitle  = @"現在地結果";
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark  - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(![self.txtSearch.text isEqualToString:@""])
       numberResult =  10;
  else
       numberResult = 0;
    
       [tblResult reloadData];
        [self.lblGuide setHidden:YES];
        [self setupView];
    return  YES;
    
}

-(void)makeSearch:(NSString*)keyword distance:(NSString*)distance{
    

    START_LOADING;
    [[APIClient sharedClient] searchByKeyWord:keyword type:@"2" latitude:[NSString stringWithFormat:@"%f",gCurrentLatitude] longitude:[NSString stringWithFormat:@"%f",gCurrentLongitude] distance:distance total:@"-1" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue])
            
        {
            self.arrData = [APIClient parserListRestaunt:responseObject];
            if([self.arrData count]== 0)
            {
                    [Util showMessage:@"No result found" withTitle:@"Result"];
                    return ;
            }
            
            [tblResult reloadData];
            [self.lblGuide setHidden:YES];
            [self setupView];
        }
        else
            [Util showError:responseObject];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    
}



@end
