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

}

-(void)viewDidAppear:(BOOL)animated
{
    if(self.arrNotification)
       [self.arrNotification removeAllObjects];
    currentPage= 0;
    [super viewDidAppear:animated];
    if(gIsLogin)
     [self getDataWithPage:currentPage];
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
    cell.lblTime.text = [dict objectForKey:@"notifyDate"];
    cell.lblContent.text= [dict objectForKey:@"notifyLong"];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationDetailViewController *detail=[[NotificationDetailViewController alloc] initWithNibName:@"NotificationDetailViewController" bundle:nil];
    detail.dictDetail = [self.arrNotification objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
