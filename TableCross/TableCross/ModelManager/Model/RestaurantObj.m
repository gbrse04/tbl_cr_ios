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
        self.restaurantId = [Validator getSafeString:[dict objectForKey:@""]];
        self.openHour = [Validator getSafeString:[dict objectForKey:@""]];
                self.name = [Validator getSafeString:[dict objectForKey:@""]];
                self.address = [Validator getSafeString:[dict objectForKey:@""]];
                self.website = [Validator getSafeString:[dict objectForKey:@"website"]];
                self.phone = [Validator getSafeString:[dict objectForKey:@"phone"]];
                self.latitude = [Validator getSafeString:[dict objectForKey:@"latitude"]];
                self.longitude = [Validator getSafeString:[dict objectForKey:@"longitude"]];
                self.description = [Validator getSafeString:[dict objectForKey:@"description"]];
                self.imageUrl = [Validator getSafeString:[dict objectForKey:@"imageUrl"]];
                self.orderDate = [Validator getSafeString:[dict objectForKey:@"orderDate"]];
        
        
    }
    
    return self;
    
    
}
@end
