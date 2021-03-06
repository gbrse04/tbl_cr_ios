//
//  NotificationDetailViewController.m
//  TableCross
//
//  Created by DANGLV on 25/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "NotificationDetailViewController.h"

@interface NotificationDetailViewController ()

@end

@implementation NotificationDetailViewController

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
    
    [self setupTitle:@"お知らせ" isShowSetting:YES andBack:YES];
    [self bindData];
}
-(void)bindData {
    
    if(self.dictDetail)
    {
        self.lblTitle.text = [self.dictDetail objectForKey:@"notifyShort"];
        self.lblDateTime.text = [self.dictDetail objectForKey:@"notifyDate"];
         self.lblFullContent.text = [self.dictDetail objectForKey:@"notifyLong"];
        
        self.lblTitle.numberOfLines= 0;
        [self.lblTitle sizeToFit];
        
        [self.lblFullContent setFrame:CGRectMake(self.lblFullContent.frame.origin.x, self.lblTitle.frame.origin.y + self.lblTitle.frame.size.height + 5, self.lblFullContent.frame.size.width, self.lblFullContent.frame.size.height)];
        self.lblFullContent.numberOfLines = 0;
        [self.lblFullContent sizeToFit];
      
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
