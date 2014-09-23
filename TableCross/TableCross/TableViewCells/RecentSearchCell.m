//
//  RecentSearchCell.m
//  TableCross
//
//  Created by DANGLV on 23/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RecentSearchCell.h"

@implementation RecentSearchCell

- (void)awakeFromNib
{
    // Initialization code
    [self.lblContent setShouldUnderline:TRUE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
