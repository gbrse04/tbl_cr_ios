//
//  NotificationDetailViewController.h
//  TableCross
//
//  Created by DANGLV on 25/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"

@interface NotificationDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lblFullContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (retain,nonatomic) NSDictionary *dictDetail;
@end
