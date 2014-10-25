//
//  RestaurantCellTableViewCell.m
//  TableCross
//
//  Created by TableCross on 15/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RestaurantCellTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "NSString+TextSize.h"


@implementation RestaurantCellTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillData:(RestaurantObj*)obj {
    
    self.rowHeight = 0;
    
    if(obj)
    {
        
        [self.imgRestaurant setImageWithURL:[NSURL URLWithString:obj.imageUrl] placeholderImage:[UIImage imageNamed:@"img_restaurant"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if(image)
               [self.imgRestaurant setImage:image];
        }];
        
        self.lblAddress.text = obj.address;
        self.lblName.text =obj.name;
        self.lblName.numberOfLines = 0;
        [self.lblName sizeToFit];
        self.lblAddress.numberOfLines= 0;
        [self.lblAddress sizeToFit];
        self.lblDateTime.text = obj.orderDate;
        
//        
        CGFloat  heightName = [obj.name heightOfTextViewToFitWithFont:[UIFont boldSystemFontOfSize:16.0] andWidth:176];
        
        
        [Util moveDow:self.lblAddress offset:heightName - 38];
        
        CGFloat  heightAddress = [obj.address heightOfTextViewToFitWithFont:[UIFont systemFontOfSize:15.0] andWidth:176];
        
        CGFloat  heightShortDesc = [obj.shortDescription heightOfTextViewToFitWithFont:[UIFont systemFontOfSize:16.0] andWidth:300];
        
        CGFloat heightFixed = self.lblNumberMeal.frame.size.height;
        if(![obj.orderDate isEqualToString:@""])
        {
            [self.imgClock setHidden:FALSE];
            heightFixed += self.lblDateTime.frame.size.height;
            
            [Util moveDow:self.lblNumberMeal offset:30];
            [Util moveDow:self.imgNumberMeal offset:30];
            self.viewDateTime.frame = CGRectMake(self.viewDateTime.frame.origin.x, self.viewDateTime.frame.origin.y, self.viewDateTime.frame.size.width, self.viewDateTime.frame.size.height + self.lblNumberMeal.frame.size.height);
            }
        else {
            
            [self.imgClock setHidden:TRUE];
        }
        
        [Util moveDow:self.viewDateTime  offset:(heightAddress + heightName  - 60)];
        
        if((heightAddress + heightName + heightFixed - 125)>0)
        [Util moveDow:self.lblDescription offset:(heightAddress + heightName + heightFixed - 125)];
        
        self.lblNumberMeal.text =  obj.numberOrder;
        self.lblDescription.text = obj.shortDescription;
        self.lblDescription.numberOfLines = 0;
        [self.lblDescription sizeToFit];
        
        self.rowHeight =  (heightName +heightName +heightFixed )>126? (heightAddress + heightName + heightShortDesc + heightFixed):heightShortDesc +126;
        
    }
}
-(void)fillData:(RestaurantObj*)obj isShowContent:(BOOL)showContent {
    [self fillData:obj];
    if(!showContent)
    {
        self.lblDescription.text = @"";
        [self.lblDescription setHidden:YES];
    }
    
}

-(CGFloat)getHeightForRow {
    
    return self.rowHeight;
}
@end
