//
//  CalloutBusView.h
//  Bus
//
//  Created by duc le on 3/21/14.
//
//

#import <UIKit/UIKit.h>
#import "RestaurantObj.h"

@protocol CalloutBusViewDelegate;
@interface CalloutBusView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *openingHourLbl;

@property (retain, nonatomic) RestaurantObj* restaurant;
@property (retain, nonatomic) IBOutlet UIImageView *bgImgView;

-(void)setDataWithRestaurant;

@property (unsafe_unretained,nonatomic) id<CalloutBusViewDelegate> delegate;
- (IBAction)chooseThisBus:(id)sender;
@end

@protocol CalloutBusViewDelegate <NSObject>

-(void)chooseThisRestaurant:(RestaurantObj*)restaurant;

@end