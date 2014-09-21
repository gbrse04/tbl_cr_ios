//
//  NotificationViewController.h
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "NotificationCell.h"

@interface NotificationViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tblNotification;

@property (nonatomic,retain) NSMutableArray *arrNotification;

@end
