//
//  GalleryDetailViewController.h
//  TableCross
//
//  Created by DANGLV on 24/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"

@interface GalleryDetailViewController : BaseViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (retain, nonatomic)  UIScrollView *scrollMain;

@property (retain,nonatomic) NSMutableArray *arrData;

@property (assign,nonatomic) NSInteger  currentPage;

@end
