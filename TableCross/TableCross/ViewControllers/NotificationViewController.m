//
//  NotificationViewController.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "NotificationViewController.h"
#import "RestaurantDetailViewController.h"
#import "HomeViewController.h"
#import "RestaurantDetailViewController.h"




@interface NotificationViewController ()
{
    NSArray *arrOnePage;
    NSInteger currentPage;
}

@end

@implementation NotificationViewController

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
    [self setupTitle:@"お知らせ" isShowSetting:TRUE andBack:FALSE];
    [self addBackLocationButton];
    [self reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTIFY_RELOAD_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:NOTIF_LOGOUT object:nil];

}

-(void)viewDidAppear:(BOOL)animated
{
  
    [super viewDidAppear:animated];
}
- (void)logout {
    if(self.arrNotification)
        [self.arrNotification removeAllObjects];
    [self.tblNotification reloadData];
}
- (void)reloadData {
    
    if(self.arrNotification)
        [self.arrNotification removeAllObjects];
    [self.tblNotification reloadData];
    currentPage= 0;
   [[[super.tabBarController.viewControllers objectAtIndex:0] tabBarItem] setBadgeValue:nil];
    if(gIsLogin)
    {
        [self getDataWithPage:currentPage];
        
        [self getUserInfo];
   }
    
}


-(void)getUserInfo {
    
    START_LOADING;
    [[APIClient sharedClient] getUserInfoWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            [Util setValue:[responseObject objectForKey:@"mobile"] forKey:KEY_PHONE];
            [Util setValue:[responseObject objectForKey:@"userId"] forKey:KEY_USER_ID];
            [Util setValue:[responseObject objectForKey:@"point"] forKey:KEY_POINT];
            [Util setValue:[responseObject objectForKey:@"point"] forKey:KEY_TOTAL_MEAL];
            [Util setValue:[responseObject objectForKey:@"totalPoint"] forKey:KEY_TOTAL_MEAL_VIAAPP];
            [Util setValue:[responseObject objectForKey:@"totalUserShare"] forKey:KEY_TOTAL_SHARE];
            [Util setValue:[responseObject objectForKey:@"birthday"] forKey:KEY_BIRTHDAY];
            
        }
        STOP_LOADING;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
    }];
}

-(void)getDataWithPage:(NSInteger)page {
    
    START_LOADING;
    [[APIClient sharedClient] getListNotifyAllStart:[NSString stringWithFormat:@"%d",(int)page *NUMBER_RECORD_PER_PAGE] total:[NSString stringWithFormat:@"%d",NUMBER_RECORD_PER_PAGE] sucess:^(AFHTTPRequestOperation *operation, id responseObject) {
        STOP_LOADING;
        
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            arrOnePage =[responseObject objectForKey:@"items"];
            if([arrOnePage count] >0)
            {
                if(!self.arrNotification)
                    self.arrNotification = [[NSMutableArray alloc] init];
                [self.arrNotification addObjectsFromArray:arrOnePage];
                [self.tblNotification reloadData];
                
               
            }
        }
        else
            [Util showError:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) onClickLeftButton {
    
}
#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.arrNotification count];
//    return  5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"NotificationCell";
    
    NotificationCell *cell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *dict =[self.arrNotification objectAtIndex:indexPath.row];
    
    cell.lblTitle.text = [dict objectForKey:@"notifyShort"];
    
    cell.lblTitle.numberOfLines=0;
    [cell.lblTitle sizeToFit];
    cell.lblTime.text = [dict objectForKey:@"notifyDate"];
    
    [Util moveDow:cell.lblContent  offset:cell.lblTitle.frame.size.height - 20];
//    cell.lblContent.text= [dict objectForKey:@"notifyLong"];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat  heightContent = [[[self.arrNotification objectAtIndex:indexPath.row] objectForKey:@"notifyShort"] heightOfTextViewToFitWithFont:[UIFont boldSystemFontOfSize:14.0] andWidth:303];
    return heightContent + 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantDetailViewController *detail=[[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
//    detail.dictDetail = [self.arrNotification objectAtIndex:indexPath.row];
    
    NSString *resId = [((NSDictionary*)[self.arrNotification objectAtIndex:indexPath.row]) objectForKey:@"restaurantId"];
    detail.restaurantId = resId;
    if([resId integerValue]>0)
     [self.navigationController pushViewController:detail animated:YES];
    
}

@end
