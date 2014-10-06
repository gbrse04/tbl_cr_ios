//
//  CalloutBusView.m
//  Bus
//
//  Created by duc le on 3/21/14.
//
//

#import "CalloutBusView.h"


@implementation CalloutBusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    self.clipsToBounds = NO;
    [_bgImgView setImage:[[UIImage imageNamed:@"bg_callout"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 40, 10)]];
}

- (IBAction)chooseThisBus:(id)sender
{
//    if(_delegate && [_delegate respondsToSelector:@selector(chooseThisRestaurant:)])
//        [_delegate chooseThisRestaurant:_restaurant];
}

-(void)setDataWithRestaurant
{
    _nameLbl.text = _restaurant.name;
    _phoneLbl.text = _restaurant.phone;
    _addressLbl.text = _restaurant.address;
}

@end
