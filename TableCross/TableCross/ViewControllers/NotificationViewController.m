//
//  NotificationViewController.m
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "NotificationViewController.h"
#import "RestaurantDetailViewController.h"
#import "HomeViewController.h"
@interface NotificationViewController ()

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
   
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onClickLeftButton:)];
    //self.navigationItem.leftBarButtonItem = leftButton;
    [self setupTitle:@"お知らせ" isShowSetting:TRUE andBack:FALSE];
    
    // Set Badge number
    [[super.tabBarController.viewControllers objectAtIndex:0] tabBarItem].badgeValue = @"5";

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
//    return [self.arrNotification count];
    return  5;
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
    
//    cell.lblCompany.text=item.companyName;
//    cell.lblProgress.text=item.status;
//    cell.lblTime.text=[LMDateTimeUtility reformat:item.startDate inputFormat:@"yyyy-MM-dd HH:mm" withFormat:@"hh:mm aa"];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    RestaurantDetailViewController *detail=[[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:detail animated:YES];
}

@end
