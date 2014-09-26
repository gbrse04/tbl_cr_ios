//
//  RestaurantCellTableViewCell.m
//  TableCross
//
//  Created by TableCross on 15/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RestaurantCellTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

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
    
    if(obj)
    {
                
        [self.imgRestaurant setImageWithURL:[NSURL URLWithString:obj.imageUrl] placeholderImage:[UIImage imageNamed:@"img_restaurant"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
           
            if(image)
               [self.imgRestaurant setImage:image];
        }];
        
        self.lblAddress.text = obj.address;
        self.lblName.text =obj.name;
        self.lblDateTime.text = obj.orderDate;
        if([obj.orderDate isEqualToString:@""])
        {
            [self.imgClock setHidden:TRUE];
            [Util moveUp:self.lblNumberMeal offset:20];
             [Util moveUp:self.imgNumberMeal offset:20];
        }
        self.lblNumberMeal.text =  obj.numberOrder;
        
        self.lblDescription.text = obj.description;
        self.lblDescription.numberOfLines = 0;
        [self.lblDescription sizeToFit];
        
    }
}
@end
