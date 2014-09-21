//
//  ChooseRegionViewController.h
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "ComboBoxCell.h"
#import "ComboBox.h"
#import "RegisterViewController.h"

@interface ChooseRegionViewController : BaseViewController<ComBoxDelegate>

@property (nonatomic,retain) NSMutableArray *arrRegion;


@end
