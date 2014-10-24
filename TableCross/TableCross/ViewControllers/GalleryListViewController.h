//
//  GalleryListViewController.h
//  TableCross
//
//  Created by DANGLV on 24/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "GalleryDetailViewController.h"

@interface GalleryListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tblImage;

@property (retain,nonatomic) NSMutableArray *arrData;
@property (retain,nonatomic) NSString *restautId;

@end
