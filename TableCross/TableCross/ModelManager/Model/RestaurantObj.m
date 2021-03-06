//
//  OrderObj.m
//  TableCross
//
//  Created by TableCross on 20/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "RestaurantObj.h"
#import "Validator.h"

@implementation RestaurantObj

-(id)initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    
    if(dict)
    {
        self.restaurantId = [Validator getSafeString:[dict objectForKey:@"restaurantId"]];
        self.openHour = [Validator getSafeString:[dict objectForKey:@"openHour"]];
        self.name = [Validator getSafeString:[dict objectForKey:@"restaurantName"]];
        self.address = [Validator getSafeString:[dict objectForKey:@"address"]];
        self.website = [Validator getSafeString:[dict objectForKey:@"website"]];
        self.phone = [Validator getSafeString:[dict objectForKey:@"phone"]];
        self.latitude = [Validator getSafeString:[dict objectForKey:@"latitude"]];
        self.longitude = [Validator getSafeString:[dict objectForKey:@"longitude"]];
        self.descriptionRestaurant = [Validator getSafeString:[dict objectForKey:@"description"]];
        self.shortDescription = [Validator getSafeString:[dict objectForKey:@"shortDescription"]];
        self.imageUrl = [Validator getSafeString:[dict objectForKey:@"imageUrl"]];
        
        if(self.imageUrl)
            self.imageUrl = [self.imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        self.orderDate = [Validator getSafeString:[dict objectForKey:@"orderDate"]];
        self.shareLink = [Validator getSafeString:[dict objectForKey:@"shareLink"]];
        self.orderWebUrl = [Validator getSafeString:[dict objectForKey:@"orderWebUrl"]];
        self.numberOrder = [Validator getSafeString:[dict objectForKey:@"point"]];

    }
    
    return self;
    
    
}
@end
