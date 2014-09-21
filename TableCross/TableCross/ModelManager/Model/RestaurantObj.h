//
//  OrderObj.h
//  TableCross
//
//  Created by DANGLV on 20/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantObj : NSObject

@property (nonatomic,retain) NSString *restaurantId;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *openHour;

@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString  *latitude;
@property (nonatomic,retain) NSString *longitude;
@property (nonatomic,retain) NSString *imageUrl;
@property (nonatomic,retain) NSString *website;
@property (nonatomic,retain) NSString *phone;
@property (nonatomic,retain) NSString *orderDate;

-(id)initWithDict:(NSDictionary*)dict;

@end
