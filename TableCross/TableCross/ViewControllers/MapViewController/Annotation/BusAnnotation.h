//
//  BusAnnotation.h
//  Bus
//
//  Created by MAC on 2/11/14.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RestaurantObj.h"

@interface BusAnnotation : NSObject<MKAnnotation>
{

}

@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (weak, nonatomic) RestaurantObj* restaurant;

@end
